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
    
    UIImage *btnSaveImage = [UIImage imageNamed:@"btnSave"];
    self.btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnSave setBackgroundImage:btnSaveImage forState:UIControlStateNormal];
    self.btnSave.frame = CGRectMake(0, 0, btnSaveImage.size.width, btnSaveImage.size.height);
    self.btnSave.center = CGPointMake(self.btnSave.frame.size.width / 2 + 20, self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnSave];
    
    UIImage *btnVideoImage = [UIImage imageNamed:@"btnVideoRed"];
    self.btnRecordVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnRecordVideo setBackgroundImage:btnVideoImage forState:UIControlStateNormal];
    self.btnRecordVideo.frame = CGRectMake(0, 0, btnVideoImage.size.width, btnVideoImage.size.height);
    self.btnRecordVideo.center = CGPointMake(self.frame.size.width - (self.btnRecordVideo.frame.size.width / 2 + 110), self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnRecordVideo];
    
    UIImage *btnAudioImage = [UIImage imageNamed:@"btnAudioRed"];
    self.btnRecordAudio = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnRecordAudio setBackgroundImage:btnAudioImage forState:UIControlStateNormal];
    self.btnRecordAudio.frame = CGRectMake(0, 0, btnAudioImage.size.width, btnAudioImage.size.height);
    self.btnRecordAudio.center = CGPointMake(self.frame.size.width - (self.btnRecordAudio.frame.size.width / 2 + 20), self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnRecordAudio];
}

- (void)createCameraView
{
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 282, 138)];
    //self.videoPreviewView.center = CGPointMake(self.frame.size.width /2 - 14 , (self.frame.size.height - self.bottomToolbarView.frame.size.height) / 2);
    //self.videoPreviewView.center = CGPointMake(self.frame.size.width /2, self.frame.size.height / 2);
    //[self addSubview:self.videoPreviewView];
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
    [self.addFloorView addSubview:addFloor];
    
    UIImage *btnAddFloorImage = [UIImage imageNamed:@"btnAddFloorRed"];
    self.btnAddFloor = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAddFloor setBackgroundImage:btnAddFloorImage forState:UIControlStateNormal];
    self.btnAddFloor.frame = CGRectMake(600, 800, btnAddFloorImage.size.width, btnAddFloorImage.size.height);
    self.btnAddFloor.center = CGPointMake(self.addFloorView.frame.size.width / 2 - 12, self.addFloorView.frame.size.height / 2 - 10);
    [self.addFloorView addSubview:self.btnAddFloor];
    
    [self.scrollFloorsView insertSubview:self.addFloorView atIndex:0];
    self.addFloorView.center = CGPointMake(self.frame.size.width / 2, - self.addFloorView.frame.size.height / 2 + 10);
    
    [UIView animateWithDuration:2 delay:0.2f options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         self.addFloorView.center = CGPointMake(self.frame.size.width / 2, - self.addFloorView.frame.size.height / 2 + 5);
                     }
                     completion:^(BOOL finished){}];
}

- (void)roof
{
    UIImage *floorRoofImage = [UIImage imageNamed:@"floorRoof"];
    self.floorRoof = [[UIImageView alloc] initWithImage:floorRoofImage];
    [self.scrollFloorsView insertSubview:self.floorRoof atIndex:0];
    self.floorRoof.center = CGPointMake(self.frame.size.width / 2, - (self.floorRoof.frame.size.height / 2 + 80));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.btnAddFloor];
    if([self.btnAddFloor hitTest:point withEvent:event]){
        [self.btnAddFloor sendActionsForControlEvents: UIControlEventTouchUpInside];
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

@end
