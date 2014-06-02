//
//  VideoPartView.m
//  enroute-app
//
//  Created by Stijn Heylen on 01/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "CameraPartView.h"

@implementation CameraPartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnRecord.frame = CGRectMake(frame.size.width - 40, frame.size.height - 40, 40, 40);
        self.btnRecord.backgroundColor = [UIColor blackColor];
        [self addSubview:self.btnRecord];
    }
    return self;
}

@end
