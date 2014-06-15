//
//  TaskTwoCameraView.m
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskTwoCameraView.h"

@implementation TaskTwoCameraView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor enrouteYellowColor];
        
        [self createCameraView];
        [self createPhotoPreviewView];
        
        /* Create bottom toolbar */
        [self createBottomToolbar];
    }
    return self;
}

- (void)createBottomToolbar
{
    self.bottomToolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 105)];
    self.bottomToolbarView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - self.bottomToolbarView.frame.size.height / 2);
    [self addSubview:self.bottomToolbarView];
    
    UIImage *btnPhotoImageRed = [UIImage imageNamed:@"btnPhotoRed"];
    self.btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnPhoto setBackgroundImage:btnPhotoImageRed forState:UIControlStateNormal];
    self.btnPhoto.frame = CGRectMake(0, 0, btnPhotoImageRed.size.width, btnPhotoImageRed.size.height);
    self.btnPhoto.center = CGPointMake(self.frame.size.width / 2, self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnPhoto];
    
    UIImage *btnDeleteImage = [UIImage imageNamed:@"btnClose"];
    self.btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnDelete setBackgroundImage:btnDeleteImage forState:UIControlStateNormal];
    self.btnDelete.frame = CGRectMake(0, 0, btnDeleteImage.size.width, btnDeleteImage.size.height);
    self.btnDelete.center = CGPointMake(self.btnPhoto.center.x - 95, self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnDelete];
    
    UIImage *btnSavePhotoImage = [UIImage imageNamed:@"btnSavePhoto"];
    self.btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnSave setBackgroundImage:btnSavePhotoImage forState:UIControlStateNormal];
    self.btnSave.frame = CGRectMake(0, 0, btnSavePhotoImage.size.width, btnSavePhotoImage.size.height);
    self.btnSave.center = CGPointMake(self.btnPhoto.center.x + 95, self.bottomToolbarView.frame.size.height / 2);
    [self.bottomToolbarView addSubview:self.btnSave];
}

- (void)createPhotoPreviewView
{
    self.photoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.photoPreviewView];
}

- (void)createCameraView
{
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.videoPreviewView];
}

- (void)setBtnPhotoReady:(BOOL)ready
{
    UIImage *btnPhotoImage;
    if(ready){
        btnPhotoImage = [UIImage imageNamed:@"btnPhotoGreen"];
    } else {
        btnPhotoImage = [UIImage imageNamed:@"btnPhotoRed"];
    }
    [self.btnPhoto setBackgroundImage:btnPhotoImage forState:UIControlStateNormal];
}

@end
