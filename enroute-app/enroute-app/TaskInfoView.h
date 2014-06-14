//
//  TaskOneInfoView.h
//  enroute-app
//
//  Created by Stijn Heylen on 30/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskInfo.h"
#import "TaskInfos.h"
#import "TaskInfoItemView.h"

@interface TaskInfoView : UIView

@property (strong, nonatomic) UIScrollView *scrollInfoView;
@property (strong, nonatomic) UIPageControl *scrollPageControl;
@property (strong, nonatomic) NSMutableArray *taskInfoViews;

- (id)initWithFrame:(CGRect)frame taskInfos:(TaskInfos *)taskInfos;

@end
