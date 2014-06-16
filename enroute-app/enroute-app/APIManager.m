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

- (void)postBuildings:(NSArray *)floors
{
    NSLog(@"[APIManager] postBuildings");
    
    NSString *urlString = @"http://student.howest.be/jasper.van.damme/20132014/MAIV/ENROUTE/api/buildings";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSError *error;
        NSData *video = [[NSData alloc] initWithContentsOfURL:[self.fileManager videoTmpURL]];
        [formData appendPartWithFileData:video name:@"video[]" fileName:@"capture.mov" mimeType:@"video/quicktime"];
        if(error){
            NSLog(@"error: %@", error);
        }
        NSData *audio = [[NSData alloc] initWithContentsOfURL:[self.fileManager audioTmpURL]];
        [formData appendPartWithFileData:audio name:@"audio[]" fileName:@"capture.m4a" mimeType:@"audio/m4a"];
        if(error){
            NSLog(@"error: %@", error);
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"[APIManager] Response: %@", responseObject);
//        if ([self.delegate respondsToSelector:@selector(APIManagerResponse:)]) {
//            [self.delegate APIManagerResponse:responseObject];
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[APIManager] Error: %@", error);
//        if ([self.delegate respondsToSelector:@selector(APIManagerError:)]) {
//            [self.delegate APIManagerError:error];
//        }
    }];
}

- (void)postBiggieSmalls:(TaskTwoPhoto *)taskTwoPhoto
{
    NSLog(@"[APIManager] postBiggieSmalls");
    
    NSString *urlString = @"http://student.howest.be/jasper.van.damme/20132014/MAIV/ENROUTE/api/biggiesmalls";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *path = [[NSData alloc] initWithContentsOfURL:taskTwoPhoto.imageUrl];
        [formData appendPartWithFileData:path name:@"photo[]" fileName:taskTwoPhoto.imageName mimeType:@"image/jpeg"];
        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%f", taskTwoPhoto.longitude] dataUsingEncoding:NSUTF8StringEncoding] name:@"longitude"];
        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%f", taskTwoPhoto.latitude] dataUsingEncoding:NSUTF8StringEncoding] name:@"latitude"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"[APIManager] Response: %@", responseObject);
        if ([self.delegate respondsToSelector:@selector(postBiggieSmallsResponse:)]) {
            [self.delegate postBiggieSmallsResponse:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[APIManager] Error: %@", error);
//        if ([self.delegate respondsToSelector:@selector(APIManagerError:)]) {
//            [self.delegate APIManagerError:error];
//        }
    }];
}

- (void)getBiggieSmallsOfToday
{
    NSLog(@"[APIManager] getBiggieSmallsOfToday");
    
    NSString *urlString = @"http://student.howest.be/jasper.van.damme/20132014/MAIV/ENROUTE/api/biggiesmalls/day";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"[APIManager] Response: %@", responseObject);
        if ([self.delegate respondsToSelector:@selector(getBiggieSmallsOfTodayResponse:)]) {
            [self.delegate getBiggieSmallsOfTodayResponse:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[APIManager] Error: %@", error);
        if ([self.delegate respondsToSelector:@selector(APIManagerError:)]) {
            [self.delegate APIManagerError:error];
        }
    }];
}

@end
