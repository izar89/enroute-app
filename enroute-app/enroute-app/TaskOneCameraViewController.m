//
//  TaskOneCameraViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskOneCameraViewController.h"

@interface TaskOneCameraViewController ()
@property (nonatomic, strong) NSTimer *recordTimer;
@property (nonatomic, assign) BOOL recordSuccess;
@property (nonatomic, strong) VideoCaptureManager *videoCaptureManager;
@property (nonatomic, strong) AudioCaptureManager *audioCaptureManager;
@property (nonatomic, strong) FileManager *fileManager;
@property (nonatomic, strong) APIManager *apiManager;
@property (nonatomic, strong) NSMutableArray *floors;
@property (nonatomic, assign) int floorIndex;
@property (nonatomic, assign) int selectedFloorViewIndex;
@end

@implementation TaskOneCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.fileManager = [[FileManager alloc] init];
        self.fileManager.delegate = self;
        
        [self.fileManager removeFileOrDirectory:[self.fileManager floorsTmpDirUrl]];
        [self.fileManager createDirectoryAtDirectory:[self.fileManager tempDirectoryPath] withName:[self.fileManager floorsTmpDirUrl].lastPathComponent];
        
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
    
    [self.view.btnRecordVideo addTarget:self action:@selector(btnRecordVideoDown:) forControlEvents:UIControlEventTouchDown];
    [self.view.btnRecordVideo addTarget:self action:@selector(btnRecordVideoUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnRecordAudio addTarget:self action:@selector(btnRecordAudioDown:) forControlEvents:UIControlEventTouchDown];
    [self.view.btnRecordAudio addTarget:self action:@selector(btnRecordAudioUp:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touch:(UIGestureRecognizer *)gesture
{
    NSLog(@"I was tapped");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[TaskOneCameraView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height - 48)];
}

- (void)checkBuilding
{
    NSLog(@"-----------------------------------------------");
    int totalFloorsReady = 0; // if = floors.count -> ready to save
    BOOL videoReady = NO;
    BOOL audioReady = NO;

    for(FloorViewController *floorVC in self.floors){
        if(floorVC.videoURL){
            videoReady = YES;
        }
        if(floorVC.audioURL){
            audioReady = YES;
        }
        if(videoReady && audioReady){
            totalFloorsReady++;
        }
        if (floorVC.id == self.selectedFloorViewIndex) {
            NSLog(@"videoReady!: %i", videoReady);
            NSLog(@"audioReady!: %i", audioReady);
            [self.view setBtnVideoReady:videoReady];
            [self.view setBtnAudioReady:audioReady];
            
            if (videoReady && audioReady) {
                // Add floor ready
                
                NSLog(@"AddFloorReady!");
                [self.view.btnAddFloor addTarget:self action:@selector(btnAddFloorTapped:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [self.view.btnAddFloor removeTarget:self action:@selector(btnAddFloorTapped:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        videoReady = audioReady = NO;
    }
    
    if (self.floors.count == totalFloorsReady && totalFloorsReady >= 2) {
        NSLog( @"SaveReady!");
        // Save ready
        [self showBtnSave:YES];
    } else {
        [self showBtnSave:NO];
    }
}

- (void)showBtnSave:(BOOL)show
{
    if(show){
        NSLog(@"show");
        [UIView animateWithDuration:2.0 animations:^{
            self.view.btnSave.center = CGPointMake((self.view.btnSave.frame.size.width / 2 + 20), self.view.bottomToolbarView.frame.size.height / 2);
            //self.view.lblMinFloors.center = CGPointMake((self.view.lblMinFloors.frame.size.width / 2), self.view.bottomToolbarView.frame.size.height / 2);
        } completion:^(BOOL finished) {
            [self.view.btnSave addTarget:self action:@selector(btnSaveTapped:) forControlEvents:UIControlEventTouchUpInside];
        }];
    } else {
        [UIView animateWithDuration:2.0 animations:^{
            self.view.btnSave.center = CGPointMake((self.view.btnSave.frame.size.width / 2 + 20) - 100, self.view.bottomToolbarView.frame.size.height / 2);
            //self.view.lblMinFloors.center = CGPointMake((self.view.lblMinFloors.frame.size.width / 2), self.view.bottomToolbarView.frame.size.height / 2);
        } completion:^(BOOL finished) {
            [self.view.btnSave removeTarget:self action:@selector(btnSaveTapped:) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
}

#pragma mark - btnSave
- (void)btnSaveTapped:(id)sender
{
    NSLog(@"save");
//    self.apiManager = [[APIManager alloc] init];
//    [self.apiManager test:nil];
}

#pragma mark - btnAddFloor
- (void)btnAddFloorTapped:(id)sender
{
    [self addNewFloor];
}

- (void)addNewFloor
{
    // New Floor
    FloorViewController *floorVC = [[FloorViewController alloc] initWithDefinedDimensionsAndId:self.floorIndex];
    [self addChildViewController:floorVC];
    [self.view.scrollFloorsView insertSubview:floorVC.view atIndex:0];
    [floorVC didMoveToParentViewController:self];
    [self.floors addObject:floorVC];
    
    if(self.floors.count %2 == 0){
        [floorVC.view setRed];
    } else {
        [floorVC.view setBlue];
    }
    
    // Set contentsize
    self.view.scrollFloorsView.contentSize = CGSizeMake(0, self.floors.count * self.view.scrollFloorsView.frame.size.height);
    NSLog(@"%f", self.view.scrollFloorsView.contentSize.height);
    
    // Calculate positions
    NSArray* floors_reversed = [[self.floors reverseObjectEnumerator] allObjects];
    int posY = floorVC.view.frame.size.height;
    int index = 0;
    for(FloorViewController* floorVC in floors_reversed){
        floorVC.view.center = CGPointMake(floorVC.view.frame.size.width/2, posY - (floorVC.view.frame.size.height / 2));
        if (index != 0) { // ! first item
            posY += self.view.scrollFloorsView.frame.size.height;
        }
        index++;
    }
    
    // Ground
    if (self.floors.count == 1) {
        self.view.floorGround.center = CGPointMake(floorVC.view.frame.size.width / 2, self.floors.count * self.view.scrollFloorsView.frame.size.height + (self.view.scrollFloorsView.frame.size.height / 2) + 2);
    } else {
        self.view.floorGround.center = CGPointMake(floorVC.view.frame.size.width / 2, (self.floors.count - 1) * self.view.scrollFloorsView.frame.size.height + (self.view.scrollFloorsView.frame.size.height / 2) + 2);
    }
    
    [self.view.scrollFloorsView setNeedsDisplay];
    
    // "Readd Floor" & Roof (z-index reset)
    [self.view.scrollFloorsView insertSubview:self.view.addFloorView atIndex:0];
    [self.view.scrollFloorsView insertSubview:self.view.floorRoof atIndex:0];
    
    self.floorIndex++;
    
    // Animate
    if (self.floors.count != 1) {
        [UIView animateWithDuration:2.0 animations:^{
            self.view.floorGround.center = CGPointMake(self.view.floorGround.center.x, self.view.floorGround.center.y + self.view.scrollFloorsView.frame.size.height);
        }];
        
        int index2 = 0;
        for(FloorViewController* floorVC in floors_reversed){
            if (index2 != 0) { // ! first item
                [UIView animateWithDuration:2.0 animations:^{
                    floorVC.view.center = CGPointMake(floorVC.view.center.x, floorVC.view.center.y + self.view.scrollFloorsView.frame.size.height);
                }];
            }
            index2++;
        }
    }
    
    // Update selectedIndex and videoPreview
    [self scrollViewDidEndDecelerating:(UIScrollView *)nil];
}

#pragma mark - btnRecordVideo
- (void)btnRecordVideoDown:(id)sender
{
    [self.videoCaptureManager startVideoRecording];
    
    self.recordSuccess = NO;
    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(recordingSuccess:) userInfo:nil repeats:NO];
    FloorViewController *selectedFloorVC = [self.floors objectAtIndex:self.selectedFloorViewIndex];
    [UIView animateWithDuration:4.0 animations:^{
        selectedFloorVC.view.videoProgressLoader.center = CGPointMake(selectedFloorVC.view.videoProgressLoader.center.x +  selectedFloorVC.view.videoProgressLoader.frame.size.width, selectedFloorVC.view.videoProgressLoader.center.y);
    } completion:^(BOOL finished){}];
}

- (void)btnRecordVideoUp:(id)sender
{
    [self.videoCaptureManager stopVideoRecording];
    [self.recordTimer invalidate];
    self.recordTimer = nil;
    if(!self.recordSuccess){
        FloorViewController *selectedFloorVC = [self.floors objectAtIndex:self.selectedFloorViewIndex];
        [selectedFloorVC.view.videoProgressLoader.layer removeAllAnimations];
        [UIView animateWithDuration:0.4 animations:^{
            selectedFloorVC.view.videoProgressLoader.alpha = 0;
        } completion:^(BOOL finished) {
            selectedFloorVC.view.videoProgressLoader.center = CGPointMake(self.view.frame.size.width /2 -13 - selectedFloorVC.view.videoProgressLoader.frame.size.width, 8);
            selectedFloorVC.view.videoProgressLoader.alpha = 1;
        }];
    }
}

- (void)recordingSuccess:(id)sender
{
    NSLog(@"SUCCES");
    
    self.recordSuccess = YES;
    [self btnRecordVideoUp:nil];
    
    FloorViewController *selectedFloorVC = [self.floors objectAtIndex:self.selectedFloorViewIndex];
    [UIView animateWithDuration:0.4 animations:^{
        selectedFloorVC.view.videoProgressLoader.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            selectedFloorVC.view.videoProgressLoader.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                selectedFloorVC.view.videoProgressLoader.alpha = 0;
            } completion:^(BOOL finished) {
                selectedFloorVC.view.videoProgressLoader.center = CGPointMake(self.view.frame.size.width /2 -13 - selectedFloorVC.view.videoProgressLoader.frame.size.width, 8);
                selectedFloorVC.view.videoProgressLoader.alpha = 1;
            }];
        }];
    }];
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int scrollIndex = self.view.scrollFloorsView.contentOffset.y / self.view.scrollFloorsView.frame.size.height;
    self.selectedFloorViewIndex = ((int)self.floors.count - 1) - scrollIndex;
    FloorViewController *floorVC = [self.floors objectAtIndex:self.selectedFloorViewIndex];
    [floorVC.view.videoPreviewView addSubview:self.view.videoPreviewView];
    
    [self checkBuilding];
}

#pragma mark - Delegates videoCaptureManager
- (void)videoRecordingDidFailWithError:(NSError *)error
{
    NSLog(@"videoRecordingDidFailWithError");
}

- (void)videoRecordingWillBegin
{
    //NSLog(@"videoRecordingWillBegin");
}

- (void)videoRecordingBegan
{
    NSLog(@"videoRecordingBegan");
}

- (void)videoRecordingWillFinish
{
    //NSLog(@"videoRecordingWillFinish");
}

- (void)videoRecordingFinished:(NSURL *)outputFileURL
{
    NSLog(@"videoRecordingFinished: %@", outputFileURL);
    
    if(self.recordSuccess){
        FloorViewController *selectedFloorVC = [self.floors objectAtIndex:self.selectedFloorViewIndex];
        NSURL *videoURL = [self.fileManager copyFileToDirectory:[self.fileManager floorsTmpDirUrl].path fileUrl:outputFileURL newFileName:[NSString stringWithFormat:@"floor_%i.mov", selectedFloorVC.id]];
        selectedFloorVC.videoURL = videoURL;
        [selectedFloorVC.videoPlayer replaceCurrentItemWithURL:selectedFloorVC.videoURL];
    }
    
    [self checkBuilding];
}

#pragma mark - Delegates audioCaptureManager
- (void)audioRecordingDidFailWithError:(NSError *)error
{
    NSLog(@"audioRecordingDidFailWithError: %@", error);
}

- (void)audioRecordingWillBegin
{
    //NSLog(@"audioRecordingWillBegin");
}

- (void)audioRecordingBegan
{
    NSLog(@"audioRecordingBegan");
}

- (void)audioRecordingWillFinish
{
    //NSLog(@"audioRecordingWillFinish");
}

- (void)audioRecordingFinished:(NSURL *)outputFileURL
{
    NSLog(@"audioRecordingFinished: %@", outputFileURL);
    
    FloorViewController *selectedFloorVC = [self.floors objectAtIndex:self.selectedFloorViewIndex];
    NSURL *audioURL = [self.fileManager copyFileToDirectory:[self.fileManager floorsTmpDirUrl].path fileUrl:outputFileURL newFileName:[NSString stringWithFormat:@"floor_%i.m4a", selectedFloorVC.id]];
    selectedFloorVC.audioURL = audioURL;
    selectedFloorVC.audioPlayer = [[AudioPlayer alloc] initWithAudioURL:selectedFloorVC.audioURL];
    
    [self checkBuilding];
}

#pragma mark - Reroute events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view.btnAddFloor];
    if([self.view.btnAddFloor hitTest:point withEvent:event]){
        [self.view.btnAddFloor sendActionsForControlEvents: UIControlEventTouchUpInside];
    }
    
    for(FloorViewController* floorVC in self.floors){
        CGPoint point = [touch locationInView:floorVC.view.btnPlay];
        if([floorVC.view.btnPlay hitTest:point withEvent:event]){
            [floorVC.view.btnPlay sendActionsForControlEvents: UIControlEventTouchUpInside];
        }
    }
}

@end
