//
//  TasksFactory.m
//  enroute-app
//
//  Created by Stijn Heylen on 02/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TasksFactory.h"

@implementation TasksFactory

+ (NSArray *)createTasksWithDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *tasks = [NSMutableArray array];
    for(NSDictionary *task in dictionary){
        [tasks addObject:[self createTaskWithDictionary:task]];
    }
    return tasks;
}

+ (Task *)createTaskWithDictionary:(NSDictionary *)dictionary
{
    Task *task = [[Task alloc] init];
    task.title = [dictionary objectForKey:@"title"];
    task.text = [dictionary objectForKey:@"text"];
    return task;
}

@end
