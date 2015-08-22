//
//  ViewController.m
//  Bento++
//
//  Created by yishain on 8/21/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <AFNetworking/AFNetworking.h>
#import "MapViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cheapBtn:(id)sender {
    MapViewController *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
    [self presentViewController:mapVC animated:YES completion:nil];
}

- (IBAction)mediumBtn:(id)sender {
    MapViewController *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
    [self presentViewController:mapVC animated:YES completion:nil];
}

- (IBAction)costlyBtn:(id)sender {
    MapViewController *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
    [self presentViewController:mapVC animated:YES completion:nil];
}

- (IBAction)backBtn:(id)sender {
    ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"VC"];
    [self presentViewController:VC animated:YES completion:nil];
}



//-(void)getdata {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:@"http://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fcbb2a25b234976333ca4a3cf30c4388%3A9%3A56417405"
//      parameters:@{@"api-key":@"fcbb2a25b234976333ca4a3cf30c4388:9:56417405"}
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSLog(@"success");
//             NSLog(@"response: %@", responseObject);
//             dict = responseObject;
//             NSLog(@"eric = %@",dict[@"response"][@"docs"][i][@"headline"][@"main"]);
//             
//             
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             NSLog(@"failure: %@", error);
//         }];
//}



@end
