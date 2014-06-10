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
        
        [self createNavigationBar]; //height: 44px;
        [self createContentContainer];
    }
    return self;
}

- (void)createNavigationBar
{
    self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    self.navigationBarView.backgroundColor = [UIColor enrouteRedColor];
    [self addSubview:self.navigationBarView];
    
    self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnBack.frame = CGRectMake(0, 0, 60, self.navigationBarView.frame.size.height);
    self.btnBack.backgroundColor = [UIColor blackColor];
    [self.btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [self.navigationBarView addSubview:self.btnBack];
}

- (void)createContentContainer
{
    int frameWidth = self.frame.size.width;
    int frameHeight = self.frame.size.height;
    
    self.contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight - self.navigationBarView.frame.size.height)];
    self.contentContainerView.center = CGPointMake(frameWidth / 2, self.contentContainerView.frame.size.height / 2 + self.navigationBarView.frame.size.height);
    self.contentContainerView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.contentContainerView];
}

@end


