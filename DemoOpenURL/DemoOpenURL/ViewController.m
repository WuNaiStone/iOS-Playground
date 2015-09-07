//
//  ViewController.m
//  DemoOpenURL
//
//  Created by zj－db0465 on 15/9/6.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *username = @"icetime017";
    [self openUserPage:username];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isInstagramInstalled {
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
    return [[UIApplication sharedApplication] canOpenURL:instagramURL];
}

- (void)openUserPage:(NSString *)username {
    NSURL *fansPageURL;
    if ([self isInstagramInstalled]) {
        fansPageURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://user?username=%@", username]];
    } else {
        fansPageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://instagram.com/%@", username]];
    }
    [[UIApplication sharedApplication] openURL:fansPageURL];
}

@end
