//
//  TaskMenuItemView.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskMenuItemView.h"

@implementation TaskMenuItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSelect.frame = CGRectMake(15, frame.size.height - 65, frame.size.width - 30, 40);
        self.btnSelect.backgroundColor = [UIColor blackColor];
        [self.btnSelect setTitle:@"Select" forState:UIControlStateNormal];
        [self addSubview:self.btnSelect];
    }
    return self;
}

@end
