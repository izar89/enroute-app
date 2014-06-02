//
//  AVCamCaptureManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "CameraRecorder.h"
#import "CameraFileManager.h"

@protocol AVCamCaptureManagerDelegate;

@interface CameraCaptureManager : NSObject <AVCamRecorderDelegate, AVCamFileManagerDelegate>

@property (strong, nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCaptureVideoOrientation orientation;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureDeviceInput *audioInput;
@property (strong, nonatomic) CameraRecorder *recorder;
@property (strong, nonatomic) CameraFileManager *fileManager;
@property (weak, nonatomic) id<AVCamCaptureManagerDelegate> delegate;

- (void) setupSession;
- (void) startRecording;
- (void) stopRecording;

@end

@protocol AVCamCaptureManagerDelegate <NSObject>
@optional
- (void) captureManager:(CameraCaptureManager *)captureManager didFailWithError:(NSError *)error;
- (void) captureManagerRecordingBegan:(CameraCaptureManager *)captureManager;
- (void) captureManagerRecordingFinished:(CameraCaptureManager *)captureManager outputFileURL:(NSURL *)outputFileURL;
@end