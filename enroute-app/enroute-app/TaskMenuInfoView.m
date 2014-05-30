//
//  TaskMenuInfoView.m
//  enroute-app
//
//  Created by Stijn Heylen on 30/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskMenuInfoView.h"

@implementation TaskMenuInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CGRect containerFrame = CGRectMake(15, 15, frame.size.width - 30, frame.size.height - 30);
        self.container = [[UIView alloc] initWithFrame:containerFrame];
        self.container.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        [self addSubview:self.container];
        
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:30];
        self.lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, containerFrame.size.width - 30, 40)];
        self.lblInfo.font = font;
        self.lblInfo.text = @"INFO";
        [self.container addSubview:self.lblInfo];
        
        self.btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnStart.frame = CGRectMake(15, containerFrame.size.height - 65, containerFrame.size.width - 30, 40);
        self.btnStart.backgroundColor = [UIColor blackColor];
        [self.btnStart setTitle:@"Start" forState:UIControlStateNormal];
        [self.container addSubview:self.btnStart];
    }
    return self;
}

@end
