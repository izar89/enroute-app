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
    }
    return self;
}

- (void)dealloc
{
    [[self session] stopRunning];
}

- (void)setupSession
{
    NSLog(@"[AVCamCaptureManager] setupSession");
    
    // Init the device inputs
    AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backFacingCamera] error:nil];
    AVCaptureDeviceInput *newAudioInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self audioDevice] error:nil];
    
    // Create session (use default AVCaptureSessionPresetHigh)
    AVCaptureSession *newCaptureSession = [[AVCaptureSession alloc] init];
    
    // Add inputs and output to the capture session
    if ([newCaptureSession canAddInput:newVideoInput]) {
        [newCaptureSession addInput:newVideoInput];
    }
    if ([newCaptureSession canAddInput:newAudioInput]) {
        [newCaptureSession addInput:newAudioInput];
    }
    
    [self setVideoInput:newVideoInput];
    [self setAudioInput:newAudioInput];
    [self setSession:newCaptureSession];
    
	// Set up the movie file output
    NSURL *outputFileURL = [self tempFileURL];
    self.recorder = [[AVCamRecorder alloc] initWithSession:[self session] outputFileURL:outputFileURL];
    self.recorder.delegate = self;
}

- (void) startRecording
{
    NSLog(@"[AVCamCaptureManager] startRecording");
    
    if ([[UIDevice currentDevice] isMultitaskingSupported]) {
        /* Setup background task. This is needed because the captureOutput:didFinishRecordingToOutputFileAtURL: callback is not received until AVCam returns to the foreground unless you request background execution time. This also ensures that there will be time to write the file to the assets library when AVCam is backgrounded. To conclude this background execution, -endBackgroundTask is called in -recorder:recordingDidFinishToOutputFileURL:error: , after the recorded file has been saved. */
        [self setBackgroundRecordingID:[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{}]];
    }
    
    [self removeFile:[[self recorder] outputFileURL]];
    [[self recorder] startRecordingWithOrientation:self.orientation];
}

- (void) stopRecording
{
    NSLog(@"[AVCamCaptureManager] stopRecording");
    
    [[self recorder] stopRecording];
}


// Find a camera with the specificed AVCaptureDevicePosition, returning nil if one is not found
- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSLog(@"[AVCamCaptureManager] cameraWithPosition");
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

// Find a back facing camera, returning nil if one is not found
- (AVCaptureDevice *) backFacingCamera
{
    NSLog(@"[AVCamCaptureManager] backFacingCamera");
    
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

// Find and return an audio device, returning nil if one is not found
- (AVCaptureDevice *) audioDevice
{
    NSLog(@"[AVCamCaptureManager] audioDevice");
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    if ([devices count] > 0) {
        return devices[0];
    }
    return nil;
}

- (NSURL *) tempFileURL
{
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), @"output.mov"]];
}

- (void) removeFile:(NSURL *)fileURL
{
    NSString *filePath = [fileURL path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSError *error;
        if ([fileManager removeItemAtPath:filePath error:&error] == NO) {
            if ([[self delegate] respondsToSelector:@selector(captureManager:didFailWithError:)]) {
                [[self delegate] captureManager:self didFailWithError:error];
            }
        }
    }
}

- (void) copyFileToDocuments:(NSURL *)fileURL
{
	NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss"];
	NSString *destinationPath = [documentsDirectory stringByAppendingFormat:@"/output_%@.mov", [dateFormatter stringFromDate:[NSDate date]]];
	NSError	*error;
	if (![[NSFileManager defaultManager] copyItemAtURL:fileURL toURL:[NSURL fileURLWithPath:destinationPath] error:&error]) {
		if ([[self delegate] respondsToSelector:@selector(captureManager:didFailWithError:)]) {
			[[self delegate] captureManager:self didFailWithError:error];
		}
	}
}

-(void)recorderRecordingDidBegin:(AVCamRecorder *)recorder
{
    if ([[self delegate] respondsToSelector:@selector(captureManagerRecordingBegan:)]) {
        [[self delegate] captureManagerRecordingBegan:self];
    }
}

-(void)recorder:(AVCamRecorder *)recorder recordingDidFinishToOutputFileURL:(NSURL *)outputFileURL error:(NSError *)error
{
	if ([[self recorder] recordsAudio] && ![[self recorder] recordsVideo]) {
		// If the file was created on a device that doesn't support video recording, it can't be saved to the assets
		// library. Instead, save it in the app's Documents directory, whence it can be copied from the device via
		// iTunes file sharing.
		[self copyFileToDocuments:outputFileURL];
        
		if ([[UIDevice currentDevice] isMultitaskingSupported]) {
			[[UIApplication sharedApplication] endBackgroundTask:[self backgroundRecordingID]];
		}
        
		if ([[self delegate] respondsToSelector:@selector(captureManagerRecordingFinished:)]) {
			[[self delegate] captureManagerRecordingFinished:self];
		}
	}
	else {
		ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
		[library writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                if ([[self delegate] respondsToSelector:@selector(captureManager:didFailWithError:)]) {
                    [[self delegate] captureManager:self didFailWithError:error];
                }
            }
										
            if ([[UIDevice currentDevice] isMultitaskingSupported]) {
                [[UIApplication sharedApplication] endBackgroundTask:[self backgroundRecordingID]];
            }
										
            if ([[self delegate] respondsToSelector:@selector(captureManagerRecordingFinished:)]) {
                [[self delegate] captureManagerRecordingFinished:self];
            }
        }];
	}
}


@end
