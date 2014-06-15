//
//  TaskInfosFactory.h
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskInfo.h"

@interface TaskInfosFactory : NSObject
+ (NSArray *)createTaskInfosWithDictionary:(NSDictionary *)dictionary;
+ (TaskInfo *)createTaskInfoWithDictionary:(NSDictionary *)dictionary;
@end
