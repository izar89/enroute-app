//
//  TaskOneCameraViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOneCameraView.h"
#import "CameraPartView.h"

@interface TaskOneCameraViewController : UIViewController<AVCamCaptureManagerDelegate, AVCamFileManagerDelegate>

@property (strong, nonatomic) TaskOneCameraView *view;
@property (strong, nonatomic) AVCamCaptureManager *captureManager;
@property (strong, nonatomic) AVCamFileManager *fileManager;
@property (strong, nonatomic) NSTimer *recordTimer;
@property (nonatomic) int recordIndex;

@end
