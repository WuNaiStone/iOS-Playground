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

    [self demoOpenURL];
    
    [self demoJump];
    
    [self demoJumpWithData];
}

- (void)demoOpenURL {
    BOOL wechat = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]];
    NSLog(@"wechat : %d", wechat);
    
    BOOL weixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    NSLog(@"weixin : %d", weixin);
    
    BOOL instagram = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"instagram://"]];
    NSLog(@"instagram : %d", instagram);
    NSString *username = @"icetime017";
    [self openUserPage:username];
    /**
     log:
     2016-04-03 10:46:03.718 DemoOpenURL[1474:481443] -canOpenURL: failed for URL: "instagram://" - error: "(null)"
     2016-04-03 10:46:03.718 DemoOpenURL[1474:481443] instagram : 0
     2016-04-03 10:46:03.719 DemoOpenURL[1474:481443] -canOpenURL: failed for URL: "instagram://location?id=1" - error: "(null)"
     
     未安装instagram, 则调用canOpenURL: failed for URL. 返回0
     调用openURL, 直接跳转至instagram的网页.
     */
}

#pragma mark - instagram
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
//    [[UIApplication sharedApplication] openURL:fansPageURL];
}

#pragma mark - jump
- (void)demoJump {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Jump to DemoMixpanel" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionButton:(UIButton *)sender {
    BOOL mixpanel = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"demomixpanel://"]];
    NSLog(@"mixpanel : %d", mixpanel);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"demomixpanel://"]];
    
    /**
     未安装DemoMixpanel:
     2016-04-03 10:50:53.433 DemoOpenURL[1480:483309] -canOpenURL: failed for URL: "demomixpanel://" - error: "(null)"
     2016-04-03 10:50:53.434 DemoOpenURL[1480:483309] mixpanel : 0
     调用canOpenURL: failed for URL. 返回0
     调用openURL: 没反应.
     
     已安装DemoMixpanel:
     2016-04-03 10:56:44.156 DemoOpenURL[1496:486641] mixpanel : 1
     调用canOpenURL: 没有输出, 返回1
     调用openURL: 跳转至DemoMixpanel.
     */
}

#pragma mark - jump with data
- (void)demoJumpWithData {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 50)];
    [btn setTitle:@"Jump with data" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionJumpWithData:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionJumpWithData:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"Modal.jpg";
    pasteboard.image = [UIImage imageNamed:@"Modal.jpg"];
    
    
    BOOL mixpanel = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"demomixpanel://"]];
    NSLog(@"mixpanel : %d", mixpanel);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"demomixpanel://"]];
}

@end
