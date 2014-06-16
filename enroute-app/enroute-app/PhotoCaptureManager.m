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
    self.captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    
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

- (void)startCaptureSession
{
    if(!self.captureSession.running && self.captureSession){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.captureSession startRunning];
        });
    }
}

- (void)stopCaptureSession
{
    if(self.captureSession.running && self.captureSession){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.captureSession stopRunning];
        });
    }
}

#pragma mark - Capture Photo
- (void)capturePhoto{
    
    if ([self.delegate respondsToSelector:@selector(photoCaptureBegan)]) {
        [self.delegate photoCaptureBegan];
    }
    
    if( self.captureSession ){
        
        [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:self.videoConnection completionHandler:
         ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
             
             CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
             
             if(error){
                 if ([self.delegate respondsToSelector:@selector(photoCaptureDidFailWithError:)]) {
                     [self.delegate photoCaptureDidFailWithError:error];
                 }
             }
             
             if (exifAttachments) {
                 // Get attachments
                 NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
                 UIImage *image = [[UIImage alloc] initWithData:imageData];
                 NSLog(@"1) width: %f, height: %f", image.size.width, image.size.height);
                 
                 // Save to temp
                 [UIImageJPEGRepresentation(image, 1.0) writeToFile:[self.fileManager photoTmpURL].path atomically:YES];
                 if ([self.delegate respondsToSelector:@selector(photoCaptureFinished:)]) {
                     [self.delegate photoCaptureFinished:[self.fileManager photoTmpURL]];
                 }
             }else{
                 NSLog(@"[PhotoCaptureManager] -  no attachements");
             }
         }];
    }else{
        NSLog(@"[PhotoCaptureManager] - video connection NOT found");
    }
}

@end
