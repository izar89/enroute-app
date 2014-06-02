//
//  AVCamCaptureManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "AVCamCaptureManager.h"

@implementation AVCamCaptureManager

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.orientation = AVCaptureVideoOrientationPortrait;
        [self setupSession];
    }
    return self;
}

- (void)dealloc
{
    [[self session] stopRunning];
}

- (void)setupSession
{
    // Init the device inputs
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backFacingCamera] error:nil];
    self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self audioDevice] error:nil];
    
    // Create session (use default AVCaptureSessionPresetHigh)
    self.session = [[AVCaptureSession alloc] init];
    
    // Add inputs and output to the capture session
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddInput:self.audioInput]) {
        [self.session addInput:self.audioInput];
    }
    
	// Set up the movie file output
    self.fileManager = [[AVCamFileManager alloc] init];
    
    self.recorder = [[AVCamRecorder alloc] initWithSession:self.session outputFileURL:[self.fileManager tempFileURL]];
    self.recorder.delegate = self;
}

- (void)startRecording
{
    [self.fileManager removeFile:[self.recorder outputFileURL]];
    [self.recorder startRecordingWithOrientation:self.orientation];
}

- (void) stopRecording
{
    [self.recorder stopRecording];
}

#pragma mark - Devices
// Find a camera with the specificed AVCaptureDevicePosition, returning nil if one is not found
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

// Find a back facing camera, returning nil if one is not found
- (AVCaptureDevice *)backFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

// Find and return an audio device, returning nil if one is not found
- (AVCaptureDevice *) audioDevice
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    if (devices.count > 0) {
        return devices[0];
    }
    return nil;
}

#pragma mark - Delegates
-(void)recorderRecordingDidBegin:(AVCamRecorder *)recorder
{
    if ([self.delegate respondsToSelector:@selector(captureManagerRecordingBegan:)]) {
        [self.delegate captureManagerRecordingBegan:self];
    }
}

-(void)recorder:(AVCamRecorder *)recorder recordingDidFinishToOutputFileURL:(NSURL *)outputFileURL error:(NSError *)error
{
    if (error) {
        if ([self.delegate respondsToSelector:@selector(captureManager:didFailWithError:)]) {
            [self.delegate captureManager:self didFailWithError:error];
        }
    }
    if ([self.delegate respondsToSelector:@selector(captureManagerRecordingFinished:outputFileURL:)]) {
        [self.delegate captureManagerRecordingFinished:self outputFileURL:outputFileURL];
    }
}

@end
