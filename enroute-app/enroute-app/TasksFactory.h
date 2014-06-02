//
//  TasksFactory.h
//  enroute-app
//
//  Created by Stijn Heylen on 02/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tasks.h"
#import "TaskFactory.h"

@interface TasksFactory : NSObject

+ (Tasks *)createTasksWithDictionary:(NSDictionary *)dictionary;

@end
