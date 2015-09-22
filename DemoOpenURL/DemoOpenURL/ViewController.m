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
    
    BOOL mixpanel = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"demomixpanel://"]];
    NSLog(@"mixpanel : %d", mixpanel);
    
    BOOL instagram = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"instagram://"]];
    NSLog(@"instagram : %d", instagram);
    
    BOOL wechat = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]];
    NSLog(@"wechat : %d", wechat);
    
    BOOL weixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    NSLog(@"weixin : %d", weixin);
    
//    NSString *username = @"icetime017";
//    [self openUserPage:username];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"demomixpanel://"]];
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
