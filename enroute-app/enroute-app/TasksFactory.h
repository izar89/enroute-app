//
//  TasksFactory.h
//  enroute-app
//
//  Created by Stijn Heylen on 02/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TasksFactory : NSObject
+ (NSArray *)createTasksWithDictionary:(NSDictionary *)dictionary;
+ (Task *)createTaskWithDictionary:(NSDictionary *)dictionary;
@end
