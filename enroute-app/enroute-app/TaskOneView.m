//
//  TaskOneView.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskOneView.h"

@implementation TaskOneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBack.frame = CGRectMake(15, frame.size.height - 65, frame.size.width - 30, 40);
        self.btnBack.backgroundColor = [UIColor blackColor];
        [self.btnBack setTitle:@"Back" forState:UIControlStateNormal];
        [self addSubview:self.btnBack];
    }
    return self;
}

@end
