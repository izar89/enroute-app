//
//  AudioPlayer.h
//  enroute-app
//
//  Created by Stijn Heylen on 12/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : NSObject

- (id)initWithAudioURL:(NSURL *)audioURL;
- (void)startPlaying;
- (void)stopPlaying;

@end
