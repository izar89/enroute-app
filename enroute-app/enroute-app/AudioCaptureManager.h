//
//  AudioCaptureManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 10/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "FileManager.h"

@protocol AudioCaptureManagerDelegate;

@interface AudioCaptureManager : NSObject <AVCaptureAudioDataOutputSampleBufferDelegate, FileManagerDelegate>
@property (weak, nonatomic) id<AudioCaptureManagerDelegate> delegate;
- (void)startAudioRecording;
- (void)stopAudioRecording;
- (void)startCaptureSession;
- (void)stopCaptureSession;
@end

@protocol AudioCaptureManagerDelegate <NSObject>
@optional
- (void)audioRecordingDidFailWithError:(NSError *)error;
- (void)audioRecordingWillBegin;
- (void)audioRecordingBegan;
- (void)audioRecordingWillFinish;
- (void)audioRecordingFinished:(NSURL *)outputFileURL;
@end