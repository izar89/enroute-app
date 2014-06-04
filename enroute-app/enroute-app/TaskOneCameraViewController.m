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
        
        self.captureManager = [[CameraCaptureManager alloc] init];
        self.captureManager.delegate = self;
        
        self.recordSuccess = NO;
        self.fileManager = [[CameraFileManager alloc] init];
        self.fileManager.delegate = self;
        
        // Create video preview layer
        self.view.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[[self captureManager] session]];
        self.view.captureVideoPreviewLayer.bounds = CGRectMake(0, 0, 480, 270);
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
//    for(CameraPartView *cameraPartView in self.view.cameraPartViews){
//        [cameraPartView.btnRecord addTarget:self action:@selector(btnRecordDown:) forControlEvents:UIControlEventTouchDown];
//    }
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
    
//    for(CameraPartView *cameraPartView in self.view.cameraPartViews){
//        [cameraPartView.btnRecord removeTarget:self action:@selector(btnRecordDown:) forControlEvents:UIControlEventTouchDown];
//    }
    
    [[self captureManager] startRecording];
    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(recordingSuccess:) userInfo:nil repeats:NO];
}

- (void)btnRecordUp:(id)sender
{
    NSLog(@"stop");
    
    [self.recordTimer invalidate];
    self.recordTimer = nil;
    [self stopRecording];
}

- (void)recordingSuccess:(id)sender
{
    self.recordSuccess = YES;
    [self stopRecording];
}

- (void)stopRecording
{
    if ([[[self captureManager] recorder] isRecording]){
        [[self captureManager] stopRecording];
    }
}

#pragma mark - Delegates captureManager
- (void)captureManagerRecordingBegan:(CameraCaptureManager *)captureManager
{
    NSLog(@"captureManagerRecordingBegan");
}

- (void)captureManagerRecordingFinished:(CameraCaptureManager *)captureManager outputFileURL:(NSURL *)outputFileURL
{
    NSLog(@"captureManagerRecordingFinished");
    
    if(self.recordSuccess){
        [self.fileManager saveFileToLibrary:outputFileURL];
        self.recordSuccess = NO;
    }
    
    // Add target
//    for(CameraPartView *cameraPartView in self.view.cameraPartViews){
//        [cameraPartView.btnRecord addTarget:self action:@selector(btnRecordDown:) forControlEvents:UIControlEventTouchDown];
//    }
}

#pragma mark - Delegates fileManager
- (void) fileManagerSaveFileToLibraryFinished:(CameraFileManager *)fileManager
{
    NSLog(@"fileManagerSaveFileToLibraryFinished");
}



@end
