//
//  TaskOneCameraView.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCamCaptureManager.h"

@interface TaskOneCameraView : UIView

@property (nonatomic,strong) UIView *videoPreviewView;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic,strong) UIButton *btnRecord;

@end
