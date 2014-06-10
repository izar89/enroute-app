//
//  CaptureManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 08/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "CaptureManager.h"

#define VIDEO_FILE @"capture.mov"
#define AUDIO_FILE @"capture.m4a"

@interface CaptureManager ()
@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;
@property (nonatomic, strong) AVCaptureConnection *audioConnection;
@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterVideoInput;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterAudioInput;
@property (nonatomic, strong) dispatch_queue_t writingQueue;
@property (nonatomic, assign) BOOL recording;
@property (nonatomic, assign) BOOL readyToRecordAudio;
@property (nonatomic, assign) BOOL readyToRecordVideo;
@property (nonatomic, assign) BOOL recordingWillBeStarted;
@property (nonatomic, assign) BOOL recordingWillBeStopped;

@end

@implementation CaptureManager

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
    // Set up serial queue for writing
	self.writingQueue = dispatch_queue_create("WritingQueue", DISPATCH_QUEUE_SERIAL);
    
    // Set up Session
    self.captureSession = [[AVCaptureSession alloc] init];
    
    NSError *error;
    
    // Set up video
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
    
    // Set up audio
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:nil];
    if ([self.captureSession canAddInput:audioInput]){
        [self.captureSession addInput:audioInput];
    }
	AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
	dispatch_queue_t audioCaptureQueue = dispatch_queue_create("AudioQueue", DISPATCH_QUEUE_SERIAL);
	[audioOutput setSampleBufferDelegate:self queue:audioCaptureQueue];
	if ([self.captureSession canAddOutput:audioOutput])
		[self.captureSession addOutput:audioOutput];
	self.audioConnection = [audioOutput connectionWithMediaType:AVMediaTypeAudio];
    
	// Start running session so preview is available
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureSessionStoppedRunningNotification:) name:AVCaptureSessionDidStopRunningNotification object:self.captureSession];
    
    if (!self.captureSession.isRunning){
        [self.captureSession startRunning];
    }
    
    // Set up preview layer
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.previewLayer.frame = self.previewView.bounds;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [[self.previewLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
        [self.previewView.layer addSublayer:self.previewLayer];
    });
}

//// Re-enable capture session if not currently running
//- (void)viewWillAppear:(BOOL)animated
//{
//	if (![self.captureSession isRunning]) {
//		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//			[self.captureSession startRunning];
//		});
//	}
//}
//
//// Stop running capture session when this view disappears
//- (void)viewWillDisappear:(BOOL)animated
//{
//	if ([self.captureSession isRunning]) {
//		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//			[self.captureSession stopRunning];
//		});
//	}
//}

- (void)captureSessionStoppedRunningNotification:(NSNotification *)notification
{
	dispatch_async(self.writingQueue, ^{
		if (self.recording) {
			[self stopRecording];
		}
	});
}

#pragma mark - Start/Stop Video Recording
- (void)startVideoRecording
{
    dispatch_async(self.writingQueue, ^{
        
		if ( self.recordingWillBeStarted || self.recording ) return;
        
		self.recordingWillBeStarted = YES;
        
		// Recording will begin
        if ([self.delegate respondsToSelector:@selector(recordingWillBegin)]) {
            [self.delegate recordingWillBegin];
        }
        
		// Delete the old movie file if it exists
		[[NSFileManager defaultManager] removeItemAtURL:[self videoOutputURL] error:nil];
        
		// Create an asset writer
        NSError *error;
        self.assetWriter = [[AVAssetWriter alloc] initWithURL:[self videoOutputURL] fileType:AVFileTypeQuickTimeMovie error:&error];
        if (error){
            NSLog(@"%@", error);
        }
	});
}

- (void)stopRecording
{
    dispatch_async(self.writingQueue, ^{
		
        NSLog(@"[CaptureManager] stopRecording");
        
		if ( self.recordingWillBeStopped || (self.recording == NO) )
			return;
		
		self.recordingWillBeStopped = YES;
		
        // recordingWillFinish
		if ([self.delegate respondsToSelector:@selector(recordingWillFinish)]) {
            [self.delegate recordingWillFinish];
        }
        
//		if ([self.assetWriter finishWriting]) {
//			self.assetWriterVideoInput = nil;
//			self.assetWriterAudioInput = nil;
//			self.assetWriter = nil;
//			
//			self.readyToRecordVideo = NO;
//			self.readyToRecordAudio = NO;
//			
//			[self saveMovieToCameraRoll];
//		}
//		else {
//			NSLog(@"%@", [self.assetWriter error]);
//		}
        
        [self.assetWriter finishWritingWithCompletionHandler:^{
            self.assetWriter = nil;
            [self saveMovieToCameraRoll];
        }];
        self.assetWriterVideoInput = nil;
        self.assetWriterAudioInput = nil;
        
        self.readyToRecordVideo = NO;
        self.readyToRecordAudio = NO;
	});
}

- (void)saveMovieToCameraRoll
{
	ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
	[library writeVideoAtPathToSavedPhotosAlbum:[self videoOutputURL]
								completionBlock:^(NSURL *assetURL, NSError *error) {
									if (error)
										NSLog(@"%@", error);
									else
										[[NSFileManager defaultManager] removeItemAtURL:[self videoOutputURL] error:nil];
									
									dispatch_async(self.writingQueue, ^{
										self.recordingWillBeStopped = NO;
										self.recording = NO;
										
                                        if ([self.delegate respondsToSelector:@selector(recordingFinished:)]) {
                                            [self.delegate recordingFinished:[self videoOutputURL]];
                                        }
									});
								}];
}

