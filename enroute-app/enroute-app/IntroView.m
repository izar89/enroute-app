//
//  IntroView.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "IntroView.h"

@implementation IntroView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *bgImage = [UIImage imageNamed:@"bgIntro"];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
        bgImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:bgImageView];
        
        UIImage *bgBtnBegin = [UIImage imageNamed:@"btnBegin"];
        UIImage *bgBtnBeginHover = [UIImage imageNamed:@"btnBeginHover"];
        self.btnBegin = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBegin.frame = CGRectMake(0, 0, bgBtnBegin.size.width, bgBtnBegin.size.height);
        [self.btnBegin setBackgroundImage:bgBtnBegin forState:UIControlStateNormal];
        [self.btnBegin setBackgroundImage:bgBtnBeginHover forState:UIControlStateHighlighted];
        [self.btnBegin setTitleColor:[UIColor colorWithRed:0.95 green:0.96 blue:0.81 alpha:1] forState:UIControlStateNormal];
        self.btnBegin.titleLabel.font = [UIFont fontWithName:FONT_SAHARA size:30];
        self.btnBegin.center = CGPointMake(frame.size.width / 2, frame.size.height - 70);
        [self.btnBegin setTitle:@"BEGIN" forState:UIControlStateNormal];
        [self addSubview:self.btnBegin];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, frame.size.width - 100, 30)];
        lblTitle.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:25];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.text = @"EN ROUTE";
        lblTitle.textColor = [UIColor colorWithRed:0.7 green:0.27 blue:0.25 alpha:1];
        [self addSubview:lblTitle];
        
        UILabel *lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(40, lblTitle.frame.size.height + lblTitle.frame.origin.y, frame.size.width - 100, 200)];
        lblInfo.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        lblInfo.textAlignment = NSTextAlignmentCenter;
//        lblInfo.text = task.text;
        lblInfo.textColor = [UIColor colorWithRed:0.7 green:0.27 blue:0.25 alpha:1];
        lblInfo.text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi commodo, ipsum sed pharetra gravida, orci magna rhoncus neque, id pulvinar odio lorem non turpis. Nullam sit amet enim.";
        lblInfo.numberOfLines = 0;
        [self addSubview:lblInfo];
        
        UILabel *lblMenuUitleg = [[UILabel alloc] initWithFrame:CGRectMake(40, frame.size.height - 150, frame.size.width - 100, 30)];
        lblMenuUitleg.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18];
        lblMenuUitleg.textAlignment = NSTextAlignmentCenter;
        lblMenuUitleg.text = @"Ontdek door te draaien";
        lblMenuUitleg.textColor = [UIColor colorWithRed:0.7 green:0.27 blue:0.25 alpha:1];
        [self addSubview:lblMenuUitleg];
        
        UIImage *huis1 = [UIImage imageNamed:@"huis1"];
        UIImageView *huis1ImageView = [[UIImageView alloc] initWithImage:huis1];
        huis1ImageView.center = CGPointMake(frame.size.width - 10, frame.size.height - 70);
        [self addSubview:huis1ImageView];
        
        UIImage *huis2 = [UIImage imageNamed:@"huis2"];
        UIImageView *huis2ImageView = [[UIImageView alloc] initWithImage:huis2];
        huis2ImageView.center = CGPointMake(20, frame.size.height - 40);
        [self addSubview:huis2ImageView];
    }
    return self;
}

@end
