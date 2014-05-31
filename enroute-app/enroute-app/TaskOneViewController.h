//
//  TaskOneViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOneView.h"
#import "TaskMenuViewController.h"
#import "TaskOneInfoViewController.h"

@interface TaskOneViewController : UIViewController

@property (strong, nonatomic) TaskOneView *view;
@property (strong, nonatomic) TaskOneInfoViewController *taskOneInfoVC;

@end
