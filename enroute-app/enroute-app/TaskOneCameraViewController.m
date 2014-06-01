//
//  TaskOneCameraViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskOneCameraViewController.h"

@interface TaskOneCameraViewController ()

@end

@implementation TaskOneCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.captureManager = [[AVCamCaptureManager alloc] init];
        self.captureManager.delegate = self;
        
        // Create video preview layer
        self.view.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[[self captureManager] session]];
        self.view.captureVideoPreviewLayer.bounds = self.view.videoPreviewView.bounds;
        self.view.captureVideoPreviewLayer.position = CGPointMake(self.view.videoPreviewView.bounds.size.width / 2, self.view.videoPreviewView.bounds.size.height / 2);
        self.view.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.videoPreviewView.layer insertSublayer:self.view.captureVideoPreviewLayer below:[self.view.videoPreviewView.layer sublayers][0]];
        
        // Start the session. This is done asychronously since -startRunning doesn't return until the session is running.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[[self captureManager] session] startRunning];
        });
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view.btnRecord addTarget:self action:@selector(btnRecordTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[TaskOneCameraView alloc] initWithFrame:bounds];
}

- (void)btnRecordTapped:(id)sender // toggle record
{
    if (![[[self captureManager] recorder] isRecording]){
        NSLog(@"start");
        [[self captureManager] startRecording];
    } else {
        NSLog(@"stop");
        [[self captureManager] stopRecording];
    }
}

- (void)captureManagerRecordingBegan:(AVCamCaptureManager *)captureManager
{
    NSLog(@"captureManagerRecordingBegan");
}

- (void)captureManagerRecordingFinished:(AVCamCaptureManager *)captureManager
{
    NSLog(@"captureManagerRecordingFinished");
}

@end
