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

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageUrlPath;
@property (nonatomic, assign) CLLocationDegrees longitude;
@property (nonatomic, assign) CLLocationDegrees latitude;

@end
