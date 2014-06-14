//
//  TaskInfoFactory.m
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskInfoFactory.h"

@implementation TaskInfoFactory

+ (TaskInfo *)createTaskInfoWithDictionary:(NSDictionary *)dictionary
{
    TaskInfo *taskInfo = [[TaskInfo alloc] init];

    taskInfo.text = [dictionary objectForKey:@"text"];
    taskInfo.imageName = [dictionary objectForKey:@"imageName"];

    return taskInfo;
}

@end
