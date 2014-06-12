//
//  VideoPlayer2.h
//  enroute-app
//
//  Created by Stijn Heylen on 12/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayer : UIView

- (id)initWithFrame:(CGRect)frame andVideoURL:(NSURL *)videoURL;
- (void)startPlaying;
- (void)stopPlaying;

@end
