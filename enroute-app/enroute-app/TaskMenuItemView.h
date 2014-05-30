//
//  TaskMenuItemView.h
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskMenuItemView : UIView

@property (nonatomic) int taskId;
@property (strong, nonatomic)UIButton *btnSelect;

- (id)initWithFrame:(CGRect)frame taskId:(int)taskId;

@end
