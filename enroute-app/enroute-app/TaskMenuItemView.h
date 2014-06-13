//
//  TaskMenuItemView.h
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TaskMenuItemView : UIView

@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic)UIButton *btnSelect;
@property (nonatomic, strong) UIScrollView *scrollViewInfo;

- (id)initWithFrame:(CGRect)frame task:(Task *)task;

@end
