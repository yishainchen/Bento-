//
//  MapViewController.h
//  Bento++
//
//  Created by yishain on 8/22/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>


@interface MapViewController : UIViewController <GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@end
