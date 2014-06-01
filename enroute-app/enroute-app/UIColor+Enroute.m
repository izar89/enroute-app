//
//  UIColor+Enroute.m
//  enroute-app
//
//  Created by Stijn Heylen on 31/05/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "UIColor+Enroute.h"

@implementation UIColor (Enroute)

+ (UIColor *)enrouteBlueColor {
    return [self rgba2UIColorWithR:122 G:207 B:178 A:1];
}

+ (UIColor *)enrouteRedColor {
    return [self rgba2UIColorWithR:178 G:70 B:63 A:1];
}

+ (UIColor*)rgba2UIColorWithR:(int)r G:(int)g B:(int)b A:(float)alpha{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

@end
