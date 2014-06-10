//
//  CaptureManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 08/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol CaptureManagerDelegate;

@interface CaptureManager : NSObject <AVCaptureFileOutputRecordingDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>

typedef NS_ENUM(NSInteger, DeviceInputType) {
    OnlyVideo,
    OnlyAudio,
    VideoAndAudio
};

@property (weak, nonatomic) id<CaptureManagerDelegate> delegate;

- (id)initWithPreviewView:(UIView *)previewView;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)startVideoRecording;
- (void)stopRecording;

@end

@protocol CaptureManagerDelegate <NSObject>
@optional
- (void)recordingDidFailWithError:(NSError *)error;
- (void)recordingWillBegin;
- (void)recordingBegan;
- (void)recordingWillFinish;
- (void)recordingFinished:(NSURL *)outputFileURL;
@end
