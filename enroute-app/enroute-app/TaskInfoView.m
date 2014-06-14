//
//  TaskOneInfoView.m
//  enroute-app
//
//  Created by Stijn Heylen on 30/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskInfoView.h"

@interface TaskInfoView()
@property (strong, nonatomic) TaskInfos *taskInfos;
@property (strong, nonatomic) UIView *container;
@end

@implementation TaskInfoView

- (id)initWithFrame:(CGRect)frame taskInfos:(TaskInfos *)taskInfos
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.taskInfos = taskInfos;
        
        self.backgroundColor = [UIColor clearColor];
        [self createContainer]; // Add all subviews in container!
        [self createInfoScroll];
        [self createScrollPageControl];
    }
    return self;
}

- (void)createContainer
{
    UIImage *infoBg = [UIImage imageNamed:@"infoBg"];
    UIImageView *infoBgView = [[UIImageView alloc] initWithImage:infoBg];
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 245)];
    [self.container addSubview:infoBgView];
    [self addSubview:self.container];
}

- (void)createInfoScroll
{
    self.scrollInfoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 237)];
    self.scrollInfoView.pagingEnabled = YES;
    self.scrollInfoView.clipsToBounds = NO;
    [self.scrollInfoView setShowsHorizontalScrollIndicator:NO];
    [self.container addSubview:self.scrollInfoView];
    
    int posX = 0;
    self.taskInfoViews = [NSMutableArray array];
    for (TaskInfo *taskInfo in self.taskInfos.taskInfos) {
        TaskInfoItemView *taskInfoView = [[TaskInfoItemView alloc] initWithFrame:self.scrollInfoView.frame text:taskInfo.text imageName:taskInfo.imageName];
        taskInfoView.center = CGPointMake(posX + self.frame.size.width / 2, self.scrollInfoView.frame.size.height  / 2);
        [self.scrollInfoView addSubview:taskInfoView];
        [self.taskInfoViews addObject:taskInfoView];
        posX += self.frame.size.width;
    }
    self.scrollInfoView.contentSize = CGSizeMake(self.taskInfoViews.count * self.frame.size.width, 0);
}

- (void)createScrollPageControl
{
    self.scrollPageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    self.scrollPageControl.numberOfPages = self.taskInfoViews.count;
    CGSize sizeOfPageControl = [self.scrollPageControl sizeForNumberOfPages:self.scrollPageControl.numberOfPages];
    self.scrollPageControl.frame = CGRectMake(0, 0, sizeOfPageControl.width, sizeOfPageControl.height);
    self.scrollPageControl.center = CGPointMake(self.container.frame.size.width / 2, self.container.frame.size.height - (sizeOfPageControl.height / 2 + 5 ));
    
    self.scrollPageControl.currentPageIndicatorTintColor = [UIColor enrouteLightYellowColor];
    [self.container addSubview:self.scrollPageControl];
}

@end