#pragma mark - Capture
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer);
    
	CFRetain(sampleBuffer);
	CFRetain(formatDescription);
	dispatch_async(self.writingQueue, ^{
        
		if ( self.assetWriter ) {
            
			BOOL wasReadyToRecord = (self.readyToRecordAudio && self.readyToRecordVideo);
			
			if (connection == self.videoConnection) {
				
				// Initialize the video input if this is not done yet
				if (!self.readyToRecordVideo)
					self.readyToRecordVideo = [self setupAssetWriterVideoInput:formatDescription];
				
				// Write video data to file
				if (self.readyToRecordVideo && self.readyToRecordAudio)
					[self writeSampleBuffer:sampleBuffer ofType:AVMediaTypeVideo];
			}
			else if (connection == self.audioConnection) {
				
				// Initialize the audio input if this is not done yet
				if (!self.readyToRecordAudio)
					self.readyToRecordAudio = [self setupAssetWriterAudioInput:formatDescription];
				
				// Write audio data to file
				if (self.readyToRecordAudio && self.readyToRecordVideo)
					[self writeSampleBuffer:sampleBuffer ofType:AVMediaTypeAudio];
			}
			
			BOOL isReadyToRecord = (self.readyToRecordAudio && self.readyToRecordVideo);
			if ( !wasReadyToRecord && isReadyToRecord ) {
				self.recordingWillBeStarted = NO;
				self.recording = YES;
                if ([self.delegate respondsToSelector:@selector(recordingBegan)]) {
                    [self.delegate recordingBegan];
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

- (BOOL) setupAssetWriterAudioInput:(CMFormatDescriptionRef)currentFormatDescription
{
    const AudioStreamBasicDescription *currentASBD = CMAudioFormatDescriptionGetStreamBasicDescription(currentFormatDescription);
    
	size_t aclSize = 0;
	const AudioChannelLayout *currentChannelLayout = CMAudioFormatDescriptionGetChannelLayout(currentFormatDescription, &aclSize);
	NSData *currentChannelLayoutData = nil;
	
	// AVChannelLayoutKey must be specified, but if we don't know any better give an empty data and let AVAssetWriter decide.
	if ( currentChannelLayout && aclSize > 0 )
		currentChannelLayoutData = [NSData dataWithBytes:currentChannelLayout length:aclSize];
	else
		currentChannelLayoutData = [NSData data];
	
	NSDictionary *audioCompressionSettings = [NSDictionary dictionaryWithObjectsAndKeys:
											  [NSNumber numberWithInteger:kAudioFormatMPEG4AAC], AVFormatIDKey,
											  [NSNumber numberWithFloat:currentASBD->mSampleRate], AVSampleRateKey,
											  [NSNumber numberWithInt:64000], AVEncoderBitRatePerChannelKey,
											  [NSNumber numberWithInteger:currentASBD->mChannelsPerFrame], AVNumberOfChannelsKey,
											  currentChannelLayoutData, AVChannelLayoutKey,
											  nil];
	if ([self.assetWriter canApplyOutputSettings:audioCompressionSettings forMediaType:AVMediaTypeAudio]) {
		self.assetWriterAudioInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeAudio outputSettings:audioCompressionSettings];
		self.assetWriterAudioInput.expectsMediaDataInRealTime = YES;
		if ([self.assetWriter canAddInput:self.assetWriterAudioInput])
			[self.assetWriter addInput:self.assetWriterAudioInput];
		else {
			NSLog(@"Couldn't add asset writer audio input.");
            return NO;
		}
	}
	else {
		NSLog(@"Couldn't apply audio output settings.");
        return NO;
	}
    
    return YES;
}

- (void) writeSampleBuffer:(CMSampleBufferRef)sampleBuffer ofType:(NSString *)mediaType
{
    NSLog(@"self.assetWriter.status: %li", (long)self.assetWriter.status);
    
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
		} else if (mediaType == AVMediaTypeAudio) {
			if (self.assetWriterAudioInput.readyForMoreMediaData) {
				if (![self.assetWriterAudioInput appendSampleBuffer:sampleBuffer]) {
					NSLog(@"3) %@",[self.assetWriter error]);
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

- (NSURL *)audioOutputURL
{
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *filePath = [tmpDirectory stringByAppendingPathComponent:AUDIO_FILE];
	return [NSURL fileURLWithPath:filePath];
}

#pragma mark - AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    if ([self.delegate respondsToSelector:@selector(recordingBegan)]) {
        [self.delegate recordingBegan];
    }
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
	if (!error) {
        if ([self.delegate respondsToSelector:@selector(recordingFinished:)]) {
            [self.delegate recordingFinished:outputFileURL];
        }
	} else {
        NSLog(@"recordingDidFailWithError: %@", [error localizedDescription]);
        if ([self.delegate respondsToSelector:@selector(recordingDidFailWithError:)]) {
            [self.delegate recordingDidFailWithError:error];
        }
	}
}

@end