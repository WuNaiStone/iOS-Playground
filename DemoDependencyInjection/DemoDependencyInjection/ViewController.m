//
//  ViewController.m
//  DemoDependencyInjection
//
//  Created by zj－db0465 on 14/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"
#import "UserInfoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)actionShowUserInfo:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfoViewController *userInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
    [self presentViewController:userInfoVC animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        userInfoVC.user = [[User alloc] initWithName:@"Chris" age:18 city:@"Shanghai"];
    });
}

@end
