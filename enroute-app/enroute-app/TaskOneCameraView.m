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
        
        self.btnRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnRecord.frame = CGRectMake(15, frame.size.height - 65, frame.size.width - 30, 40);
        self.btnRecord.backgroundColor = [UIColor blackColor];
        [self.btnRecord setTitle:@"Record" forState:UIControlStateNormal];
        [self addSubview:self.btnRecord];
    }
    return self;
}

@end
