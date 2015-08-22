//
//  MapViewController.m
//  Bento++
//
//  Created by yishain on 8/22/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//



#import "LoginViewController.h"

#import <AFNetworking/AFNetworking.h>
#import "MapViewController.h"
#import "NibChoice.h"

@interface MapViewController ()  <GMSMapViewDelegate,CLLocationManagerDelegate, UITextFieldDelegate>
{
    NSDictionary *dict;
    BOOL isFirstTime;
    GMSMapView *mapView;
    CLLocationManager *locationManager;
}



@property UIColor *colorGreen;
@property NSMutableArray *arrChoice;
@end

@implementation MapViewController

- (void)viewDidLoad {
    
    
    
    
    
    
    
    
    
    
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self getdata];
    isFirstTime = YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    GMSCameraPosition *currentMap = [GMSCameraPosition cameraWithLatitude:mapView.myLocation.coordinate.latitude longitude:mapView.myLocation.coordinate.longitude zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:currentMap];
    mapView.frame = CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 94);
    mapView.myLocationEnabled       = YES;
    mapView.multipleTouchEnabled    = NO;
    mapView.settings.rotateGestures = NO;
    mapView.settings.tiltGestures   = NO;
    mapView.delegate = self;
    
    
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
            isFirstTime = NO;
        }
    }
}
- (void)marker {
    //set a marker on map
    
    NibChoice *nibChoice = [[NibChoice alloc]init];
    nibChoice           = [[[NSBundle mainBundle] loadNibNamed:@"NibChoice" owner:self options:nil]objectAtIndex:0];
    nibChoice.frame = CGRectMake(0, 0, 150, 35);
    nibChoice.labTitle.text = @"7-11 臺大店";
    
    GMSMarker *garbageLocation = [[GMSMarker alloc] init];
    garbageLocation.icon = [self imageFromView:nibChoice];
    garbageLocation.position = CLLocationCoordinate2DMake(25.017340, 121.539752);
    garbageLocation.title = @"1";
//    garbageLocation.appearAnimation = kGMSMarkerAnimationPop;
    garbageLocation.map = mapView;
    
}
-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker
{
    NibChoice *nibChoice      = [[NibChoice alloc]init];
    nibChoice                 = [[[NSBundle mainBundle] loadNibNamed:@"NibChoice" owner:self options:nil]objectAtIndex:0];
    nibChoice.frame           = CGRectMake(0, 0, 150, 35);
    nibChoice.labTitle.text   = @"7-11 臺大店";
    nibChoice.backgroundColor = [UIColor redColor];
    marker.icon = [self imageFromView:nibChoice];
    
    
    _btnConfirm.enabled = YES;
    _btnConfirm.backgroundColor = _colorGreen;
    _btnConfirm.alpha = 1.0f;
    return YES;
}

- (IBAction)backBtn:(id)sender {
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Cell"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (UIImage *)imageFromView:(UIView *) view
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(view.frame.size);
    }
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
@end