//
//  VideoCaptureManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 10/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "VideoCaptureManager.h"

#define VIDEO_FILE @"capture.mov"

@interface VideoCaptureManager()
@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;
@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterVideoInput;
@property (nonatomic, strong) dispatch_queue_t writingQueue;
@property (nonatomic, assign) BOOL recording;
@property (nonatomic, assign) BOOL readyToRecordVideo;
@property (nonatomic, assign) BOOL recordingWillBeStarted;
@property (nonatomic, assign) BOOL recordingWillBeStopped;
@end

@implementation VideoCaptureManager

- (id)init
{
    self = [super init];
    if (self != nil) {
        [self setUpCaptureSession];
    }
    return self;
}

- (id)initWithPreviewView:(UIView *)previewView
{
    self.previewView = previewView;
    return [self init];
}

#pragma mark - Configure Capture Session
- (void)setUpCaptureSession
{
    // Set up Session
    self.captureSession = [[AVCaptureSession alloc] init];
    
    // Set up video connection
    NSError *error;
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if ([self.captureSession canAddInput:videoInput]) {
        [self.captureSession addInput:videoInput];
    }
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    dispatch_queue_t videoCaptureQueue = dispatch_queue_create("VideoQueue", NULL);
    [videoOutput setSampleBufferDelegate:self queue:videoCaptureQueue];
    if ([self.captureSession canAddOutput:videoOutput])
		[self.captureSession addOutput:videoOutput];
    self.videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    self.videoConnection.videoOrientation = UIDeviceOrientationPortrait; // only portrait
    
    // Start session
    [self.captureSession startRunning];
    
    // Set up preview layer
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.previewLayer.frame = self.previewView.bounds;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [[self.previewLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
        [self.previewView.layer addSublayer:self.previewLayer];
    });
    
    // Set up serial queue for writing
	self.writingQueue = dispatch_queue_create("VideoWritingQueue", DISPATCH_QUEUE_SERIAL);
}

#pragma mark - Start/Stop Video Recording
- (void)startVideoRecording
{
    dispatch_async(self.writingQueue, ^{
        
        if ( self.recordingWillBeStarted || self.recording ) return;
		self.recordingWillBeStarted = YES;
        
		// Recording will begin
        if ([self.delegate respondsToSelector:@selector(videoRecordingWillBegin)]) {
            [self.delegate videoRecordingWillBegin];
        }
        
		// Delete the old audio file if it exists
		[[NSFileManager defaultManager] removeItemAtURL:[self videoOutputURL] error:nil];
        
		// Create an asset writer
        NSError *error;
        self.assetWriter = [[AVAssetWriter alloc] initWithURL:[self videoOutputURL] fileType:AVFileTypeAppleM4A error:&error];
        if (error){
            NSLog(@"%@", error);
        }
	});
}

- (void)stopVideoRecording
{
    dispatch_async(self.writingQueue, ^{
        
        if ( self.recordingWillBeStopped || !self.recording ) return;
		self.recordingWillBeStopped = YES;
        
        // audioRecordingWillFinish
		if ([self.delegate respondsToSelector:@selector(videoRecordingWillFinish)]) {
            [self.delegate videoRecordingWillFinish];
        }
        
        [self.assetWriter finishWritingWithCompletionHandler:^{
            self.assetWriter = nil;
            self.recordingWillBeStopped = NO;
            self.recording = NO;
            
            if ([self.delegate respondsToSelector:@selector(videoRecordingFinished:)]) {
                [self.delegate videoRecordingFinished:[self videoOutputURL]];
            }
        }];
        
        self.assetWriterVideoInput = nil;
        self.readyToRecordVideo = NO;
	});
}

