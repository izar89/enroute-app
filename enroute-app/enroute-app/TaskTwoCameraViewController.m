//
//  TaskTwoCameraViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskTwoCameraViewController.h"

@interface TaskTwoCameraViewController ()
@property (nonatomic, assign) BOOL captureSuccess;
@property (nonatomic, strong) PhotoCaptureManager *photoCaptureManager;
@property (nonatomic, strong) FileManager *fileManager;
@property (nonatomic, strong) APIManager *apiManager;
@end

@implementation TaskTwoCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.fileManager = [[FileManager alloc] init];
        self.fileManager.delegate = self;
        
        [self.fileManager removeFileOrDirectory:[self.fileManager floorsTmpDirUrl]];
        [self.fileManager createDirectoryAtDirectory:[self.fileManager tempDirectoryPath] withName:[self.fileManager floorsTmpDirUrl].lastPathComponent];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photoCaptureManager = [[PhotoCaptureManager alloc] initWithPreviewView:self.view.photoPreviewView];
    self.photoCaptureManager.delegate = self;
    
    [self.view.btnPhoto addTarget:self action:@selector(btnPhotoTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnDelete addTarget:self action:@selector(btnDeleteTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnSave addTarget:self action:@selector(btnSaveTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[TaskTwoCameraView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
}

#pragma mark - btnPhoto
- (void)btnPhotoTapped:(id)sender
{
    NSLog(@"photo");
    [self.photoCaptureManager capturePhoto];
}

- (void)photoCaptureFinished:(NSURL *)outputFileURL{
    UIImage *photo = [[UIImage alloc] initWithContentsOfFile:outputFileURL.path];
    UIImageView *photoPreviewView = [[UIImageView alloc] initWithImage:photo];
    [self.view.photoPreviewView addSubview:photoPreviewView];
}

#pragma mark - btnDelete
- (void)btnDeleteTapped:(id)sender
{
    NSLog(@"delete");
}

#pragma mark - btnSave
- (void)btnSaveTapped:(id)sender
{
    NSLog(@"save");
    //    self.apiManager = [[APIManager alloc] init];
    //    [self.apiManager test:nil];
}

@end
