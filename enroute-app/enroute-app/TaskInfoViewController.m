//
//  TaskOneInfoViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 30/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskInfoViewController.h"

@interface TaskInfoViewController ()
@property (strong, nonatomic) NSArray *taskInfos;
@end

@implementation TaskInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.scrollInfoView.delegate = self;
    }
    return self;
}

- (id)initWithTaskInfos:(NSArray *)taskInfos
{
    self.taskInfos = taskInfos;
    return [self initWithNibName:nil bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[TaskInfoView alloc] initWithFrame:CGRectMake(0, 48, bounds.size.width, bounds.size.height - 48) taskInfos:self.taskInfos];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.view.scrollPageControl.currentPage = page;
}

@end
