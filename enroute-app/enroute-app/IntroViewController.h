//
//  IntroViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroView.h"
#import "TaskMenuViewController.h"

@interface IntroViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) IntroView *view;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
