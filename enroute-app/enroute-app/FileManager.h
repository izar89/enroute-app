//
//  FileManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 11/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PHOTO_FILE @"capture.jpeg"
#define VIDEO_FILE @"capture.mov"
#define AUDIO_FILE @"capture.m4a"
#define FLOORS_DIR @"floors"
#define BIGGIESMALLS_DIR @"biggiesmalls"

@protocol FileManagerDelegate;

@interface FileManager : NSObject

@property (weak, nonatomic) id <FileManagerDelegate> delegate;
- (NSString *)documentsDirectoryPath;
- (NSString *)tempDirectoryPath;
- (NSURL *)photoTmpURL;
- (NSURL *)videoTmpURL;
- (NSURL *)audioTmpURL;
- (NSURL *)floorsTmpDirURL;
- (NSURL *)biggiesmallsTmpDirURL;
- (NSURL *)biggiesmallsDocumentsDirURL;
- (void)removeFileOrDirectory:(NSURL *)fileURL;
- (NSURL *)copyFileToDirectory:(NSString *)directoryPath fileUrl:(NSURL *)fileURL newFileName:(NSString *)fileName;
- (NSURL *)createDirectoryAtDirectory:(NSString *)directoryPath withName:(NSString *)directoryName;
- (BOOL)directoryExists:(NSString *)directoryPath;

@end

@protocol FileManagerDelegate <NSObject>
@optional
- (void) fileManagerDidFailWithError:(NSError *)error;
@end