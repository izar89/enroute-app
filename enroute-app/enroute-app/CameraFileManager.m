//
//  AVCamFileManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 01/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "CameraFileManager.h"

@implementation CameraFileManager

#pragma mark - Files
- (NSURL *)tempFileURL
{
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), @"output.mov"]];
}

- (void)removeFile:(NSURL *)fileURL
{
    NSString *filePath = fileURL.path;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSError *error;
        if (![fileManager removeItemAtPath:filePath error:&error]) {
            // ERROR
            if ([self.delegate respondsToSelector:@selector(fileManager:didFailWithError:)]) {
                [self.delegate fileManager:self didFailWithError:error];
            }
        }
    }
}

- (void)copyFileToDocuments:(NSURL *)fileURL
{
	NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss"];
	NSString *destinationPath = [documentsDirectory stringByAppendingFormat:@"/output_%@.mov", [dateFormatter stringFromDate:[NSDate date]]];
	NSError	*error;
	if (![[NSFileManager defaultManager] copyItemAtURL:fileURL toURL:[NSURL fileURLWithPath:destinationPath] error:&error]) {
		// ERROR
        if ([self.delegate respondsToSelector:@selector(fileManager:didFailWithError:)]) {
			[self.delegate fileManager:self didFailWithError:error];
		}
	}
}

#pragma mark - Library
- (void)saveFileToLibrary:(NSURL *)fileURL
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:fileURL completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            //ERROR
            if ([self.delegate respondsToSelector:@selector(fileManager:didFailWithError:)]) {
                [self.delegate fileManager:self didFailWithError:error];
            }
        }
        if ([self.delegate respondsToSelector:@selector(fileManagerSaveFileToLibraryFinished:)]) {
            [self.delegate fileManagerSaveFileToLibraryFinished:self];
        }
    }];
}

@end
