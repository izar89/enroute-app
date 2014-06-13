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
        
        UIImage *image = [UIImage imageNamed:@"bgInfoTekstTaskMenuItem"];
        UIImageView *bgInfo = [[UIImageView alloc] initWithImage:image];
        [self addSubview:bgInfo];
        
        UIImage *bgLabel = [UIImage imageNamed:@"bgTitleTekstTaskMenuItem"];
        UIFont *font = [UIFont fontWithName:FONT_SAHARA size:30];
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgLabel.size.width, bgLabel.size.height)];
        self.lblTitle.backgroundColor = [UIColor colorWithPatternImage:bgLabel];
        self.lblTitle.font = font;
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor colorWithRed:0.95 green:0.96 blue:0.81 alpha:1];
        self.lblTitle.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 472);
        self.lblTitle.text = task.title;
        [self addSubview:self.lblTitle];
        
        self.scrollViewInfo = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 20, frame.size.width - 60, frame.size.height - 110)];
        self.scrollViewInfo.scrollEnabled = YES;
        self.scrollViewInfo.bounces = YES;
                // Moet nog aangepast worden = > "AUTO" contentSize.height voor de scroll.
        self.scrollViewInfo.contentSize = CGSizeMake(self.scrollViewInfo.frame.size.width, self.scrollViewInfo.frame.size.height);
        [self addSubview:self.scrollViewInfo];
        UILabel *lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.scrollViewInfo.frame.size.width, self.scrollViewInfo.frame.size.height)];
        lblInfo.font = [UIFont fontWithName:@"HelveticaBold" size:14];
        lblInfo.text = task.text;
        lblInfo.textColor = [UIColor colorWithRed:0.7 green:0.27 blue:0.25 alpha:1];
        lblInfo.numberOfLines = 0;
        [self.scrollViewInfo addSubview:lblInfo];
        
        UIImage *bgBtnStartTask = [UIImage imageNamed:@"btnSelectTask"];
        self.btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSelect.frame = CGRectMake(0, 0, bgBtnStartTask.size.width, bgBtnStartTask.size.height);
        self.btnSelect.backgroundColor = [UIColor colorWithPatternImage:bgBtnStartTask];
        [self.btnSelect setTitleColor:[UIColor colorWithRed:0.95 green:0.96 blue:0.81 alpha:1] forState:UIControlStateNormal];
        self.btnSelect.titleLabel.font = font;
        self.btnSelect.center = CGPointMake(self.frame.size.width / 2, (bgInfo.frame.size.height + bgInfo.frame.origin.y) + 30);
        [self.btnSelect setTitle:@"START" forState:UIControlStateNormal];
        [self addSubview:self.btnSelect];
    }
    return self;
}

@end
