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
        
        self.fileManager = [[AVCamFileManager alloc] init];
        self.fileManager.delegate = self;
        
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
    for(CameraPartView *cameraPartView in self.view.cameraPartViews){
        [cameraPartView.btnRecord addTarget:self action:@selector(btnRecordDown:) forControlEvents:UIControlEventTouchDown];
        [cameraPartView.btnRecord addTarget:self action:@selector(btnRecordUp:) forControlEvents:UIControlEventTouchUpInside];
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
    self.view = [[TaskOneCameraView alloc] initWithFrame:bounds];
}

- (void)btnRecordDown:(id)sender
{
    NSLog(@"start");
    
    UIButton *btn = (UIButton *)sender;
    self.recordIndex = (int)[self.view.cameraPartViews indexOfObject:(CameraPartView *)btn.superview];
    
    [[self captureManager] startRecording];
    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(recordingSuccess:) userInfo:nil repeats:NO];
}

- (void)btnRecordUp:(id)sender
{
    [self.recordTimer invalidate];
    self.recordTimer = nil;
    [self stopRecording];
}

- (void)recordingSuccess:(id)sender
{
    NSLog(@"success! - index:%i", self.recordIndex);

    //flash
    CameraPartView *cameraPartView = [self.view.cameraPartViews objectAtIndex:self.recordIndex];
    UIView *flashView = [[UIView alloc] initWithFrame:cameraPartView.bounds];
    [cameraPartView addSubview:flashView];
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [UIView animateWithDuration:0.4 animations:^{
        [flashView setAlpha:0];
    } completion:^(BOOL finished){
        [flashView removeFromSuperview];
    }];
    
    [self stopRecording];
}

- (void)stopRecording
{
    if ([[[self captureManager] recorder] isRecording]){
        NSLog(@"stop");
        [[self captureManager] stopRecording];
    }
}

#pragma mark - Delegates captureManager
- (void)captureManagerRecordingBegan:(AVCamCaptureManager *)captureManager
{
    NSLog(@"captureManagerRecordingBegan");
}

- (void)captureManagerRecordingFinished:(AVCamCaptureManager *)captureManager outputFileURL:(NSURL *)outputFileURL
{
    NSLog(@"captureManagerRecordingFinished");
    [self.fileManager saveFileToLibrary:outputFileURL];
}

#pragma mark - Delegates fileManager
- (void) fileManagerSaveFileToLibraryFinished:(AVCamFileManager *)fileManager
{
    NSLog(@"fileManagerSaveFileToLibraryFinished");
}


@end
