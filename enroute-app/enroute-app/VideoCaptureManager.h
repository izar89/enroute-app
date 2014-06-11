//
//  VideoCaptureManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 10/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "FileManager.h"

@protocol VideoCaptureManagerDelegate;

@interface VideoCaptureManager : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate, FileManagerDelegate>
@property (weak, nonatomic) id<VideoCaptureManagerDelegate> delegate;
- (id)initWithPreviewView:(UIView *)previewView;
- (void)setOutputDimensionsWidth:(int)outputWidth height:(int)outputHeight;
- (void)startVideoRecording;
- (void)stopVideoRecording;
@end

@protocol VideoCaptureManagerDelegate <NSObject>
@optional
- (void)videoRecordingDidFailWithError:(NSError *)error;
- (void)videoRecordingWillBegin;
- (void)videoRecordingBegan;
- (void)videoRecordingWillFinish;
- (void)videoRecordingFinished:(NSURL *)outputFileURL;
@end