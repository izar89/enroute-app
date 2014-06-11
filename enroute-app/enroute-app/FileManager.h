//
//  FileManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 11/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VIDEO_FILE @"capture.mov"
#define AUDIO_FILE @"capture.m4a"

@protocol FileManagerDelegate;

@interface FileManager : NSObject

@property (weak, nonatomic) id <FileManagerDelegate> delegate;
- (NSURL *)videoTmpURL;
- (NSURL *)audioTmpURL;
- (NSURL *)copyFileToDocuments:(NSURL *)fileURL fileName:(NSString *)fileName;

@end

@protocol FileManagerDelegate <NSObject>
@optional
- (void) fileManagerDidFailWithError:(NSError *)error;
@end