//
//  TaskOneViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskOneViewController.h"

@interface TaskOneViewController ()

@end

@implementation TaskOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.taskOneInfoVC = [[TaskOneInfoViewController alloc] init];
//        [self addChildViewController:self.taskOneInfoVC];
//        [self.view addSubview:self.taskOneInfoVC.view];
//        [self.taskOneInfoVC didMoveToParentViewController:self];
        
        
        self.taskOneCameraVC = [[TaskOneCameraViewController alloc] init];
        [self addChildViewController:self.taskOneCameraVC];
        [self.view addSubview:self.taskOneCameraVC.view];
        [self.taskOneCameraVC didMoveToParentViewController:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view.btnBack addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[TaskOneView alloc] initWithFrame:bounds];
}

- (void)btnBackTapped:(id)sender
{
    TaskMenuViewController *taskMenuVC = [[TaskMenuViewController alloc] init];
    [self.navigationController pushViewController:taskMenuVC animated:YES];
}

@end
