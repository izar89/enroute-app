//
//  TaskTwoCameraViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <CoreLocation/CoreLocation.h>
#import "MapBoxViewController.h"
#import "TaskTwoCameraView.h"
#import "PhotoCaptureManager.h"
#import "FileManager.h"
#import "APIManager.h"
#import "TaskTwoPhoto.h"

@interface TaskTwoCameraViewController : UIViewController<FileManagerDelegate, PhotoCaptureManagerDelegate, CLLocationManagerDelegate, APIManagerDelegate>

@property (nonatomic, strong) TaskTwoCameraView *view;

@end
