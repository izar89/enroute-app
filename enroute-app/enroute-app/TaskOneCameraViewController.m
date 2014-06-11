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
@property (nonatomic, strong) FileManager *fileManager;
@property (nonatomic, strong) NSMutableArray *floors;
@property (nonatomic, assign) int floorIndex;
@end

@implementation TaskOneCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.fileManager = [[FileManager alloc] init];
        self.fileManager.delegate = self;
        
        self.floors = [NSMutableArray array];
        self.floorIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.scrollFloorsView.delegate = self;
    [self addNewFloor]; // first floor
    
    self.videoCaptureManager = [[VideoCaptureManager alloc] initWithPreviewView:self.view.videoPreviewView];
    self.videoCaptureManager.delegate = self;
    [self.videoCaptureManager setOutputDimensionsWidth:280 height:136];
    
    self.audioCaptureManager = [[AudioCaptureManager alloc] init];
    self.audioCaptureManager.delegate = self;
    
    [self.view.btnAddFloor addTarget:self action:@selector(btnAddFloorTapped:) forControlEvents:UIControlEventTouchDown];
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

#pragma mark - btnAddFloor
- (void)btnAddFloorTapped:(id)sender
{
    NSLog(@"test");
    [self addNewFloor];
}

- (void)addNewFloor
{
//    FloorView *floorView = [[FloorView alloc] initWithDefinedDimensions];
//    floorView.id = self.floorIndex;
//    [self.view.scrollFloorsView insertSubview:floorView atIndex:0];
//    floorView.center = CGPointMake(floorView.frame.size.width / 2, (floorView.frame.size.height / 2) + (floorView.frame.size.height * self.floors.count));
//    [self.floors addObject:floorView];
//    self.view.scrollFloorsView.contentSize = CGSizeMake(0, floorView.frame.size.height * self.floors.count);
//    self.floorIndex++;
//    
//    self.view.floorGround.center = CGPointMake(floorView.frame.size.width / 2, (floorView.frame.size.height / 2) + (floorView.frame.size.height * self.floors.count + 2));
    
    FloorView *floorView = [[FloorView alloc] initWithDefinedDimensionsAndId:self.floorIndex];
    [self.view.scrollFloorsView insertSubview:floorView atIndex:0];
    [self.floors addObject:floorView];
    
    int posY = self.floors.count * floorView.frame.size.height;
    
    // Ground
    self.view.floorGround.center = CGPointMake(floorView.frame.size.width / 2, posY + (floorView.frame.size.height / 2) + 2);
    
    self.view.scrollFloorsView.contentSize = CGSizeMake(0, posY);
    for(FloorView* floorView in self.floors){
        floorView.center = CGPointMake(floorView.frame.size.width/2, posY - (floorView.frame.size.height / 2));
        posY -= floorView.frame.size.height;
    }
    
    // Add floor
    [self.view.scrollFloorsView insertSubview:self.view.addFloorView atIndex:0];
    
    self.floorIndex++;
}

#pragma mark - btnRecordVideo
- (void)btnRecordVideoDown:(id)sender
{
    [self.videoCaptureManager startVideoRecording];
}

- (void)btnRecordVideoUp:(id)sender
{
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

#pragma mark - Delegates scrollFloorsView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scroll");
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
