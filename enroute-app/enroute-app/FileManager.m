//
//  FileManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 11/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

#pragma mark - Destination URL
- (NSURL *)videoTmpURL
{
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *filePath = [tmpDirectory stringByAppendingPathComponent:VIDEO_FILE];
	return [NSURL fileURLWithPath:filePath];
}

- (NSURL *)audioTmpURL
{
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *filePath = [tmpDirectory stringByAppendingPathComponent:AUDIO_FILE];
	return [NSURL fileURLWithPath:filePath];
}

#pragma mark - File management
- (void)removeFile:(NSURL *)fileURL
{
    NSError *error;
    if (![[NSFileManager defaultManager] removeItemAtURL:fileURL error:&error]) {
        if ([self.delegate respondsToSelector:@selector(fileManagerDidFailWithError:)]) {
            [self.delegate fileManagerDidFailWithError:error];
        }
    }
    
}

- (NSURL *)copyFileToDocuments:(NSURL *)fileURL fileName:(NSString *)fileName
{
	NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *destinationPath = [documentsDirectory stringByAppendingFormat:@"/%@", fileName];
	NSError	*error;
	if (![[NSFileManager defaultManager] copyItemAtURL:fileURL toURL:[NSURL fileURLWithPath:destinationPath] error:&error]) {
        if ([self.delegate respondsToSelector:@selector(fileManagerDidFailWithError:)]) {
            [self.delegate fileManagerDidFailWithError:error];
        }
	}
    return [NSURL fileURLWithPath:destinationPath];
}

@end
