//
//  IntroViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingHeading];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view.btnBegin addTarget:self action:@selector(btnStartTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[IntroView alloc] initWithFrame:bounds];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [self.locationManager stopUpdatingHeading];
    
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    self.heading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
}


- (void)btnStartTapped:(id)sender
{
    TaskMenuViewController *taskMenuVC = [[TaskMenuViewController alloc] initWithHeading:self.heading];
    [self.navigationController pushViewController:taskMenuVC animated:YES];
}

@end
