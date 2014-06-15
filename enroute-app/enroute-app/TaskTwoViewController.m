//
//  TaskTwoViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskTwoViewController.h"

@interface TaskTwoViewController ()
@property (strong, nonatomic) JSONDataManager *dataManager;
@property (nonatomic, assign) BOOL infoIsOpen;
@end

@implementation TaskTwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataManager = [JSONDataManager sharedInstance];
        
        self.taskTwoCameraVC = [[TaskTwoCameraViewController alloc] init];
        [self addChildViewController:self.taskTwoCameraVC];
        [self.view.contentContainerView addSubview:self.taskTwoCameraVC.view];
        [self.taskTwoCameraVC didMoveToParentViewController:self];
        
        [self.view.contentContainerView addSubview:self.view.btnCloseInfo];
        
        self.taskTwoInfoVC = [[TaskInfoViewController alloc] initWithTaskInfos:self.dataManager.taskTwoInfos];
        [self addChildViewController:self.taskTwoInfoVC];
        [self.view.contentContainerView addSubview:self.taskTwoInfoVC.view];
        [self.taskTwoInfoVC didMoveToParentViewController:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view.btnBack addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnInfo addTarget:self action:@selector(btnInfoTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"TaskTwoInfoViewHide"]){ // Only show once
        [self showInfoView:NO animated:NO];
    } else {
        [self showInfoView:YES animated:NO];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TaskTwoInfoViewHide"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[TaskTwoView alloc] initWithFrame:bounds];
}

- (void)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnInfoTapped:(id)sender
{
    if(self.infoIsOpen){
        [self showInfoView: NO animated:YES];
    } else {
        [self showInfoView:YES animated:YES];
    }
}

- (void)showInfoView:(BOOL)show animated:(BOOL)animated{
    [self.view setBtnInfoOpen:show];
    if(show){
        self.infoIsOpen = YES;
        if(animated){
            [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
                self.taskTwoInfoVC.view.center = CGPointMake(self.view.frame.size.width / 2, self.taskTwoInfoVC.view.frame.size.height / 2 + 48);
                self.view.btnCloseInfo.alpha = 0.3;
            } completion:^(BOOL finished) {}];
        } else {
            self.taskTwoInfoVC.view.center = CGPointMake(self.view.frame.size.width / 2, self.taskTwoInfoVC.view.frame.size.height / 2 + 48);
            self.view.btnCloseInfo.alpha = 0.3;
        }
    } else {
        self.infoIsOpen = NO;
        if(animated){
            [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn animations:^{
                self.taskTwoInfoVC.view.center = CGPointMake(self.view.frame.size.width / 2, -self.taskTwoInfoVC.view.frame.size.height / 2);
                self.view.btnCloseInfo.alpha = 0;
            } completion:^(BOOL finished) {}];
        } else {
            self.taskTwoInfoVC.view.center = CGPointMake(self.view.frame.size.width / 2, -self.taskTwoInfoVC.view.frame.size.height / 2);
            self.view.btnCloseInfo.alpha = 0;
        }
    }
}

#pragma mark - Reroute events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view.btnCloseInfo];
    if([self.view.btnCloseInfo hitTest:point withEvent:event]){
        CGPoint point2 = [touch locationInView:self.view.navigationBarView];
        if(![self.view.navigationBarView hitTest:point2 withEvent:event]){
            [self showInfoView: NO animated:YES];
        }
    }
}

@end
