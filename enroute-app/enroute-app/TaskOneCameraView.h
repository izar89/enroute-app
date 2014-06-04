//
//  TaskOneCameraView.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CameraCaptureManager.h"

@interface TaskOneCameraView : UIView

@property (strong, nonatomic) UIBarButtonItem *btnSave;
@property (strong, nonatomic) UIBarButtonItem *btnRecordVideo;
@property (strong, nonatomic) UIBarButtonItem *btnRecordAudio;
@property (strong, nonatomic) UIView *videoPreviewView;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@end
