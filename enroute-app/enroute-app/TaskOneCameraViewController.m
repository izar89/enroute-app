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
    
    for(CameraPartView *cameraPartView in self.view.cameraPartViews){
        [cameraPartView.btnRecord removeTarget:self action:@selector(btnRecordDown:) forControlEvents:UIControlEventTouchDown];
    }
    
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
    self.recordSuccess = YES;
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
- (void)captureManagerRecordingBegan:(CameraCaptureManager *)captureManager
{
    NSLog(@"captureManagerRecordingBegan");
}

- (void)captureManagerRecordingFinished:(CameraCaptureManager *)captureManager outputFileURL:(NSURL *)outputFileURL
{
    NSLog(@"captureManagerRecordingFinished");
    
    if(self.recordSuccess){
        [self cropVideo:outputFileURL recordIndex:self.recordIndex];
        //[self.fileManager saveFileToLibrary:outputFileURL];
        self.recordSuccess = NO;
    }
    
    // Add target
    for(CameraPartView *cameraPartView in self.view.cameraPartViews){
        [cameraPartView.btnRecord addTarget:self action:@selector(btnRecordDown:) forControlEvents:UIControlEventTouchDown];
    }
}

#pragma mark - Delegates fileManager
- (void) fileManagerSaveFileToLibraryFinished:(CameraFileManager *)fileManager
{
    NSLog(@"fileManagerSaveFileToLibraryFinished");
}

- (void)cropVideo:(NSURL *)fileURL recordIndex:(int)recordIndex{
    AVAsset *asset = [AVAsset assetWithURL:fileURL];
    
    AVAssetTrack *clipVideoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    NSLog(@"1) width: %f, height: %f",clipVideoTrack.naturalSize.width, clipVideoTrack.naturalSize.height);
    
    AVMutableVideoComposition* videoComposition = [AVMutableVideoComposition videoComposition];
    videoComposition.frameDuration = CMTimeMake(1, 30);
    videoComposition.renderSize = CGSizeMake(clipVideoTrack.naturalSize.height, clipVideoTrack.naturalSize.height / 2);
    
    AVMutableVideoCompositionInstruction *instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(60, 30));
    
    AVMutableVideoCompositionLayerInstruction* transformer = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:clipVideoTrack];
    
    //CGAffineTransform t1 = CGAffineTransformMakeTranslation(clipVideoTrack.naturalSize.height, -(clipVideoTrack.naturalSize.width - clipVideoTrack.naturalSize.height) /2 );
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(clipVideoTrack.naturalSize.height, 0 );
    
    CGAffineTransform t2 = CGAffineTransformRotate(t1, M_PI_2);
    
    CGAffineTransform finalTransform = t2;
    [transformer setTransform:finalTransform atTime:kCMTimeZero];
    
    instruction.layerInstructions = [NSArray arrayWithObject:transformer];
    videoComposition.instructions = [NSArray arrayWithObject: instruction];
    
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *exportPath = [documentsPath stringByAppendingFormat:@"/CroppedVideo.mp4"];
    NSURL *exportUrl = [NSURL fileURLWithPath:exportPath];
    
    [[NSFileManager defaultManager]  removeItemAtURL:exportUrl error:nil];
    
    self.exporter = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetHighestQuality] ;
    self.exporter.videoComposition = videoComposition;
    self.exporter.outputURL = exportUrl;
    self.exporter.outputFileType = AVFileTypeQuickTimeMovie;
    
    [self.exporter exportAsynchronouslyWithCompletionHandler:^
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             //Call when finished
             [self exportDidFinish:self.exporter];
         });
     }];
}
    
- (void)exportDidFinish:(AVAssetExportSession*)session
{
    //Play the New Cropped video
    NSURL *outputURL = session.outputURL;
    AVAsset *asset = [AVAsset assetWithURL:outputURL];
    AVAssetTrack *clipVideoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    NSLog(@"2) width: %f, height: %f",clipVideoTrack.naturalSize.width, clipVideoTrack.naturalSize.height);
    
    
    [self.fileManager saveFileToLibrary:outputURL];
}



@end
