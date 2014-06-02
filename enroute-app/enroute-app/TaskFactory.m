//
//  TaskFactory.m
//  enroute-app
//
//  Created by Stijn Heylen on 02/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskFactory.h"

@implementation TaskFactory

+ (Task *)createTaskWithDictionary:(NSDictionary *)dictionary
{
    Task *task = [[Task alloc] init];
    task.title = [dictionary objectForKey:@"title"];
    task.text = [dictionary objectForKey:@"text"];
    
    return task;
}

@end
