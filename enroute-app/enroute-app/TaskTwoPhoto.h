//
//  TaskTwoPhoto.h
//  enroute-app
//
//  Created by Stijn Heylen on 15/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TaskTwoPhoto : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

@end
