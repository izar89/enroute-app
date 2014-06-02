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

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureMovieFileOutput *movieFileOutput;
@property (copy, nonatomic) NSURL *outputFileURL;
@property (readonly, nonatomic) BOOL recordsVideo;
@property (readonly, nonatomic) BOOL recordsAudio;
@property (readonly, nonatomic, getter=isRecording) BOOL recording;
@property (weak, nonatomic) id <AVCamRecorderDelegate> delegate;

- (id)initWithSession:(AVCaptureSession *)session outputFileURL:(NSURL *)outputFileURL;
- (void)startRecordingWithOrientation:(AVCaptureVideoOrientation)videoOrientation;
- (void)stopRecording;

@end

@protocol AVCamRecorderDelegate <NSObject>
@required
- (void)recorderRecordingDidBegin:(AVCamRecorder *)recorder;
- (void)recorder:(AVCamRecorder *)recorder recordingDidFinishToOutputFileURL:(NSURL *)outputFileURL error:(NSError *)error;
@end