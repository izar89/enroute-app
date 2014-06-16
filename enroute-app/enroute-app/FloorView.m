//
//  FloorView.m
//  enroute-app
//
//  Created by Stijn Heylen on 11/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "FloorView.h"

@interface FloorView()
@property (nonatomic, strong) FileManager *fileManager;
@end

@implementation FloorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.fileManager = [[FileManager alloc] init];
        
        [self createBg];
        [self createVideoPreviewView];
        [self createVideoPlayerView];
        [self createVideoProgressLoader];
        [self createFloorBg];
        [self createBtnPlay];
    }
    return self;
}

- (void)createBg
{
    self.bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 282, 138)];
    self.bg.center = CGPointMake(self.frame.size.width /2 -13 , self.frame.size.height / 2 + 3);
    self.bg.backgroundColor = [UIColor enrouteRedColor];
    [self addSubview:self.bg];

}

- (void)createVideoPreviewView
{
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 282, 138)];
    self.videoPreviewView.center = CGPointMake(self.frame.size.width /2 -13 , self.frame.size.height / 2 + 3);
    [self addSubview:self.videoPreviewView];
}

- (void)createVideoPlayerView
{
    self.videoPlayerView = [[UIView alloc] initWithFrame:self.videoPreviewView.frame];
    [self addSubview:self.videoPlayerView];
}

- (void)createVideoProgressLoader
{
    self.videoProgressLoader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.videoPreviewView.frame.size.width, 8)];
    self.videoProgressLoader.center = CGPointMake(self.frame.size.width /2 -13 - self.videoProgressLoader.frame.size.width, 8);
    self.videoProgressLoader.backgroundColor = [UIColor enrouteRedColor];
    [self addSubview:self.videoProgressLoader];
}

- (void)createFloorBg
{
    UIImage *floorBgImageBlue = [UIImage imageNamed:@"floorBgBlue"];
    self.floorBg = [[UIImageView alloc] initWithImage:floorBgImageBlue];
    [self addSubview:self.floorBg];
}

- (void)createBtnPlay
{
    self.btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPlay.frame = self.videoPreviewView.frame;
    [self addSubview:self.btnPlay];
}

- (void)setBlue
{
    [self.floorBg setImage:[UIImage imageNamed:@"floorBgBlue"]];
    self.videoProgressLoader.backgroundColor = [UIColor enrouteRedColor];
    self.bg.backgroundColor = [UIColor enrouteBlueColor];
}

- (void)setRed
{
    [self.floorBg setImage:[UIImage imageNamed:@"floorBgRed"]];
    self.videoProgressLoader.backgroundColor = [UIColor enrouteBlueColor];
    self.bg.backgroundColor = [UIColor enrouteRedColor];
}

@end
