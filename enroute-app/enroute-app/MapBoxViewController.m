//
//  MapBoxViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 16/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "MapBoxViewController.h"

@interface MapBoxViewController ()

@end

@implementation MapBoxViewController

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

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[MapBoxView alloc] initWithFrame:bounds];
}

- (void)btnBackTapped:(id)sender
{
    NSLog(@"tap tap");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
