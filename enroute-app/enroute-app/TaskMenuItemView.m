//
//  TaskMenuItemView.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskMenuItemView.h"

@implementation TaskMenuItemView

- (id)initWithFrame:(CGRect)frame task:(Task *)task
{
    self = [super initWithFrame:frame];
    if (self) {
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:30];
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, frame.size.width - 30, 40)];
        self.lblTitle.font = font;
        self.lblTitle.text = task.title;
        [self addSubview:self.lblTitle];
        
        self.btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSelect.frame = CGRectMake(15, frame.size.height - 65, frame.size.width - 30, 40);
        self.btnSelect.backgroundColor = [UIColor blackColor];
        [self.btnSelect setTitle:@"Select" forState:UIControlStateNormal];
        [self addSubview:self.btnSelect];
    }
    return self;
}

@end
