//
//  TaskOneViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 29/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskOneViewController.h"

@interface TaskOneViewController ()
@property (strong, nonatomic) JSONDataManager *dataManager;
@property (nonatomic, assign) BOOL infoIsOpen;
@end

@implementation TaskOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataManager = [JSONDataManager sharedInstance];
        
        self.taskOneCameraVC = [[TaskOneCameraViewController alloc] init];
        [self addChildViewController:self.taskOneCameraVC];
        [self.view.contentContainerView addSubview:self.taskOneCameraVC.view];
        [self.taskOneCameraVC didMoveToParentViewController:self];
        
        [self.view.contentContainerView addSubview:self.view.btnCloseInfo];
        
        self.taskOneInfoVC = [[TaskInfoViewController alloc] initWithTaskInfos:self.dataManager.taskOneInfos];
        [self addChildViewController:self.taskOneInfoVC];
        [self.view.contentContainerView addSubview:self.taskOneInfoVC.view];
        [self.taskOneInfoVC didMoveToParentViewController:self];
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
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"TaskOneInfoViewHide"]){ // Only show once
        [self showInfoView:NO animated:NO];
    } else {
        [self showInfoView:YES animated:NO];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TaskOneInfoViewHide"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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
//    TaskMenuViewController *taskMenuVC = [[TaskMenuViewController alloc] init];
//    [self.navigationController pushViewController:taskMenuVC animated:YES];
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
                self.taskOneInfoVC.view.center = CGPointMake(self.view.frame.size.width / 2, self.taskOneInfoVC.view.frame.size.height / 2 + 48);
                self.view.btnCloseInfo.alpha = 0.3;
            } completion:^(BOOL finished) {}];
        } else {
            self.taskOneInfoVC.view.center = CGPointMake(self.view.frame.size.width / 2, self.taskOneInfoVC.view.frame.size.height / 2 + 48);
            self.view.btnCloseInfo.alpha = 0.3;
        }
    } else {
        self.infoIsOpen = NO;
        if(animated){
            [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn animations:^{
                self.taskOneInfoVC.view.center = CGPointMake(self.view.frame.size.width / 2, -self.taskOneInfoVC.view.frame.size.height / 2);
                self.view.btnCloseInfo.alpha = 0;
            } completion:^(BOOL finished) {}];
        } else {
            self.taskOneInfoVC.view.center = CGPointMake(self.view.frame.size.width / 2, -self.taskOneInfoVC.view.frame.size.height / 2);
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
