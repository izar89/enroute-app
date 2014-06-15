//
//  JSONDataManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 02/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TasksFactory.h"
#import "TaskInfosFactory.h"

@interface JSONDataManager : NSObject

+ (JSONDataManager *)sharedInstance;

@property (nonatomic,strong) NSArray *tasks;
@property (nonatomic,strong) NSArray *taskOneInfos;
@property (nonatomic,strong) NSArray *taskTwoInfos;

@end
