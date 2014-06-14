//
//  TaskInfosFactory.m
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskInfosFactory.h"

@implementation TaskInfosFactory

+ (TaskInfos *)createTaskInfosWithDictionary:(NSDictionary *)dictionary
{
    TaskInfos *taskInfos = [[TaskInfos alloc] init];
    taskInfos.taskInfos = [NSMutableArray array];
    for(NSDictionary *taskInfo in dictionary){
        [taskInfos.taskInfos addObject:[TaskInfoFactory createTaskInfoWithDictionary:taskInfo]];
    }
    
    return taskInfos;
}

@end
