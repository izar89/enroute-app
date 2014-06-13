//
//  VideoPlayer2.m
//  enroute-app
//
//  Created by Stijn Heylen on 12/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "VideoPlayerView.h"

@interface VideoPlayerView()
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) AVPlayer *videoPlayer;
@property (nonatomic, strong) CALayer *videoPlayerLayer;
@end

@implementation VideoPlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.videoPlayer = [[AVPlayer alloc] initWithURL:self.videoURL];
        self.videoPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        
        //Repeat
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[self.videoPlayer currentItem]];
        
        
        self.videoPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.videoPlayer];
        self.videoPlayerLayer.frame = self.layer.bounds;
        [self.layer addSublayer:self.videoPlayerLayer];
    }
    return self;
}

- (void)startPlaying
{
    [self.videoPlayer play];
}

- (void)stopPlaying
{
    NSLog(@"stop");
    [self.videoPlayer pause]; // no stop available
    [self.videoPlayer seekToTime:kCMTimeZero];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)replaceCurrentItemWithURL:videoURL
{
    [self stopPlaying];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:videoURL];
    [self.videoPlayer replaceCurrentItemWithPlayerItem:playerItem];
}

@end
