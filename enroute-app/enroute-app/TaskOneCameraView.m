//
//  TaskOneCameraView.m
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskOneCameraView.h"

@implementation TaskOneCameraView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor enrouteYellowColor];

        [self createCameraView];
        [self floors];
        [self addFloor];
        [self createBottomToolbar];
    }
    return self;
}

- (void)createBottomToolbar
{
    self.bottomToolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 82)];
    self.bottomToolbarView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 22);
    self.bottomToolbarView.backgroundColor = [UIColor enrouteLightYellowColor];
    [self addSubview:self.bottomToolbarView];
    
    self.btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSave.frame = CGRectMake(0, 0, 60, self.bottomToolbarView.frame.size.height);
    self.btnSave.backgroundColor = [UIColor blackColor];
    [self.btnSave setTitle:@"Save" forState:UIControlStateNormal];
    [self.bottomToolbarView addSubview:self.btnSave];
    
    self.btnRecordVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnRecordVideo.frame = CGRectMake(160, 0, 60, self.bottomToolbarView.frame.size.height);
    self.btnRecordVideo.backgroundColor = [UIColor blackColor];
    [self.btnRecordVideo setTitle:@"Video" forState:UIControlStateNormal];
    [self.bottomToolbarView addSubview:self.btnRecordVideo];
    
    self.btnRecordAudio = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnRecordAudio.frame = CGRectMake(240, 0, 60, self.bottomToolbarView.frame.size.height);
    self.btnRecordAudio.backgroundColor = [UIColor blackColor];
    [self.btnRecordAudio setTitle:@"Audio" forState:UIControlStateNormal];
    [self.bottomToolbarView addSubview:self.btnRecordAudio];
}

- (void)createCameraView
{
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 282, 138)];
    self.videoPreviewView.center = CGPointMake(self.frame.size.width /2 - 14 , (self.frame.size.height - self.bottomToolbarView.frame.size.height) / 2);
    [self addSubview:self.videoPreviewView];
}

- (void)floors
{
    self.scrollFloorsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 142)];
    self.scrollFloorsView.center = CGPointMake(self.frame.size.width /2, (self.frame.size.height - self.bottomToolbarView.frame.size.height) / 2);
    self.scrollFloorsView.pagingEnabled = YES;
    self.scrollFloorsView.clipsToBounds = NO;
    [self addSubview:self.scrollFloorsView];
    
    UIImage *floorGroundImage = [UIImage imageNamed:@"floorGround"];
    self.floorGround = [[UIImageView alloc] initWithImage:floorGroundImage];
    [self.scrollFloorsView addSubview:self.floorGround];
}

- (void)addFloor
{
    UIImage *addFloorBgImage = [UIImage imageNamed:@"addFloorBg"];
    UIImageView *addFloor = [[UIImageView alloc] initWithImage:addFloorBgImage];
    self.addFloorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, addFloorBgImage.size.width, addFloorBgImage.size.height)];
    [self.addFloorView addSubview:addFloor];
    
    UIImage *btnAddFloorImage = [UIImage imageNamed:@"btnAddFloor"];
    self.btnAddFloor = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAddFloor setBackgroundImage:btnAddFloorImage forState:UIControlStateNormal];
    self.btnAddFloor.frame = CGRectMake(600, 800, btnAddFloorImage.size.width, btnAddFloorImage.size.height);
    self.btnAddFloor.center = CGPointMake(self.addFloorView.frame.size.width / 2, self.addFloorView.frame.size.height / 2 - 12);
    [self.addFloorView addSubview:self.btnAddFloor];
    
    [self.scrollFloorsView insertSubview:self.addFloorView atIndex:0];
    self.addFloorView.center = CGPointMake(self.frame.size.width / 2, - self.addFloorView.frame.size.height / 2 + 10);
}

@end
