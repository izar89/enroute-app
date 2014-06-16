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
        [self createPhotoAnnotation];
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
    self.mapView = [[RMMapView alloc] initWithFrame:CGRectMake(0, self.navigationBarView.frame.size.height, self.frame.size.width, self.frame.size.height + 300) andTilesource:source];
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(50.833333, 3.266667);
    self.mapView.centerCoordinate = center;
    [self addSubview:self.mapView];
}

- (void)createPhotoAnnotation
{
    self.photoAnnotationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationBarView.frame.size.height, self.frame.size.width, self.frame.size.height - self.navigationBarView.frame.size.height)];
    self.photoAnnotationView.center = CGPointMake(self.frame.size.width / 2, self.photoAnnotationView.center.y);
    [self addSubview:self.photoAnnotationView];
   
    UIImage *photoAnnotationBgImage = [UIImage imageNamed:@"photoAnnotation"];
    UIImageView *photoAnnotationBg = [[UIImageView alloc] initWithImage:photoAnnotationBgImage];
    photoAnnotationBg.center = CGPointMake(self.photoAnnotationView.frame.size.width / 2, self.photoAnnotationView.frame.size.height/2 - 50);
    [self.photoAnnotationView addSubview:photoAnnotationBg];
    
    self.btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnClose.frame = CGRectMake(0, 0, self.photoAnnotationView.frame.size.width, self.photoAnnotationView.frame.size.height);
    self.btnClose.backgroundColor = [UIColor clearColor];
    
    self.photoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 320)];
    self.photoView.center = CGPointMake(self.photoAnnotationView.frame.size.width / 2 - 1, self.photoAnnotationView.frame.size.height/2 - 63);
    [self.photoAnnotationView addSubview:self.photoView];
    
    [self.photoAnnotationView addSubview:self.btnClose];
}

@end
