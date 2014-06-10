//
//  TaskOneCameraViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskOneCameraViewController.h"

@interface TaskOneCameraViewController ()
@property (nonatomic, strong) CaptureManager *captureManager;
@end

@implementation TaskOneCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.captureManager = [[CaptureManager alloc] initWithPreviewView:self.view.videoPreviewView];
    self.captureManager.delegate = self;
    [self.view.btnRecordVideo addTarget:self action:@selector(btnRecordVideoDown:) forControlEvents:UIControlEventTouchDown];
    [self.view.btnRecordVideo addTarget:self action:@selector(btnRecordVideoUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnRecordAudio addTarget:self action:@selector(btnRecordAudioDown:) forControlEvents:UIControlEventTouchDown];
    [self.view.btnRecordAudio addTarget:self action:@selector(btnRecordAudioUp:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.captureManager viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.captureManager viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[TaskOneCameraView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height - 40)];
}

#pragma mark - btnRecordVideo
- (void)btnRecordVideoDown:(id)sender
{
    [self.captureManager startVideoRecording];
}

- (void)btnRecordVideoUp:(id)sender
{
    [self.captureManager stopRecording];
}

#pragma mark - btnRecordAudio
- (void)btnRecordAudioDown:(id)sender
{
    
}

- (void)btnRecordAudioUp:(id)sender
{
    
}

#pragma mark - Delegates captureManager
- (void)recordingDidFailWithError:(NSError *)error
{
    
}

- (void)recordingWillBegin
{
    NSLog(@"recordingWillBegin");
}

- (void)recordingBegan
{
    NSLog(@"recordingBegan");
}

- (void)recordingWillFinish
{
    NSLog(@"recordingWillFinish");
}

- (void)recordingFinished:(NSURL *)outputFileURL
{
    NSLog(@"recordingFinished: %@", outputFileURL);
}

@end
