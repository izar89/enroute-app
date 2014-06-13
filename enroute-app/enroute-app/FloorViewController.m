//
//  FloorViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 13/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "FloorViewController.h"

@interface FloorViewController ()

@end

@implementation FloorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithDefinedDimensionsAndId:(int)id
{
    self.id = id;
    return [self initWithNibName:nil bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load videoPlayer
    self.videoPlayer = [[VideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, VIDEO_WIDTH + 2, VIDEO_HEIGHT + 2)];
    [self.view.videoPlayerView addSubview:self.videoPlayer];
    
    [self.view.btnPlay addTarget:self action:@selector(btnPlayTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    self.view = [[FloorView alloc] initWithFrame:CGRectMake(0, 0, VIDEO_WIDTH, VIDEO_HEIGHT)];
}

#pragma mark - btnPlay
- (void)btnPlayTapped:(id)sender
{
    NSLog(@"btnPlayTapped");
    
    if(self.audioPlayer){
        [self.audioPlayer startPlaying];
    }
    if(self.videoPlayer){
        [self.videoPlayer startPlaying];
    }
}

@end
