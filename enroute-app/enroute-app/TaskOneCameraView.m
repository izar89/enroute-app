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
        
        self.videoPreviewView = [[UIView alloc] initWithFrame:frame];
        self.videoPreviewView.layer.masksToBounds = YES; //Check
        [self addSubview:self.videoPreviewView];
        
        int totalCameraParts = 4;
        CGRect cameraPartframe = CGRectMake(0, 0, frame.size.width, frame.size.height / totalCameraParts);
        
        self.cameraPartViews = [NSMutableArray array];
        for (int i = 0; i < totalCameraParts; i++) {
            CameraPartView *cameraPartView = [[CameraPartView alloc] initWithFrame:cameraPartframe];
            cameraPartView.center = CGPointMake(frame.size.width/2, cameraPartframe.size.height / 2 + (cameraPartframe.size.height * i));
            cameraPartView.layer.borderColor = [UIColor whiteColor].CGColor;
            cameraPartView.layer.borderWidth = 1;
            [self.cameraPartViews addObject:cameraPartView];
            [self addSubview:cameraPartView];
        }
    }
    return self;
}

@end
