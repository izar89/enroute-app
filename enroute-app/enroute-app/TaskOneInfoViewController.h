//
//  TaskOneInfoViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 30/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOneInfoView.h"
#import "JSONDataManager.h"

@interface TaskOneInfoViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) TaskOneInfoView *view;

@end

