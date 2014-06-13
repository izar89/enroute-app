//
//  TaskOneCameraView.h
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TaskOneCameraView : UIView

/* Bottom toolbar */
@property (strong, nonatomic) UIView *bottomToolbarView;
@property (strong, nonatomic) UIButton *btnSave;
@property (strong, nonatomic) UIButton *btnRecordVideo;
@property (strong, nonatomic) UIButton *btnRecordAudio;

- (void)setBtnVideoReady:(BOOL)ready;
- (void)setBtnAudioReady:(BOOL)ready;

/* Video preview */
@property (strong, nonatomic) UIView *videoPreviewView;

/* Roof */
@property (nonatomic, strong) UIImageView *floorRoof;

/* Add floor */
@property (strong, nonatomic) UIView *addFloorView;
@property (strong, nonatomic) UIButton *btnAddFloor;

/* Floors */
@property (strong, nonatomic) UIScrollView *scrollFloorsView;
@property (strong, nonatomic) UIView *scrollFixView;
@property (nonatomic, strong) UIImageView *floorGround;

@end
