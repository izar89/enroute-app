//
//  TaskOneCameraView.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AVCamCaptureManager.h"
#import "CameraPartView.h"

@interface TaskOneCameraView : UIView

@property (strong, nonatomic) UIView *videoPreviewView;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (strong, nonatomic) NSMutableArray *cameraPartViews;

@end
