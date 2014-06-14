//
//  JSONDataManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 02/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "JSONDataManager.h"

@implementation JSONDataManager

+ (JSONDataManager *)sharedInstance
{
    static JSONDataManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[JSONDataManager alloc] init];
    });
    return _sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"enroute" ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        NSError *error = nil;
        NSArray *loadedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if( !error ){;
            NSDictionary *enroute = [[loadedData objectAtIndex:0] objectForKey:@"enroute"];
            self.tasks = [TasksFactory createTasksWithDictionary:[enroute objectForKey:@"tasks"]];
            self.taskOneInfos = [TaskInfosFactory createTaskInfosWithDictionary:[enroute objectForKey:@"taskOneInfos"]];
            self.taskTwoInfos = [TaskInfosFactory createTaskInfosWithDictionary:[enroute objectForKey:@"taskTwoInfos"]];
        }else {
            NSLog(@"[JSONDataManager] Problem loading JSON!");
        }
    }
    return self;
}

@end
