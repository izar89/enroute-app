//
//  TaskTwoPhotosFactory.h
//  enroute-app
//
//  Created by Stijn Heylen on 15/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskTwoPhoto.h"

@interface TaskTwoPhotosFactory : NSObject
+ (NSArray *)createTaskTwoPhotosWithDictionary:(NSDictionary *)dictionary;
+ (TaskTwoPhoto *)createTaskTwoPhotoWithDictionary:(NSDictionary *)dictionary;
@end
