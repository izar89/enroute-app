//
//  AudioCaptureManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 10/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "AudioCaptureManager.h"

@interface AudioCaptureManager()
@property (nonatomic, strong) FileManager *fileManager;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureConnection *audioConnection;
@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterAudioInput;
@property (nonatomic, strong) dispatch_queue_t writingQueue;
@property (nonatomic, assign) BOOL recording;
@property (nonatomic, assign) BOOL readyToRecordAudio;
@property (nonatomic, assign) BOOL recordingWillBeStarted;
@property (nonatomic, assign) BOOL recordingWillBeStopped;
@end

@implementation AudioCaptureManager

- (id)init
{
    self = [super init];
    if (self != nil) {
        [self setUpCaptureSession];
        self.fileManager = [[FileManager alloc] init];
        self.fileManager.delegate = self;
    }
    return self;
}

#pragma mark - Configure Capture Session
- (void)setUpCaptureSession
{
    // Set up Session
    self.captureSession = [[AVCaptureSession alloc] init];
    
    // Set up audio connection
    NSError *error;
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:&error];
    if ([self.captureSession canAddInput:audioInput]){
        [self.captureSession addInput:audioInput];
    }
	AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
	dispatch_queue_t audioCaptureQueue = dispatch_queue_create("AudioQueue", DISPATCH_QUEUE_SERIAL);
	[audioOutput setSampleBufferDelegate:self queue:audioCaptureQueue];
	if ([self.captureSession canAddOutput:audioOutput])
		[self.captureSession addOutput:audioOutput];
	self.audioConnection = [audioOutput connectionWithMediaType:AVMediaTypeAudio];

    // Start session
    [self.captureSession startRunning];
    
    // Set up serial queue for writing
	self.writingQueue = dispatch_queue_create("AudioWritingQueue", DISPATCH_QUEUE_SERIAL);
}

#pragma mark - Start/Stop Audio Recording
- (void)startAudioRecording
{
    dispatch_async(self.writingQueue, ^{
        
        if ( self.recordingWillBeStarted || self.recording ) return;
		self.recordingWillBeStarted = YES;
        
		// Recording will begin
        if ([self.delegate respondsToSelector:@selector(audioRecordingWillBegin)]) {
            [self.delegate audioRecordingWillBegin];
        }
        
		// Delete the old audio file if it exists
		[[NSFileManager defaultManager] removeItemAtURL:[self.fileManager audioTmpURL] error:nil];
        
		// Create an asset writer
        NSError *error;
        self.assetWriter = [[AVAssetWriter alloc] initWithURL:[self.fileManager audioTmpURL] fileType:AVFileTypeAppleM4A error:&error];
        if (error){
            NSLog(@"%@", error);
        }
	});
}

- (void)stopAudioRecording
{
    dispatch_async(self.writingQueue, ^{
        
        if ( self.recordingWillBeStopped || !self.recording ) return;
		self.recordingWillBeStopped = YES;
        
        // audioRecordingWillFinish
		if ([self.delegate respondsToSelector:@selector(audioRecordingWillFinish)]) {
            [self.delegate audioRecordingWillFinish];
        }
        
        [self.assetWriter finishWritingWithCompletionHandler:^{
            self.assetWriter = nil;
            self.assetWriterAudioInput = nil;
            self.readyToRecordAudio = NO;
            self.recordingWillBeStopped = NO;
            self.recording = NO;
            
            if ([self.delegate respondsToSelector:@selector(audioRecordingFinished:)]) {
                [self.delegate audioRecordingFinished:[self.fileManager audioTmpURL]];
            }
        }];
	});
}

#pragma mark - Capture
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer);
    
	CFRetain(sampleBuffer);
	CFRetain(formatDescription);
	dispatch_async(self.writingQueue, ^{
        
		if (self.assetWriter){
            
			BOOL wasReadyToRecord = self.readyToRecordAudio;
            if(connection == self.audioConnection){
				
				// Initialize the audio input if this is not done yet
				if (!self.readyToRecordAudio)
					self.readyToRecordAudio = [self setupAssetWriterAudioInput:formatDescription];
				
				// Write audio data to file
				if (self.readyToRecordAudio)
					[self writeSampleBuffer:sampleBuffer ofType:AVMediaTypeAudio];
			}
			
			BOOL isReadyToRecord = self.readyToRecordAudio;
			if (!wasReadyToRecord && isReadyToRecord){
				self.recordingWillBeStarted = NO;
				self.recording = YES;
                if ([self.delegate respondsToSelector:@selector(audioRecordingBegan)]) {
                    [self.delegate audioRecordingBegan];
                }
			}
		}
		CFRelease(sampleBuffer);
		CFRelease(formatDescription);
    });
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
	if(self.assetWriter.status == AVAssetWriterStatusUnknown){ // 0
        if ([self.assetWriter startWriting]){
			[self.assetWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
		} else {
			NSLog(@"1) %@", [self.assetWriter error]);
		}
	} else if(self.assetWriter.status == AVAssetWriterStatusWriting){ // 1
		if (mediaType == AVMediaTypeAudio) {
			if (self.assetWriterAudioInput.readyForMoreMediaData) {
				if (![self.assetWriterAudioInput appendSampleBuffer:sampleBuffer]) {
					NSLog(@"2) %@",[self.assetWriter error]);
				}
			}
		}
	}
}

@end
