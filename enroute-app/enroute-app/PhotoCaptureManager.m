//
//  PhotoCaptureManager.m
//  enroute-app
//
//  Created by Stijn Heylen on 15/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "PhotoCaptureManager.h"

@interface PhotoCaptureManager()
@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) FileManager *fileManager;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;

@end

@implementation PhotoCaptureManager

- (id)init
{
    self = [super init];
    if (self != nil) {
        [self setUpCaptureSession];
        self.fileManager = [[FileManager alloc] init];
        self.fileManager.delegate = self;
    }
    return self;
}

- (id)initWithPreviewView:(UIView *)previewView
{
    self.previewView = previewView;
    return [self init];
}

#pragma mark - Configure Capture Session
- (void)setUpCaptureSession
{
    // Set up Session
    self.captureSession = [[AVCaptureSession alloc] init];
    
    // Set up connection
    NSError *error;
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if ([self.captureSession canAddInput:videoInput]) {
        [self.captureSession addInput:videoInput];
    }

    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    [self.captureSession addOutput:self.stillImageOutput];
    if ([self.captureSession canAddOutput:self.stillImageOutput]) {
        [self.captureSession addOutput:self.stillImageOutput];
    }
    self.videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    self.videoConnection.videoOrientation = UIDeviceOrientationPortrait; // only portrait
    
    // Start session
    [self.captureSession startRunning];
    
    // Set up preview layer
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.previewLayer.frame = self.previewView.bounds;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [[self.previewLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
        [self.previewView.layer addSublayer:self.previewLayer];
    });
}

- (void)capturePhoto:(CLLocation *)latestLocation{
    
    if ([self.delegate respondsToSelector:@selector(photoCaptureBegan)]) {
        [self.delegate photoCaptureBegan];
    }
    
    if( self.captureSession ){
        
        [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:self.videoConnection completionHandler:
         ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
             
             //CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
             
//             if(error){
//                 if ([self.delegate respondsToSelector:@selector(photoCaptureDidFailWithError:)]) {
//                     [self.delegate photoCaptureDidFailWithError:error];
//                 }
//             }
//             
//             if (exifAttachments) {
//                 // get attachments
//                 NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
//                 UIImage *image = [[UIImage alloc] initWithData:imageData];
//                 [self savePhotoToTmp:image];
//             }else{
//                 NSLog(@"[PhotoCaptureManager] -  no attachements");
//             }
             
//             CFDictionaryRef dictRef = CMCopyDictionaryOfAttachments(NULL, imageSampleBuffer, kCMAttachmentMode_ShouldPropagate);
//             NSMutableDictionary *metadataDict =  [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)dictRef];
             
         }];
    }else{
        NSLog(@"[PhotoCaptureManager] - video connection NOT found");
    }
}

- (void)setLocation:(CLLocation *)location metadataDict:(NSMutableDictionary *)metadataDict{
    
    if (location) {
        
        CLLocationDegrees exifLatitude  = location.coordinate.latitude;
        CLLocationDegrees exifLongitude = location.coordinate.longitude;
        
        NSString *latRef;
        NSString *lngRef;
        if (exifLatitude < 0.0) {
            exifLatitude = exifLatitude * -1.0f;
            latRef = @"S";
        } else {
            latRef = @"N";
        }
        
        if (exifLongitude < 0.0) {
            exifLongitude = exifLongitude * -1.0f;
            lngRef = @"W";
        } else {
            lngRef = @"E";
        }
        
        NSMutableDictionary *locDict = [[NSMutableDictionary alloc] init];
        if ([metadataDict objectForKey:(NSString*)kCGImagePropertyGPSDictionary]) {
            [locDict addEntriesFromDictionary:[metadataDict objectForKey:(NSString*)kCGImagePropertyGPSDictionary]];
        }
        [locDict setObject:[self getUTCFormattedDate:location.timestamp] forKey:(NSString*)kCGImagePropertyGPSTimeStamp];
        [locDict setObject:latRef forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
        [locDict setObject:[NSNumber numberWithFloat:exifLatitude] forKey:(NSString*)kCGImagePropertyGPSLatitude];
        [locDict setObject:lngRef forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
        [locDict setObject:[NSNumber numberWithFloat:exifLongitude] forKey:(NSString*)kCGImagePropertyGPSLongitude];
        [locDict setObject:[NSNumber numberWithFloat:location.horizontalAccuracy] forKey:(NSString*)kCGImagePropertyGPSDOP];
        [locDict setObject:[NSNumber numberWithFloat:location.altitude] forKey:(NSString*)kCGImagePropertyGPSAltitude];
        
        [metadataDict setObject:locDict forKey:(NSString*)kCGImagePropertyGPSDictionary];
    }
}

- (NSString *)getUTCFormattedDate:(NSDate *)localDate {
    
    static NSDateFormatter *dateFormatter;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
    }
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}


- (void)savePhotoToTmp:(UIImage *)image
{
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:[self.fileManager photoTmpURL].path atomically:YES];
    
    if ([self.delegate respondsToSelector:@selector(photoCaptureFinished:)]) {
        [self.delegate photoCaptureFinished:[self.fileManager photoTmpURL]];
    }
}

@end
