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
        [self roof];
        
        /* Scroll outside bounds */
        self.scrollFixView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.scrollFixView addGestureRecognizer:self.scrollFloorsView.panGestureRecognizer];
        [self addSubview:self.scrollFixView];
        
        /* Create bottom toolbar */
        [self createBottomToolbar];
    }
    return self;
}

- (void)createBottomToolbar
{
    self.bottomToolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 82)];
    self.bottomToolbarView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - self.bottomToolbarView.frame.size.height / 2);
    self.bottomToolbarView.backgroundColor = [UIColor enrouteLightYellowColor];
    [self addSubview:self.bottomToolbarView];
    
    UIFont *font = [UIFont fontWithName:FONT_SAHARA size:26];
    self.lblMinFloors = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.lblMinFloors.center = CGPointMake((self.lblMinFloors.frame.size.width / 2), self.bottomToolbarView.frame.size.height / 2);
    self.lblMinFloors.font = font;
    self.lblMinFloors.textColor = [UIColor enrouteRedColor];
    self.lblMinFloors.textAlignment = NSTextAlignmentCenter;
    self.lblMinFloors.text = @"min. 2";
    [self.bottomToolbarView addSubview:self.lblMinFloors];
    
    UIImage *btnSaveImage = [UIImage imageNamed:@"btnSaveVideo"];
    self.btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnSave setBackgroundImage:btnSaveImage forState:UIControlStateNormal];
    self.btnSave.frame = CGRectMake(0, 0, btnSaveImage.size.width, btnSaveImage.size.height);
    self.btnSave.center = CGPointMake((self.btnSave.frame.size.width / 2 + 20) - 100, self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnSave];
    
    UIImage *btnVideoImageRed = [UIImage imageNamed:@"btnVideoRed"];
    self.btnRecordVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnRecordVideo setBackgroundImage:btnVideoImageRed forState:UIControlStateNormal];
    self.btnRecordVideo.frame = CGRectMake(0, 0, btnVideoImageRed.size.width, btnVideoImageRed.size.height);
    self.btnRecordVideo.center = CGPointMake(self.frame.size.width - (self.btnRecordVideo.frame.size.width / 2 + 110), self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnRecordVideo];
    
    UIImage *btnAudioImageRed = [UIImage imageNamed:@"btnAudioRed"];
    self.btnRecordAudio = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnRecordAudio setBackgroundImage:btnAudioImageRed forState:UIControlStateNormal];
    self.btnRecordAudio.frame = CGRectMake(0, 0, btnAudioImageRed.size.width, btnAudioImageRed.size.height);
    self.btnRecordAudio.center = CGPointMake(self.frame.size.width - (self.btnRecordAudio.frame.size.width / 2 + 20), self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnRecordAudio];
}

- (void)createCameraView
{
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 282, 138)];
}

- (void)floors
{
    self.scrollFloorsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 142)];
    self.scrollFloorsView.center = CGPointMake(self.frame.size.width /2, (self.frame.size.height - self.bottomToolbarView.frame.size.height) / 2 + 60);
    self.scrollFloorsView.pagingEnabled = YES;
    self.scrollFloorsView.clipsToBounds = NO;
    [self addSubview:self.scrollFloorsView];
    
    UIImage *floorGroundImage = [UIImage imageNamed:@"floorGround"];
    self.floorGround = [[UIImageView alloc] initWithImage:floorGroundImage];
    [self.scrollFloorsView addSubview:self.floorGround];
}

- (void)addFloor
{
    UIImage *addFloorBgImage = [UIImage imageNamed:@"addFloorBgBlue"];
    UIImageView *addFloor = [[UIImageView alloc] initWithImage:addFloorBgImage];
    self.addFloorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, addFloorBgImage.size.width, addFloorBgImage.size.height)];
    self.addFloorView.center = CGPointMake(self.frame.size.width / 2, - self.addFloorView.frame.size.height / 2 + 10);
    [self.addFloorView addSubview:addFloor];
    
    UIImage *btnAddFloorImage = [UIImage imageNamed:@"btnAddFloorRed"];
    self.btnAddFloor = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAddFloor setBackgroundImage:btnAddFloorImage forState:UIControlStateNormal];
    self.btnAddFloor.frame = CGRectMake(600, 800, btnAddFloorImage.size.width, btnAddFloorImage.size.height);
    self.btnAddFloor.center = CGPointMake(self.addFloorView.frame.size.width / 2 - 12, self.addFloorView.frame.size.height / 2 - 10);
    [self.addFloorView addSubview:self.btnAddFloor];
    
    self.addFloorView.center = CGPointMake(self.frame.size.width / 2, - self.addFloorView.frame.size.height / 2 + 10);
    [self.scrollFloorsView insertSubview:self.addFloorView atIndex:0];
}

- (void)roof
{
    UIImage *floorRoofImage = [UIImage imageNamed:@"floorRoof"];
    self.floorRoof = [[UIImageView alloc] initWithImage:floorRoofImage];
    [self.scrollFloorsView insertSubview:self.floorRoof atIndex:0];
    self.floorRoof.center = CGPointMake(self.frame.size.width / 2, - (self.floorRoof.frame.size.height / 2 + 80));

}

- (void)setBtnVideoReady:(BOOL)ready
{
    UIImage *btnVideoImage;
    if(ready){
        btnVideoImage = [UIImage imageNamed:@"btnVideoGreen"];
    } else {
        btnVideoImage = [UIImage imageNamed:@"btnVideoRed"];
    }
    [self.btnRecordVideo setBackgroundImage:btnVideoImage forState:UIControlStateNormal];
}

- (void)setBtnAudioReady:(BOOL)ready
{
    NSLog(@"%i", self.btnRecordAudio.enabled);
    
    UIImage *btnAudioImage;
    if(ready){
        btnAudioImage = [UIImage imageNamed:@"btnAudioGreen"];
    } else {
        btnAudioImage = [UIImage imageNamed:@"btnAudioRed"];
    }
    [self.btnRecordAudio setBackgroundImage:btnAudioImage forState:UIControlStateNormal];
}

@end
