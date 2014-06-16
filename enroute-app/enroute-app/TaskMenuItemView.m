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
        
        UIFont *font = [UIFont fontWithName:FONT_SAHARA size:30];
        
        UIImage *lblBg = [UIImage imageNamed:@"bgTitleTekstTaskMenuItem"];
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, lblBg.size.width, lblBg.size.height)];
        self.lblTitle.backgroundColor = [UIColor colorWithPatternImage:lblBg];
        self.lblTitle.font = font;
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.textColor = [UIColor enrouteLightYellowColor];
        self.lblTitle.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 472);
        self.lblTitle.text = task.title;
        [self addSubview:self.lblTitle];
        
        self.scrollViewInfo = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 20, frame.size.width - 60, frame.size.height - 110)];
        self.scrollViewInfo.scrollEnabled = YES;
        self.scrollViewInfo.bounces = YES;
        self.scrollViewInfo.contentSize = CGSizeMake(self.scrollViewInfo.frame.size.width, 0);
        [self addSubview:self.scrollViewInfo];
        
        UILabel *lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.scrollViewInfo.frame.size.width, self.scrollViewInfo.frame.size.height)];
        lblInfo.font = [UIFont fontWithName:FONT_HELVETICANEUE_BOLD size:14];
        lblInfo.text = task.text;
        lblInfo.textColor = [UIColor enrouteLightYellowColor];
        lblInfo.numberOfLines = 0;
        [self.scrollViewInfo addSubview:lblInfo];
        
        UIImage *btnStartBgImage = [UIImage imageNamed:@"btnSelectTask"];
        self.btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSelect.frame = CGRectMake(0, 0, btnStartBgImage.size.width, btnStartBgImage.size.height);
         self.btnSelect.center = CGPointMake(self.frame.size.width / 2, (bgInfo.frame.size.height + bgInfo.frame.origin.y) + 30);
        [self.btnSelect setBackgroundImage:btnStartBgImage forState:UIControlStateNormal];
        //[self.btnSelect setBackgroundImage:btnStartBgImageSelected forState:UIControlStateSelected];
        self.btnSelect.titleLabel.font = font;
        [self.btnSelect setTitle:@"START" forState:UIControlStateNormal];
        [self.btnSelect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.btnSelect];
    }
    return self;
}

@end
