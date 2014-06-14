//
//  TaskTwoView.h
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskTwoView : UIView

/* Navigation bar */
@property (strong, nonatomic)UIView *navigationBarView;
@property (strong, nonatomic)UIButton *btnBack;
@property (strong, nonatomic)UIButton *btnMap;
@property (strong, nonatomic)UIButton *btnInfo;
@property (strong, nonatomic)UIButton *btnCloseInfo;

- (void)setBtnInfoOpen:(BOOL)Open;

/* Content */
@property (strong, nonatomic) UIView *contentContainerView;

@end
