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
        
        [self createVideoPreviewView];
        [self createVideoView];
        [self createFloorBg];
        [self createBtnPlay];
    }
    return self;
}

- (id)initWithDefinedDimensionsAndId:(int)id
{
    self.id = id;
    return [self initWithFrame:CGRectMake(0, 0, 320, 142)];
}

- (void)createVideoPreviewView
{
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 282, 138)];
    self.videoPreviewView.center = CGPointMake(self.frame.size.width /2 - 14 , self.frame.size.height / 2);
    [self addSubview:self.videoPreviewView];
}

- (void)createVideoView
{
    
    NSURL *videoURL = [self.fileManager videoTmpURL];
    self.videoPlayer = [[VideoPlayer alloc] initWithFrame:self.videoPreviewView.bounds andVideoURL:videoURL];
    
    
    
    self.videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 282, 138)];
    self.videoView.center = CGPointMake(self.frame.size.width /2 - 14 , self.frame.size.height / 2);
    [self addSubview:self.videoView];
    [self.videoView addSubview:self.videoPlayer];
}

- (void)createFloorBg
{
    UIImage *floorBgImage = [UIImage imageNamed:@"floorBg"];
    self.floorBg = [[UIImageView alloc] initWithImage:floorBgImage];
    [self addSubview:self.floorBg];
}

- (void)createBtnPlay
{
    self.btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPlay.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.btnPlay];
}

@end