#pragma mark - Capture
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer);
    
	CFRetain(sampleBuffer);
	CFRetain(formatDescription);
	dispatch_async(self.writingQueue, ^{
        
		if (self.assetWriter ){
            
			BOOL wasReadyToRecord = self.readyToRecordVideo;
			
			if(connection == self.videoConnection){
				
				// Initialize the video input if this is not done yet
				if (!self.readyToRecordVideo)
					self.readyToRecordVideo = [self setupAssetWriterVideoInput:formatDescription];
				
				// Write video data to file
				if (self.readyToRecordVideo)
					[self writeSampleBuffer:sampleBuffer ofType:AVMediaTypeVideo];
			}
						
			BOOL isReadyToRecord = self.readyToRecordVideo;
			if(!wasReadyToRecord && isReadyToRecord) {
				self.recordingWillBeStarted = NO;
				self.recording = YES;
                if ([self.delegate respondsToSelector:@selector(videoRecordingBegan)]) {
                    [self.delegate videoRecordingBegan];
                }
			}
		}
		CFRelease(sampleBuffer);
		CFRelease(formatDescription);
	});
}

- (BOOL) setupAssetWriterVideoInput:(CMFormatDescriptionRef)currentFormatDescription
{
    float bitsPerPixel;
	CMVideoDimensions dimensions = CMVideoFormatDescriptionGetDimensions(currentFormatDescription);
	int numPixels = dimensions.width * dimensions.height;
	int bitsPerSecond;
	
	// Assume that lower-than-SD resolutions are intended for streaming, and use a lower bitrate
	if ( numPixels < (640 * 480) )
		bitsPerPixel = 4.05; // This bitrate matches the quality produced by AVCaptureSessionPresetMedium or Low.
	else
		bitsPerPixel = 11.4; // This bitrate matches the quality produced by AVCaptureSessionPresetHigh.
	
	bitsPerSecond = numPixels * bitsPerPixel;
	
	NSDictionary *videoCompressionSettings = [NSDictionary dictionaryWithObjectsAndKeys:
											  AVVideoCodecH264, AVVideoCodecKey,
											  [NSNumber numberWithInteger:dimensions.width], AVVideoWidthKey,
											  [NSNumber numberWithInteger:dimensions.height], AVVideoHeightKey,
											  [NSDictionary dictionaryWithObjectsAndKeys:
											   [NSNumber numberWithInteger:bitsPerSecond], AVVideoAverageBitRateKey,
											   [NSNumber numberWithInteger:30], AVVideoMaxKeyFrameIntervalKey,
											   nil], AVVideoCompressionPropertiesKey,
											  nil];
	if ([self.assetWriter canApplyOutputSettings:videoCompressionSettings forMediaType:AVMediaTypeVideo]) {
		self.assetWriterVideoInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:videoCompressionSettings];
		self.assetWriterVideoInput.expectsMediaDataInRealTime = YES;
		//self.assetWriterVideoInput.transform = [self transformFromCurrentVideoOrientationToOrientation:self.referenceOrientation];
		if ([self.assetWriter canAddInput:self.assetWriterVideoInput])
			[self.assetWriter addInput:self.assetWriterVideoInput];
		else {
			NSLog(@"Couldn't add asset writer video input.");
            return NO;
		}
	}
	else {
		NSLog(@"Couldn't apply video output settings.");
        return NO;
	}
    
    return YES;
}

- (void) writeSampleBuffer:(CMSampleBufferRef)sampleBuffer ofType:(NSString *)mediaType
{
	if(self.assetWriter.status == AVAssetWriterStatusUnknown){
        if ([self.assetWriter startWriting]){
			[self.assetWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
		} else {
			NSLog(@"1) %@", [self.assetWriter error]);
		}
	}
	
	if(self.assetWriter.status == AVAssetWriterStatusWriting){
		if(mediaType == AVMediaTypeVideo){
			if (self.assetWriterVideoInput.readyForMoreMediaData) {
				if (![self.assetWriterVideoInput appendSampleBuffer:sampleBuffer]) {
                    NSLog(@"2) %@",[self.assetWriter error]);
				}
			}
		}
	}
}

#pragma mark - Destination URL
- (NSURL *)videoOutputURL
{
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *filePath = [tmpDirectory stringByAppendingPathComponent:VIDEO_FILE];
	return [NSURL fileURLWithPath:filePath];
}

@end
