//
//  APIManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 12/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "APIManager.h"

@interface APIManager()
@property (nonatomic, strong) FileManager *fileManager;
@end

@implementation APIManager

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.fileManager = [[FileManager alloc] init];
    }
    return self;
}

- (void)test:(NSArray *)floors{
    NSString *urlString = @"http://student.howest.be/jasper.van.damme/20132014/MAIV/ENROUTE/api/buildings";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSError *error;
        NSData *test = [[NSData alloc] initWithContentsOfURL:[self.fileManager videoTmpURL]];
        [formData appendPartWithFileData:test name:@"video[]" fileName:@"capture.mov" mimeType:@"video/quicktime"];
        if(error){
            NSLog(@"error");
        }

        NSData *test3 = [[NSData alloc] initWithContentsOfURL:[self.fileManager videoTmpURL]];
        [formData appendPartWithFileData:test3 name:@"video[]" fileName:@"capture.mov" mimeType:@"video/quicktime"];
        if(error){
            NSLog(@"error");
        }
        
        NSData *test2 = [[NSData alloc] initWithContentsOfURL:[self.fileManager audioTmpURL]];
        [formData appendPartWithFileData:test2 name:@"audio[]" fileName:@"capture.m4a" mimeType:@"audio/m4a"];
        if(error){
            NSLog(@"error");
        }
        
        NSData *test4 = [[NSData alloc] initWithContentsOfURL:[self.fileManager audioTmpURL]];
        [formData appendPartWithFileData:test4 name:@"audio[]" fileName:@"capture.m4a" mimeType:@"audio/m4a"];
        if(error){
            NSLog(@"error");
        }
      
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
