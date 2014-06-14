//
//  TaskMenuViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <CoreLocation/CoreLocation.h>
#import "TaskMenuView.h"
#import "TaskMenuItemView.h"
#import "TaskOneViewController.h"
#import "JSONDataManager.h"
#import "IntroViewController.h"

@interface TaskMenuViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) TaskMenuView *view;

- (id)initWithHeading:(float)heading;

@end
