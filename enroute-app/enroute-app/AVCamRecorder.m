//
//  AVCamRecorder.m
//  enroute-app
//
//  Created by Stijn Heylen on 01/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "AVCamRecorder.h"

@implementation AVCamRecorder

- (id) initWithSession:(AVCaptureSession *)session outputFileURL:(NSURL *)outputFileURL
{
    self = [super init];
    if (self != nil) {
        self.session = session;
        self.outputFileURL = outputFileURL;
        self.movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
        if ([self.session canAddOutput:self.movieFileOutput]){
            [self.session addOutput:self.movieFileOutput];
        }
    }
	return self;
}

- (void) dealloc
{
    [self.session removeOutput:self.movieFileOutput];
}

-(void)startRecordingWithOrientation:(AVCaptureVideoOrientation)videoOrientation;
{
    AVCaptureConnection *videoConnection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    if (videoConnection.isVideoOrientationSupported){
        videoConnection.videoOrientation = videoOrientation;
    }
    [self.movieFileOutput startRecordingToOutputFileURL:self.outputFileURL recordingDelegate:self];
}

-(void)stopRecording
{
    [self.movieFileOutput stopRecording];
}

#pragma mark - States
-(BOOL)recordsVideo
{
	AVCaptureConnection *videoConnection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
	return videoConnection.isActive;
}

-(BOOL)recordsAudio
{
	AVCaptureConnection *audioConnection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeAudio];
	return audioConnection.isActive;
}

-(BOOL)isRecording
{
    return self.movieFileOutput.isRecording;
}

#pragma mark - Delegates
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    if ([self.delegate respondsToSelector:@selector(recorderRecordingDidBegin:)]) {
        [self.delegate recorderRecordingDidBegin:self];
    }
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)anOutputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(recorder:recordingDidFinishToOutputFileURL:error:)]) {
        [self.delegate recorder:self recordingDidFinishToOutputFileURL:anOutputFileURL error:error];
    }
}

@end