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
        self.backgroundColor = [UIColor blueColor];
        
        [self createBackground];
        [self createIntro];
        [self createDiscover];
        [self createBtnStart];
        [self createForeground];
    }
    return self;
}

- (void)createBackground
{
    UIImage *bgImage = [UIImage imageNamed:@"bgIntro"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
    bgImageView.contentMode = UIViewContentModeTop; //testing on ipad 3.5inch will scale
    bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:bgImageView];
}

- (void)createIntro
{
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, self.frame.size.width - 100, 30)];
    lblTitle.font = [UIFont fontWithName:FONT_HELVETICANEUE_CONDENSEDBLACK size:25];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"EN ROUTE";
    lblTitle.textColor = [UIColor enrouteRedColor];
    [self addSubview:lblTitle];
    
    UILabel *lblIntro = [[UILabel alloc] initWithFrame:CGRectMake(40, lblTitle.frame.origin.y + 20, self.frame.size.width - 100, 200)];
    lblIntro.font = [UIFont fontWithName:FONT_HELVETICANEUE_BOLD size:16];
    lblIntro.textAlignment = NSTextAlignmentCenter;
    lblIntro.textColor = [UIColor enrouteRedColor];
    lblIntro.text = @"Durbuy is de kleinste stad. Maar dit wilt niet zeggen dat Durbuy moet onderdoen voor grotere steden. Kan jij door jouw creativiteit Durbuy de grootste stad laten worden?";
    lblIntro.numberOfLines = 0;
    [self addSubview:lblIntro];
}

- (void)createDiscover
{
    UILabel *lblDiscover = [[UILabel alloc] initWithFrame:CGRectMake(40, 418, self.frame.size.width - 100, 30)];
    lblDiscover.font = [UIFont fontWithName:FONT_HELVETICANEUE_CONDENSEDBLACK size:18];
    lblDiscover.textAlignment = NSTextAlignmentCenter;
    lblDiscover.text = @"Kijk rond en ontdek";
    lblDiscover.textColor = [UIColor enrouteDarkBlueColor];
    [self addSubview:lblDiscover];
}

- (void)createBtnStart
{
    UIImage *btnStartBgImage = [UIImage imageNamed:@"btnBegin"];
    UIImage *btnStartBgImageSelected = [UIImage imageNamed:@"btnBeginHover"];
    self.btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnStart.frame = CGRectMake(0, 0, btnStartBgImage.size.width, btnStartBgImage.size.height);
    self.btnStart.center = CGPointMake(self.frame.size.width / 2, 493);
    [self.btnStart setBackgroundImage:btnStartBgImage forState:UIControlStateNormal];
    [self.btnStart setBackgroundImage:btnStartBgImageSelected forState:UIControlStateHighlighted];
    [self.btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnStart.titleLabel.font = [UIFont fontWithName:FONT_SAHARA size:30];
    [self.btnStart setTitle:@"BEGIN" forState:UIControlStateNormal];
    [self addSubview:self.btnStart];
}

- (void)createForeground
{
    UIImage *house1Image = [UIImage imageNamed:@"huis1"];
    UIImageView *house1ImageView = [[UIImageView alloc] initWithImage:house1Image];
    house1ImageView.center = CGPointMake(self.frame.size.width - 10, self.frame.size.height - 70);
    [self addSubview:house1ImageView];
    
    UIImage *house2Image = [UIImage imageNamed:@"huis2"];
    UIImageView *house2ImageView = [[UIImageView alloc] initWithImage:house2Image];
    house2ImageView.center = CGPointMake(20, self.frame.size.height - 40);
    [self addSubview:house2ImageView];
}


@end
