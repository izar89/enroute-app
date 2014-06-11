//
//  FloorView.m
//  enroute-app
//
//  Created by Stijn Heylen on 11/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "FloorView.h"

@implementation FloorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createVideoView];
        [self createFloorBg];
    }
    return self;
}

- (id)initWithDefinedDimensionsAndId:(int)id
{
    self.id = id;
    return [self initWithFrame:CGRectMake(0, 0, 320, 142)];
}

- (void)createVideoView
{
    self.videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 282, 138)];
    self.videoView.center = CGPointMake(self.frame.size.width /2 - 14 , self.frame.size.height / 2);
    //self.videoView.backgroundColor = [UIColor redColor];
    [self addSubview:self.videoView];
}

- (void)createFloorBg
{
    UIImage *floorBgImage = [UIImage imageNamed:@"floorBg"];
    self.floorBg = [[UIImageView alloc] initWithImage:floorBgImage];
    [self addSubview:self.floorBg];
}
@end
