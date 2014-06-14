//
//  TaskOneInfoViewController.h
//  enroute-app
//
//  Created by Stijn Heylen on 30/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskInfoView.h"
#import "JSONDataManager.h"

@interface TaskInfoViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) TaskInfoView *view;

- (id)initWithTaskInfos:(TaskInfos *)taskInfos;

@end

