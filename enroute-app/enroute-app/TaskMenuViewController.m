//
//  TaskMenuViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskMenuViewController.h"

@interface TaskMenuViewController ()
@property (nonatomic, assign) BOOL introHasShown;
@property (strong, nonatomic) JSONDataManager *dataManager;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) float previousHeading;
@property (nonatomic, strong) VideoCaptureManager *videoCaptureManager;
@end

@implementation TaskMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataManager = [JSONDataManager sharedInstance];
        self.videoCaptureManager = [[VideoCaptureManager alloc] initWithPreviewView:self.view.videoPreviewView];
        self.locationManager = [self setupLocationManager];
    }
    return self;
}

- (CLLocationManager *)setupLocationManager
{
    CLLocationManager *locationManager =  [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    //        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //        self.locationManager.headingFilter = 5;
    //        [self.locationManager startUpdatingHeading];
    //        NSLog(@"%f", self.locationManager.heading.magneticHeading);
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; //delete
    [locationManager startUpdatingHeading]; //delete
    
    return locationManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    for(TaskMenuItemView *taskMenuItemView in self.view.taskMenuItemViews){
        [taskMenuItemView.btnSelect addTarget:self action:@selector(btnSelectTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    /*
    float randHeight = arc4random_uniform(self.view.frame.size.height);
    float randRotation = arc4random_uniform(20);
    float degrees = randRotation;
    UIImage *image = [UIImage imageNamed:@"intro_huis_1"];
    
    UIImageView *huis1 = [[UIImageView alloc] initWithImage:image];
    huis1.center = CGPointMake(0, randHeight);
    huis1.transform = CGAffineTransformMakeRotation(degrees * M_PI/180);
    [self.view addSubview:huis1];
    
    [UIView animateWithDuration:1
                     animations:^{
                         [huis1 setCenter:CGPointMake(heading, randHeight)];
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!self.introHasShown){
        IntroViewController *introVC = [[IntroViewController alloc] initWithNibName:nil bundle:nil];
        [self presentViewController:introVC animated:NO completion:^{}];
        self.introHasShown = YES;
    }
    
    [self.videoCaptureManager startCaptureSession];
    
    [self setContentOffsetWithHeading:self.previousHeading animated:NO];
    [self.locationManager startUpdatingHeading];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.videoCaptureManager stopCaptureSession];
    
    [self.locationManager stopUpdatingHeading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[TaskMenuView alloc] initWithFrame:bounds tasks:self.dataManager.tasks];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    [self setContentOffsetWithHeading:theHeading animated:YES];
}

- (void)setContentOffsetWithHeading:(float)heading animated:(BOOL)animated{
    float offset = [self map:heading in_min:0 in_max:360 out_min:0 out_max:self.view.scrollView.frame.size.width * (self.view.taskMenuItemViews.count - 1)];
    
    if (animated) {
        //NSLog(@"%f ,%f, %f", self.previousHeading, heading , offset);
        if (abs(heading - self.previousHeading) > 100) {
            //NSLog(@"true");
            if ((heading - self.previousHeading) > 0) {
                //NSLog(@"left");
            } else {
                //NSLog(@"right");
            }
        } else {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 [self.view.scrollView setContentOffset:CGPointMake(offset, 0) animated:NO];
                             } completion:^(BOOL finished) {}];
        }
    } else {
        [self.view.scrollView setContentOffset:CGPointMake(offset, 0) animated:NO];
    }
    
    self.previousHeading = heading;
    //[self.view.scrollView setContentOffset:CGPointMake(offset, 0) animated:NO]; //delete
}

- (float)map:(float)x in_min:(float)in_min in_max:(float)in_max out_min:(float)out_min out_max:(float)out_max
{
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

- (void)btnSelectTapped:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int index = (int)[self.view.taskMenuItemViews indexOfObject:(TaskMenuItemView *)btn.superview];
    if(index == 0 || index == self.view.taskMenuItemViews.count - 1){
        TaskTwoViewController *taskTwoVC = [[TaskTwoViewController alloc] init];
        [self.navigationController pushViewController:taskTwoVC animated:YES];
    } else if (index == 1){
        TaskOneViewController *taskOneVC = [[TaskOneViewController alloc] init];
        [self.navigationController pushViewController:taskOneVC animated:YES];
    }
}

@end
