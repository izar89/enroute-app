//
//  TaskTwoViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTwoView.h"
#import "TaskInfoViewController.h"
#import "TaskTwoCameraViewController.h"

@interface TaskTwoViewController : UIViewController

@property (nonatomic, strong) TaskTwoView *view;
@property (strong, nonatomic) TaskInfoViewController *taskTwoInfoVC;
@property (strong, nonatomic) TaskTwoCameraViewController *taskTwoCameraVC;

@end
