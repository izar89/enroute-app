//
//  FileManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 11/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

- (NSString *)documentsDirectoryPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (NSString *)tempDirectoryPath
{
    return NSTemporaryDirectory();
}

#pragma mark - Destination URL
- (NSURL *)photoTmpURL
{
    NSString *filePath = [[self tempDirectoryPath] stringByAppendingPathComponent:PHOTO_FILE];
	return [NSURL fileURLWithPath:filePath];
}

- (NSURL *)videoTmpURL
{
    NSString *filePath = [[self tempDirectoryPath] stringByAppendingPathComponent:VIDEO_FILE];
	return [NSURL fileURLWithPath:filePath];
}

- (NSURL *)audioTmpURL
{
    NSString *filePath = [[self tempDirectoryPath] stringByAppendingPathComponent:AUDIO_FILE];
	return [NSURL fileURLWithPath:filePath];
}

- (NSURL *)floorsTmpDirURL
{
    NSString *filePath = [[self tempDirectoryPath] stringByAppendingPathComponent:FLOORS_DIR];
	return [NSURL fileURLWithPath:filePath];
}

- (NSURL *)biggiesmallsTmpDirURL
{
    NSString *filePath = [[self tempDirectoryPath] stringByAppendingPathComponent:BIGGIESMALLS_DIR];
	return [NSURL fileURLWithPath:filePath];
}

- (NSURL *)biggiesmallsDocumentsDirURL
{
    NSString *filePath = [[self documentsDirectoryPath] stringByAppendingPathComponent:BIGGIESMALLS_DIR];
	return [NSURL fileURLWithPath:filePath];
}

#pragma mark - File management
- (void)removeFileOrDirectory:(NSURL *)fileURL
{
    NSError *error;
    if (![[NSFileManager defaultManager] removeItemAtURL:fileURL error:&error]) {
        if ([self.delegate respondsToSelector:@selector(fileManagerDidFailWithError:)]) {
            [self.delegate fileManagerDidFailWithError:error];
        }
    }
}

- (NSURL *)copyFileToDirectory:(NSString *)directoryPath fileUrl:(NSURL *)fileURL newFileName:(NSString *)fileName
{
    NSString *destinationPath = [directoryPath stringByAppendingFormat:@"/%@", fileName];
	NSError	*error;
	if (![[NSFileManager defaultManager] copyItemAtURL:fileURL toURL:[NSURL fileURLWithPath:destinationPath] error:&error]){
        if ([self.delegate respondsToSelector:@selector(fileManagerDidFailWithError:)]) {
            [self.delegate fileManagerDidFailWithError:error];
        }
	}
    return [NSURL fileURLWithPath:destinationPath];
}

#pragma mark - Directory management
- (NSURL *)createDirectoryAtDirectory:(NSString *)directoryPath withName:(NSString *)directoryName
{
    NSString *destinationPath = [directoryPath stringByAppendingFormat:@"/%@", directoryName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]){
        NSError* error;
        if(![[NSFileManager defaultManager] createDirectoryAtPath:destinationPath withIntermediateDirectories:NO attributes:nil error:&error]){
            if ([self.delegate respondsToSelector:@selector(fileManagerDidFailWithError:)]) {
                [self.delegate fileManagerDidFailWithError:error];
            }
        }
        return [NSURL fileURLWithPath:destinationPath];
    }
    return nil;
}

- (BOOL)directoryExists:(NSString *)directoryPath
{
    BOOL isDir;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir];
    if (exists) {
        /* file exists */
        if (isDir) {
            return YES;
        }
    }
    return NO;
}

@end
