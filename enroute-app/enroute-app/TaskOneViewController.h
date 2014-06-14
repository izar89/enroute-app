//
//  TaskOneViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOneView.h"
#import "TaskInfoViewController.h"
#import "TaskOneCameraViewController.h"
#import "TaskMenuViewController.h"

@interface TaskOneViewController : UIViewController

@property (strong, nonatomic) TaskOneView *view;
@property (strong, nonatomic) TaskInfoViewController *taskOneInfoVC;
@property (strong, nonatomic) TaskOneCameraViewController *taskOneCameraVC;

@end
