//
//  LoginViewController.m
//  Bento++
//
//  Created by yishain on 8/21/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//
//
//  LoginViewController.m
//  Bento++
//
//  Created by yishain on 8/21/15.
//  Copyright (c) 2015 yishain. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [FBSDKProfile currentProfile];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbTokenChangeNoti:) name:FBSDKAccessTokenDidChangeNotification object:nil];
}

- (IBAction)fbLoginButtonDidPressed:(UIButton *)sender {
    NSLog(@"### FB Login Button Did Pressed ###");
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                
            }
        }
    }];
}


-(void)fbTokenChangeNoti:(NSNotification*)noti {
    if ([FBSDKAccessToken currentAccessToken]) {
        ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Cell"];
        [self presentViewController:VC animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end