//
//  FloorViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 13/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloorView.h"

#define VIDEO_WIDTH 280
#define VIDEO_HEIGHT 136

@interface FloorViewController : UIViewController

@property (nonatomic, strong) FloorView *view;
@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSURL *audioURL;
@property (nonatomic, strong) VideoPlayerView *videoPlayer;
@property (nonatomic, strong) AudioPlayer *audioPlayer;

- (id)initWithDefinedDimensionsAndId:(int)id;

@end
