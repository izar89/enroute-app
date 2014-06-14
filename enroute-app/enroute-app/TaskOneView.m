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
        
        [self createContentContainer];
        [self createCloseInfoBtn];
        [self createNavigationBar]; //height: 48px;
    }
    return self;
}

- (void)createNavigationBar
{
    self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 48)];
    self.navigationBarView.backgroundColor = [UIColor enrouteLightYellowColor];
    [self addSubview:self.navigationBarView];
    
    UIImage *btnBackImage = [UIImage imageNamed:@"btnBack"];
    self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnBack setBackgroundImage:btnBackImage forState:UIControlStateNormal];
    self.btnBack.frame = CGRectMake(0, 0,  btnBackImage.size.width, btnBackImage.size.height);
    self.btnBack.center = CGPointMake(self.btnBack.frame.size.width / 2 + 20, self.navigationBarView.frame.size.height / 2);
    [self.navigationBarView addSubview:self.btnBack];
    
    UIImage *btnInfoImage = [UIImage imageNamed:@"btnQuestion"];
    self.btnInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnInfo setBackgroundImage:btnInfoImage forState:UIControlStateNormal];
    self.btnInfo.frame = CGRectMake(0, 0,  btnInfoImage.size.width, btnInfoImage.size.height);
    self.btnInfo.center = CGPointMake(self.navigationBarView.frame.size.width - (self.btnInfo.frame.size.width / 2 + 20), self.navigationBarView.frame.size.height / 2);
    [self.navigationBarView addSubview:self.btnInfo];
}

- (void)createContentContainer
{
    self.contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationBarView.frame.size.height, self.frame.size.width, self.frame.size.height - self.navigationBarView.frame.size.height)];
    self.contentContainerView.backgroundColor = [UIColor greenColor];
    self.contentContainerView.layer.masksToBounds = YES;
    [self addSubview:self.contentContainerView];
}

- (void)createCloseInfoBtn
{
    self.btnCloseInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnCloseInfo.frame = CGRectMake(0, self.navigationBarView.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.btnCloseInfo.backgroundColor = [UIColor blackColor];
    self.btnCloseInfo.alpha = 0.5;
}

- (void)setBtnInfoOpen:(BOOL)open
{
    UIImage *btnInfoImage;
    if(open){
        btnInfoImage = [UIImage imageNamed:@"btnClose"];
    } else {
        btnInfoImage = [UIImage imageNamed:@"btnQuestion"];
    }
    [self.btnInfo setBackgroundImage:btnInfoImage forState:UIControlStateNormal];
}

@end


