//
//  MapBoxViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 16/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapBoxView.h"
#import "APIManager.h"
#import "TaskTwoPhotosFactory.h"
#import "TaskTwoPhoto.h"


@interface MapBoxViewController : UIViewController<APIManagerDelegate, RMMapViewDelegate, FileManagerDelegate>

@property (nonatomic, strong) MapBoxView *view;

- (id)initWithNewTaskTwoPhoto:(TaskTwoPhoto *)newTaskTwoPhoto;

@end
