//
//  MapBoxView.m
//  enroute-app
//
//  Created by Stijn Heylen on 16/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "MapBoxView.h"

@implementation MapBoxView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createNavigationBar];
        [self createMap];
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
}

- (void)createMap
{
    RMMapboxSource *source = [[RMMapboxSource alloc] initWithMapID:@"volpesalvatore.ig87og4i"];
    
    self.mapView = [[RMMapView alloc] initWithFrame:CGRectMake(0, self.navigationBarView.frame.size.height, self.frame.size.width, self.frame.size.height - self.navigationBarView.frame.size.height) andTilesource:source];
    [self addSubview:self.mapView];
}

@end
