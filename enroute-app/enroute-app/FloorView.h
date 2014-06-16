//
//  FloorView.h
//  enroute-app
//
//  Created by Stijn Heylen on 11/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioPlayer.h"
#import "VideoPlayerView.h"
#import "FileManager.h"

@interface FloorView : UIView

/* View properties */
@property (nonatomic, strong) UIView *bg;
@property (nonatomic, strong) UIView *videoPreviewView;
@property (nonatomic, strong) UIView *videoPlayerView;
@property (nonatomic, strong) UIView *videoProgressLoader;
@property (nonatomic, strong) UIImageView *floorBg;
@property (nonatomic, strong) UIButton *btnPlay;

- (void)setBlue;
- (void)setRed;

@end
