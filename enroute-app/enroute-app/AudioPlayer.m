//
//  AudioPlayer.m
//  enroute-app
//
//  Created by Stijn Heylen on 12/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "AudioPlayer.h"

@interface AudioPlayer()
@property (nonatomic, strong) NSURL *audioURL;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) BOOL playing;
@end

@implementation AudioPlayer

- (id)init
{
    self = [super init];
    if (self != nil) {
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioURL error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            [self.audioPlayer prepareToPlay];
        }
    }
    return self;
}

- (id)initWithAudioURL:(NSURL *)audioURL
{
    self.audioURL = audioURL;
    return [self init];
}

- (void)startPlaying
{
    if(self.audioPlayer.playing){
        [self stopPlaying];
    } else {
        [self.audioPlayer play];
    }
}

- (void)stopPlaying
{
    [self.audioPlayer stop];
}

@end
