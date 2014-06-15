//
//  TaskTwoCameraView.h
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TaskTwoCameraView : UIView

/* Bottom toolbar */
@property (strong, nonatomic) UIView *bottomToolbarView;
@property (strong, nonatomic) UIButton *btnDelete;
@property (strong, nonatomic) UIButton *btnPhoto;
@property (strong, nonatomic) UIButton *btnSave;

/* Photo preview */
@property (strong, nonatomic) UIView *photoPreviewView;
@property (strong, nonatomic) UIView *videoPreviewView;

@end
