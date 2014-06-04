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
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        toolbar.center = CGPointMake(frame.size.width / 2, frame.size.height - toolbar.frame.size.height / 2);
        
        [self addSubview:toolbar];
    }
    return self;
}

@end
