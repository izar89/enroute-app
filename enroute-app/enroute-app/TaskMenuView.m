//
//  TaskMenuView.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskMenuView.h"

@interface TaskMenuView()
@property (nonatomic, strong) NSArray *tasks;
@end

@implementation TaskMenuView

- (id)initWithFrame:(CGRect)frame tasks:(NSArray *)tasks
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tasks = tasks;
        
        self.backgroundColor = [UIColor enrouteBlueColor];
        [self createCameraView];
        [self createTasks];
    }
    return self;
}

- (void)createCameraView
{
    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.videoPreviewView];
}

- (void)createTasks
{
    int taskTotal = (int)self.tasks.count;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollView.scrollEnabled = NO;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * taskTotal, 0);
    [self addSubview:self.scrollView];
    
    self.taskMenuItemViews = [NSMutableArray array];
    TaskMenuItemView *firstTaskMenuItemView;
    for (int i = 0; i < taskTotal; i++) {
        UIImage *bgInfo = [UIImage imageNamed:@"bgInfoTekstTaskMenuItem"];
        TaskMenuItemView *taskMenuItemView = [[TaskMenuItemView alloc] initWithFrame:CGRectMake(0, 0, bgInfo.size.width, bgInfo.size.height + 62) task:[self.tasks objectAtIndex:i]];
        taskMenuItemView.center = CGPointMake(self.frame.size.width / 2 + self.frame.size.width * i, (self.frame.size.height / 2) + 25);
        [self.scrollView addSubview:taskMenuItemView];
        [self.taskMenuItemViews addObject:taskMenuItemView];
        if(i == 0){
            firstTaskMenuItemView = [[TaskMenuItemView alloc] initWithFrame:CGRectMake(0, 0, bgInfo.size.width, bgInfo.size.height + 62) task:[self.tasks objectAtIndex:i]];
        }
    }
    
    // copy of first
    firstTaskMenuItemView.center = CGPointMake(self.frame.size.width / 2  + self.frame.size.width * self.taskMenuItemViews.count, (self.frame.size.height / 2) + 25);
    [self.scrollView addSubview:firstTaskMenuItemView];
    [self.taskMenuItemViews addObject: firstTaskMenuItemView];
}

@end
