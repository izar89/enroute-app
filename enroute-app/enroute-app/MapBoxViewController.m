//
//  MapBoxViewController.m
//  enroute-app
//
//  Created by Stijn Heylen on 16/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "MapBoxViewController.h"

@interface MapBoxViewController ()
@property (nonatomic, strong) APIManager *apiManager;
@property (nonatomic, strong) NSArray *taskTwoPhotos;
@property (nonatomic, strong) TaskTwoPhoto *nTaskTwoPhoto;
@property (nonatomic, strong) UIView *nTaskTwoPhotoView;
@property (nonatomic, strong) FileManager *fileManager;
@end

@implementation MapBoxViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.fileManager = [[FileManager alloc] init];
        self.fileManager.delegate = self;
        
        self.apiManager = [[APIManager alloc] init];
        self.apiManager.delegate = self;
        [self.apiManager getBiggieSmallsOfToday];
    }
    return self;
}

- (id)initWithNewTaskTwoPhoto:(TaskTwoPhoto *)newTaskTwoPhoto
{
    self.nTaskTwoPhoto = newTaskTwoPhoto;
    return [self initWithNibName:nil bundle:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view.btnBack addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.btnClose addTarget:self action:@selector(btnCloseTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.view = [[MapBoxView alloc] initWithFrame:bounds];
    
    
    self.view.mapView.delegate = self;
    if(self.nTaskTwoPhoto){
        [self.nTaskTwoPhotoView removeFromSuperview];
        UIImage *nTaskTwoPhoto = [UIImage imageWithContentsOfFile:self.nTaskTwoPhoto.imageUrl.path];
        self.nTaskTwoPhotoView = [[UIImageView alloc] initWithImage:nTaskTwoPhoto];
        self.nTaskTwoPhotoView.frame = CGRectMake(0, 0, 240, 320);
        [self.view.photoView addSubview:self.nTaskTwoPhotoView];
        [self showPhotoAnnotation:YES animated:NO];
        self.view.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.nTaskTwoPhoto.latitude, self.nTaskTwoPhoto.longitude);
    } else {
        [self showPhotoAnnotation:NO animated:NO];
    }
}

- (void)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnCloseTapped:(id)sender
{
    NSLog(@"close");
    
    [self showPhotoAnnotation:NO animated:YES];
}


#pragma mark - Delegates APIManager
-(void)getBiggieSmallsOfTodayResponse:(NSDictionary *)responseObject
{
    self.taskTwoPhotos = [TaskTwoPhotosFactory createTaskTwoPhotosWithDictionary:responseObject];
    
    RMAnnotation *annotation;
    for(TaskTwoPhoto *taskTwoPhoto in self.taskTwoPhotos){
        NSLog(@"----- %@", taskTwoPhoto.imageUrl);
        
        annotation = [[RMAnnotation alloc] initWithMapView:self.view.mapView
                                                coordinate:CLLocationCoordinate2DMake(taskTwoPhoto.latitude, taskTwoPhoto.longitude)
                                                                 andTitle:@"Test"];
        
        //annotation1.userInfo = @"small";
        
        [self.view.mapView addAnnotation:annotation];
        annotation = nil;
    }
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    RMMarker *marker;
    marker = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"btnPhotoAnnotation"]];
    marker.canShowCallout = YES;
    return marker;
}

- (void)showPhotoAnnotation:(BOOL)show animated:(BOOL)animated{
    if(show){
        self.view.photoAnnotationView.alpha = 1;
        if(animated){
            [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.view.photoAnnotationView.center = CGPointMake(self.view.frame.size.width / 2, self.view.photoAnnotationView.center.y);
            } completion:^(BOOL finished) {
            }];
        } else {
            self.view.photoAnnotationView.center = CGPointMake(self.view.frame.size.width / 2, self.view.photoAnnotationView.center.y);
        }
    } else {
        if(animated){
            [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.view.photoAnnotationView.center = CGPointMake(self.view.frame.size.width + self.view.frame.size.width /2, self.view.photoAnnotationView.center.y);
            } completion:^(BOOL finished) {
                self.view.photoAnnotationView.center = CGPointMake(-self.view.frame.size.width / 2, self.view.photoAnnotationView.center.y);
                self.view.photoAnnotationView.alpha = 0;
            }];
        } else {
            self.view.photoAnnotationView.center = CGPointMake(-self.view.frame.size.width / 2, self.view.photoAnnotationView.center.y);
            self.view.photoAnnotationView.alpha = 0;
        }
    }
}


@end
