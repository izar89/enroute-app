//
//  TaskMenuView.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskMenuView.h"

@implementation TaskMenuView

- (id)initWithFrame:(CGRect)frame tasks:(Tasks *)tasks
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.57 green:0.87 blue:0.78 alpha:1];
        [self createCameraView];
        
        int taskTotal = (int)tasks.tasks.count;
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(frame.size.width * taskTotal, 0);
        [self addSubview:self.scrollView];
        
        self.taskMenuItemViews = [NSMutableArray array];
        TaskMenuItemView *firstTaskMenuItemView;
        for (int i = 0; i < taskTotal; i++) {
            UIImage *bgInfo = [UIImage imageNamed:@"bgInfoTekstTaskMenuItem"];
            TaskMenuItemView *taskMenuItemView = [[TaskMenuItemView alloc] initWithFrame:CGRectMake(0, 0, bgInfo.size.width, bgInfo.size.height + 62) task:[tasks.tasks objectAtIndex:i]];
            taskMenuItemView.center = CGPointMake(frame.size.width / 2 + frame.size.width * i, (frame.size.height / 2) + 25);
            [self.scrollView addSubview:taskMenuItemView];
            [self.taskMenuItemViews addObject:taskMenuItemView];
            if(i == 0){
                firstTaskMenuItemView = [[TaskMenuItemView alloc] initWithFrame:CGRectMake(0, 0, bgInfo.size.width, bgInfo.size.height + 62) task:[tasks.tasks objectAtIndex:i]];
            }
        }
        
        // copy of first
        firstTaskMenuItemView.center = CGPointMake(frame.size.width / 2  + frame.size.width * self.taskMenuItemViews.count, (frame.size.height / 2) + 25);
        [self.scrollView addSubview:firstTaskMenuItemView];
        [self.taskMenuItemViews addObject: firstTaskMenuItemView];
    }
    return self;
}

- (void)createCameraView
{
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.videoPreviewView];
}

@end
