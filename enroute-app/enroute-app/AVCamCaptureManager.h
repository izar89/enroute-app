//
//  AVCamCaptureManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AVCamRecorder.h"
#import "AVCamFileManager.h"

@protocol AVCamCaptureManagerDelegate;

@interface AVCamCaptureManager : NSObject <AVCamRecorderDelegate, AVCamFileManagerDelegate>

@property (strong, nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCaptureVideoOrientation orientation;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureDeviceInput *audioInput;
@property (strong, nonatomic) AVCamRecorder *recorder;
@property (strong, nonatomic) AVCamFileManager *fileManager;
@property (weak, nonatomic) id<AVCamCaptureManagerDelegate> delegate;

- (void) setupSession;
- (void) startRecording;
- (void) stopRecording;

@end

@protocol AVCamCaptureManagerDelegate <NSObject>
@optional
- (void) captureManager:(AVCamCaptureManager *)captureManager didFailWithError:(NSError *)error;
- (void) captureManagerRecordingBegan:(AVCamCaptureManager *)captureManager;
- (void) captureManagerRecordingFinished:(AVCamCaptureManager *)captureManager outputFileURL:(NSURL *)outputFileURL;
@end