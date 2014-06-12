//
//  FloorView.h
//  enroute-app
//
//  Created by Stijn Heylen on 11/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioPlayer.h"
#import "VideoPlayer.h"
#import "FileManager.h"

#define VIDEO_WIDTH 280
#define VIDEO_HEIGHT 136

@interface FloorView : UIView

/* Data properties */
@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSURL *audioURL;

/* View properties */
@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) UIView *videoPreviewView;
@property (nonatomic, strong) UIImageView *floorBg;
@property (nonatomic, strong) UIButton *btnPlay;

@property (nonatomic, strong) AudioPlayer *audioPlayer;
@property (nonatomic, strong) VideoPlayer *videoPlayer;

- (id)initWithDefinedDimensionsAndId:(int)id;

@end
