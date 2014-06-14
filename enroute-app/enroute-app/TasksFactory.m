//
//  TasksFactory.m
//  enroute-app
//
//  Created by Stijn Heylen on 02/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TasksFactory.h"

@implementation TasksFactory

+ (Tasks *)createTasksWithDictionary:(NSDictionary *)dictionary
{
    Tasks *tasks = [[Tasks alloc] init];
    tasks.tasks = [NSMutableArray array];
    for(NSDictionary *task in dictionary){
        [tasks.tasks addObject:[TaskFactory createTaskWithDictionary:task]];
    }
    
    return tasks;
}

@end
