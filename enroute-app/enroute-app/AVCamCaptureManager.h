//
//  AVCamCaptureManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AVCamRecorder.h"

@protocol AVCamCaptureManagerDelegate;

@interface AVCamCaptureManager : NSObject <AVCamRecorderDelegate>

@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,assign) AVCaptureVideoOrientation orientation;
@property (nonatomic,strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic,strong) AVCaptureDeviceInput *audioInput;
@property (nonatomic,strong) AVCamRecorder *recorder;
@property (nonatomic,assign) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic,weak) id <AVCamCaptureManagerDelegate> delegate;

- (void) setupSession;
- (void) startRecording;
- (void) stopRecording;

@end

@protocol AVCamCaptureManagerDelegate <NSObject>
@optional
- (void) captureManager:(AVCamCaptureManager *)captureManager didFailWithError:(NSError *)error;
- (void) captureManagerRecordingBegan:(AVCamCaptureManager *)captureManager;
- (void) captureManagerRecordingFinished:(AVCamCaptureManager *)captureManager;
@end