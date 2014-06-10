//
//  TaskOneCameraViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOneCameraView.h"
#import "CaptureManager.h"

@interface TaskOneCameraViewController : UIViewController <CaptureManagerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>

@property (strong, nonatomic) TaskOneCameraView *view;

@end
