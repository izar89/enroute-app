//
//  MapBoxView.h
//  enroute-app
//
//  Created by Stijn Heylen on 16/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RMMapView.h>
#import <RMMapboxSource.h>

@interface MapBoxView : UIView

/* Navigation bar */
@property (strong, nonatomic)UIView *navigationBarView;
@property (strong, nonatomic)UIButton *btnBack;

/* Map */
@property (strong, nonatomic) RMMapView *mapView;

@end
