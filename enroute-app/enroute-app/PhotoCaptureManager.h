//
//  PhotoCaptureManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 15/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import "FileManager.h"

@protocol PhotoCaptureManagerDelegate;

@interface PhotoCaptureManager : NSObject <FileManagerDelegate>
@property (weak, nonatomic) id<PhotoCaptureManagerDelegate> delegate;
- (id)initWithPreviewView:(UIView *)previewView;
- (void)capturePhoto;
- (void)startCaptureSession;
- (void)stopCaptureSession;
@end

@protocol PhotoCaptureManagerDelegate <NSObject>
@optional
- (void)photoCaptureDidFailWithError:(NSError *)error;
- (void)photoCaptureBegan;
- (void)photoCaptureFinished:(NSURL *)outputFileURL;
@end
