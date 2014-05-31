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
        self.backgroundColor = [UIColor enrouteBlueColor];
        
        self.btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnStart.frame = frame;
        [self addSubview:self.btnStart];
    }
    return self;
}

@end
