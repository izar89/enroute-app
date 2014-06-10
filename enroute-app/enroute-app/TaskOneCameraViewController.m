//
//  TaskOneCameraViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskOneCameraViewController.h"

@interface TaskOneCameraViewController ()
@property (nonatomic, strong) VideoCaptureManager *videoCaptureManager;
@property (nonatomic, strong) AudioCaptureManager *audioCaptureManager;
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
    
    self.videoCaptureManager = [[VideoCaptureManager alloc] initWithPreviewView:self.view.videoPreviewView];
    self.videoCaptureManager.delegate = self;
    
    self.audioCaptureManager = [[AudioCaptureManager alloc] init];
    self.audioCaptureManager.delegate = self;
    
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
    //[self.captureManager startVideoRecording];
    [self.videoCaptureManager startVideoRecording];
}

- (void)btnRecordVideoUp:(id)sender
{
    //[self.captureManager stopRecording];
    [self.videoCaptureManager stopVideoRecording];
}

#pragma mark - btnRecordAudio
- (void)btnRecordAudioDown:(id)sender
{
    [self.audioCaptureManager startAudioRecording];
}

- (void)btnRecordAudioUp:(id)sender
{
    [self.audioCaptureManager stopAudioRecording];
}

#pragma mark - Delegates videoCaptureManager
- (void)videoRecordingDidFailWithError:(NSError *)error
{
    NSLog(@"videoRecordingDidFailWithError");
}

- (void)videoRecordingWillBegin
{
    NSLog(@"videoRecordingWillBegin");
}

- (void)videoRecordingBegan
{
    NSLog(@"videoRecordingBegan");
}

- (void)videoRecordingWillFinish
{
    NSLog(@"videoRecordingWillFinish");
}

- (void)videoRecordingFinished:(NSURL *)outputFileURL
{
    NSLog(@"videoRecordingFinished: %@", outputFileURL);
}

#pragma mark - Delegates audioCaptureManager
- (void)audioRecordingDidFailWithError:(NSError *)error
{
    NSLog(@"audioRecordingDidFailWithError");
}

- (void)audioRecordingWillBegin
{
    NSLog(@"audioRecordingWillBegin");
}

- (void)audioRecordingBegan
{
    NSLog(@"audioRecordingBegan");
}

- (void)audioRecordingWillFinish
{
    NSLog(@"audioRecordingWillFinish");
}

- (void)audioRecordingFinished:(NSURL *)outputFileURL
{
    NSLog(@"audioRecordingFinished: %@", outputFileURL);
}

@end
