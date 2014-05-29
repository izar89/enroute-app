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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view.btnBack addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchUpInside];
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
