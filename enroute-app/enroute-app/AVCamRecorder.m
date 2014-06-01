//
//  AVCamRecorder.m
//  enroute-app
//
//  Created by Stijn Heylen on 01/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "AVCamRecorder.h"

@implementation AVCamRecorder

- (id) initWithSession:(AVCaptureSession *)aSession outputFileURL:(NSURL *)anOutputFileURL
{
    self = [super init];
    if (self != nil) {
        AVCaptureMovieFileOutput *aMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
        if ([aSession canAddOutput:aMovieFileOutput])
            [aSession addOutput:aMovieFileOutput];
        [self setMovieFileOutput:aMovieFileOutput];
		
		[self setSession:aSession];
		[self setOutputFileURL:anOutputFileURL];
    }
    
	return self;
}

- (void) dealloc
{
    [[self session] removeOutput:[self movieFileOutput]];
}

-(BOOL)recordsVideo
{
	AVCaptureConnection *videoConnection = [[self movieFileOutput] connectionWithMediaType:AVMediaTypeVideo];
	return [videoConnection isActive];
}

-(BOOL)recordsAudio
{
	AVCaptureConnection *audioConnection = [[self movieFileOutput] connectionWithMediaType:AVMediaTypeAudio];
	return [audioConnection isActive];
}

-(BOOL)isRecording
{
    NSLog(@"[AVCamRecorder] isRecording");
    
    return [[self movieFileOutput] isRecording];
}

-(void)startRecordingWithOrientation:(AVCaptureVideoOrientation)videoOrientation;
{
    NSLog(@"[AVCamRecorder] startRecordingWithOrientation");
    
    AVCaptureConnection *videoConnection = [[self movieFileOutput] connectionWithMediaType:AVMediaTypeVideo];
    if ([videoConnection isVideoOrientationSupported])
        [videoConnection setVideoOrientation:videoOrientation];
    
    [[self movieFileOutput] startRecordingToOutputFileURL:[self outputFileURL] recordingDelegate:self];
}

-(void)stopRecording
{
    NSLog(@"[AVCamRecorder] stopRecording");
    
    [[self movieFileOutput] stopRecording];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    if ([[self delegate] respondsToSelector:@selector(recorderRecordingDidBegin:)]) {
        [[self delegate] recorderRecordingDidBegin:self];
    }
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)anOutputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    if ([[self delegate] respondsToSelector:@selector(recorder:recordingDidFinishToOutputFileURL:error:)]) {
        [[self delegate] recorder:self recordingDidFinishToOutputFileURL:anOutputFileURL error:error];
    }
}

@end