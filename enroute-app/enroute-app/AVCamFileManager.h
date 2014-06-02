//
//  AVCamFileManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 01/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol AVCamFileManagerDelegate;

@interface AVCamFileManager : NSObject

@property (weak, nonatomic) id <AVCamFileManagerDelegate> delegate;

- (NSURL *)tempFileURL;
- (void)removeFile:(NSURL *)fileURL;
- (void)saveFileToLibrary:(NSURL *)fileURL;

@end

@protocol AVCamFileManagerDelegate <NSObject>
@optional
- (void) fileManager:(AVCamFileManager *)fileManager didFailWithError:(NSError *)error;
- (void) fileManagerSaveFileToLibraryFinished:(AVCamFileManager *)fileManager;
@end