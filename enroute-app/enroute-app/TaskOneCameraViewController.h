//
//  TaskOneCameraViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOneCameraView.h"

@interface TaskOneCameraViewController : UIViewController<AVCamCaptureManagerDelegate>

@property (strong, nonatomic) TaskOneCameraView *view;
@property (nonatomic,strong) AVCamCaptureManager *captureManager;

@end
