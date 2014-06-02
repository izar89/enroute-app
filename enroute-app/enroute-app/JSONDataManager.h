//
//  JSONDataManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 02/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tasks.h"
#import "TasksFactory.h"

@interface JSONDataManager : NSObject

+ (JSONDataManager *)sharedInstance;

@property (nonatomic,strong) Tasks *tasks;

@end
