//
//  TaskTwoPhotosFactory.m
//  enroute-app
//
//  Created by Stijn Heylen on 15/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskTwoPhotosFactory.h"

@implementation TaskTwoPhotosFactory

+ (NSArray *)createTaskTwoPhotosWithDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *taskTwoPhotos = [NSMutableArray array];
    for(NSDictionary *taskTwoPhoto in dictionary){
        [taskTwoPhotos addObject:[self createTaskTwoPhotoWithDictionary:taskTwoPhoto]];
    }
    return taskTwoPhotos;
}

+ (TaskTwoPhoto *)createTaskTwoPhotoWithDictionary:(NSDictionary *)dictionary
{
    TaskTwoPhoto *taskTwoPhoto = [[TaskTwoPhoto alloc] init];
    taskTwoPhoto.imageUrlPath = [dictionary objectForKey:@"url"];
    taskTwoPhoto.latitude = [[dictionary objectForKey:@"latitude"] doubleValue];
    taskTwoPhoto.longitude = [[dictionary objectForKey:@"longitude"] doubleValue];
    return taskTwoPhoto;
}

@end
