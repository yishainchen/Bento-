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



- (IBAction)backBtn:(id)sender {
    ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"VC"];
    [self presentViewController:VC animated:YES completion:nil];
}






@end
