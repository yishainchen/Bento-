//
//  MapViewController.m
//  Bento++
//
//  Created by yishain on 8/22/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//

#import "MapViewController.h"
#import "LoginViewController.h"
#import <GoogleMaps/GoogleMaps.h>
@interface MapViewController ()  <GMSMapViewDelegate,CLLocationManagerDelegate, UITextFieldDelegate>

{
    BOOL isFirstTime;
    GMSMapView *mapView_;
    CLLocationManager *locationManager;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];//直接指定你要的地點用經緯度(zoom指定地圖大小)
    GMSCameraPosition *currentMap = [GMSCameraPosition cameraWithLatitude:mapView_.myLocation.coordinate.latitude longitude:mapView_.myLocation.coordinate.longitude zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;

    mapView.frame = CGRectMake( 0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 94);
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"Hello World";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    
    [self.view addSubview:mapView];
  
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]])
    {
        if (isFirstTime == YES) {
            
            
            [mapView_ animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:mapView_.myLocation.coordinate.latitude
                                                                          longitude:mapView_.myLocation.coordinate.longitude
                                                                               zoom:17]];
            
            isFirstTime = NO;
            
        }
    }
}

- (IBAction)backBtn:(id)sender {
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Cell"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end