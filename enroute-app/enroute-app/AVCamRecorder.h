//
//  AVCamRecorder.h
//  enroute-app
//
//  Created by Stijn Heylen on 01/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol AVCamRecorderDelegate;

@interface AVCamRecorder : NSObject<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureMovieFileOutput *movieFileOutput;
@property (nonatomic,copy) NSURL *outputFileURL;
@property (nonatomic,readonly) BOOL recordsVideo;
@property (nonatomic,readonly) BOOL recordsAudio;
@property (nonatomic,readonly,getter=isRecording) BOOL recording;
@property (nonatomic,weak) id <AVCamRecorderDelegate> delegate;

- (id)initWithSession:(AVCaptureSession *)session outputFileURL:(NSURL *)outputFileURL;
- (void)startRecordingWithOrientation:(AVCaptureVideoOrientation)videoOrientation;
- (void)stopRecording;

@end

@protocol AVCamRecorderDelegate <NSObject>
@required
- (void)recorderRecordingDidBegin:(AVCamRecorder *)recorder;
- (void)recorder:(AVCamRecorder *)recorder recordingDidFinishToOutputFileURL:(NSURL *)outputFileURL error:(NSError *)error;
@end