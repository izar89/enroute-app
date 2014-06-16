//
//  PhotoAnnotation.h
//  enroute-app
//
//  Created by Stijn Heylen on 16/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapbox.h>
#import "TaskTwoPhoto.h"

@interface PhotoAnnotation : NSObject

- (id)initWithTaskTwoPhoto:(TaskTwoPhoto *)taskTwoPhoto;

@end
