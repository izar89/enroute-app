//
//  APIManager.h
//  enroute-app
//
//  Created by Stijn Heylen on 12/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "FileManager.h"
#import "TaskTwoPhoto.h"

@protocol APIManagerDelegate;

@interface APIManager : NSObject
@property (weak, nonatomic) id<APIManagerDelegate> delegate;
- (void)postBuildings:(NSArray *)floors;
- (void)postBiggieSmalls:(TaskTwoPhoto *)taskTwoPhoto;
- (void)getBiggieSmallsOfToday;
@end

@protocol APIManagerDelegate <NSObject>
@optional
- (void)postBiggieSmallsResponse:(NSDictionary *)responseObject;
- (void)getBiggieSmallsOfTodayResponse:(NSDictionary *)responseObject;
- (void)APIManagerError:(NSError *)error;
@optional

@end