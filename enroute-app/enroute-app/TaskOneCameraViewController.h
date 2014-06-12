//
//  TaskOneCameraViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOneCameraView.h"
#import "AudioCaptureManager.h"
#import "VideoCaptureManager.h"
#import "FileManager.h"
#import "FloorView.h"
#import "APIManager.h"

@interface TaskOneCameraViewController : UIViewController <AudioCaptureManagerDelegate, VideoCaptureManagerDelegate, FileManagerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) TaskOneCameraView *view;

@end
