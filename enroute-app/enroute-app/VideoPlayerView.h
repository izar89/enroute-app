//
//  VideoPlayer2.h
//  enroute-app
//
//  Created by Stijn Heylen on 12/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayerView : UIView

- (void)startPlaying;
- (void)stopPlaying;
- (void)replaceCurrentItemWithURL:videoURL;

@end
