//
//  MapViewController.m
//  Bento++
//
//  Created by yishain on 8/22/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//



#import "LoginViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <AFNetworking/AFNetworking.h>
#import "MapViewController.h"

@interface MapViewController ()  <GMSMapViewDelegate,CLLocationManagerDelegate, UITextFieldDelegate>
{
    NSDictionary *dict;
    BOOL isFirstTime;
    GMSMapView *mapView;
    CLLocationManager *locationManager;
}



@property UIColor *colorGreen;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdata];
    isFirstTime = YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    GMSCameraPosition *currentMap = [GMSCameraPosition cameraWithLatitude:mapView.myLocation.coordinate.latitude longitude:mapView.myLocation.coordinate.longitude zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:currentMap];
    mapView.frame = CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 94);
    mapView.myLocationEnabled = YES;
    
    //marker
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = currentMap.target;
    marker.snippet = @"Hello World";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    [self.view addSubview:mapView];
    [self marker];
    
    //button
    
    _colorGreen = [UIColor colorWithRed:0.5f green:0.810561f blue:0.491887f alpha:1.0f];
    _btnConfirm.enabled = NO;
    _btnConfirm.backgroundColor = [UIColor blackColor];
    _btnConfirm.alpha = 0.5f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self apiPostToGetRestaurantMarkers];
}
- (void)viewWillAppear:(BOOL)animated {
    //    [self.view addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
    [mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)dealloc {
    [mapView removeObserver:self forKeyPath:@"myLocation" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]])
    {
        if (isFirstTime == YES) {
            
            CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
            CLLocation *normalLocation = [[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
            [mapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:normalLocation.coordinate zoom:17]];
            
            NSLog(@"%f", normalLocation.coordinate.latitude);
            NSLog(@"%f", normalLocation.coordinate.longitude);
            isFirstTime = NO;
        }
    }
    
}
- (void)marker {
    //set a marker on map
    
    GMSMarker *garbageLocation = [[GMSMarker alloc] init];
    garbageLocation.position = CLLocationCoordinate2DMake(mapView.myLocation.coordinate.latitude, mapView.myLocation.coordinate.longitude);
    garbageLocation.title = @"Here";
    garbageLocation.appearAnimation = kGMSMarkerAnimationPop;
    garbageLocation.map = mapView;
    
}



-(void)getdata {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://192.168.21.194:3000/api/v1/restaurants"
      parameters:@{}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"success");
             NSLog(@"response: %@", responseObject);
             dict = responseObject;
             NSString *eric;
             eric = dict[@"data"][0][@"latitude"];
             NSLog(@"latitude = %@",eric);
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"failure: %@", error);
         }];
}

- (IBAction)backBtn:(id)sender {
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Cell"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end