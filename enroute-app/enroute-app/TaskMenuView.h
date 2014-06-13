//
//  TaskMenuView.h
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskMenuItemView.h"
#import "Tasks.h"

@interface TaskMenuView : UIView

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *taskMenuItemViews;
@property (nonatomic, strong) UIImageView *huisImageView;


/* Video preview */
@property (strong, nonatomic) UIView *videoPreviewView;

- (id)initWithFrame:(CGRect)frame tasks:(Tasks *)tasks;

@end
