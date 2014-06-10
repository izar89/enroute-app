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

/* Bottom toolbar */
@property (strong, nonatomic) UIView *bottomToolbarView;
@property (strong, nonatomic) UIButton *btnSave;
@property (strong, nonatomic) UIButton *btnRecordVideo;
@property (strong, nonatomic) UIButton *btnRecordAudio;

/* Video preview */
@property (strong, nonatomic) UIView *videoPreviewView;

/* Add floor */
@property (strong, nonatomic) UIButton *btnAddFloor;

/* Floors */
@property (strong, nonatomic) UIScrollView *scrollFloorsView;

@end
