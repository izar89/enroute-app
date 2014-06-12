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
#define FLOORS_DIR @"floors"

@protocol FileManagerDelegate;

@interface FileManager : NSObject

@property (weak, nonatomic) id <FileManagerDelegate> delegate;
- (NSString *)documentsDirectoryPath;
- (NSString *)tempDirectoryPath;
- (NSURL *)videoTmpURL;
- (NSURL *)audioTmpURL;
- (NSURL *)floorsTmpDirUrl;
- (void)removeFileOrDirectory:(NSURL *)fileURL;
- (NSURL *)copyFileToDirectory:(NSString *)directoryPath fileUrl:(NSURL *)fileURL newFileName:(NSString *)fileName;
- (NSURL *)createDirectoryAtDirectory:(NSString *)directoryPath withName:(NSString *)directoryName;

@end

@protocol FileManagerDelegate <NSObject>
@optional
- (void) fileManagerDidFailWithError:(NSError *)error;
@end