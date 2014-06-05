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
        self.backgroundColor = [UIColor enrouteBlueColor];

        [self createCameraView];
        [self addFloor];
        [self floors];
        [self createBottomToolbar];
    }
    return self;
}

- (void)createBottomToolbar
{
    self.bottomToolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    self.bottomToolbarView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 22);
    self.bottomToolbarView.backgroundColor = [UIColor enrouteRedColor];
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
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 135)];
    self.videoPreviewView.center = CGPointMake(self.frame.size.width /2 , (self.frame.size.height - self.bottomToolbarView.frame.size.height) / 2);
    self.videoPreviewView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.videoPreviewView.layer.borderWidth = 1;
    
    [self addSubview:self.videoPreviewView];
}

- (void)addFloor
{
    self.btnAddFloor = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAddFloor.frame = self.videoPreviewView.frame;
    self.btnAddFloor.center = CGPointMake(self.frame.size.width /2, self.videoPreviewView.center.y - (self.videoPreviewView.frame.size.height));
    [self.btnAddFloor setTitle:@"+" forState:UIControlStateNormal];
    self.btnAddFloor.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnAddFloor.layer.borderWidth = 1;
    [self addSubview:self.btnAddFloor];
}

- (void)floors
{
    self.scrollFloorsView = [[UIScrollView alloc] initWithFrame:self.videoPreviewView.frame];
    self.scrollFloorsView.center = self.videoPreviewView.center;
    [self addSubview:self.scrollFloorsView];
}

@end
