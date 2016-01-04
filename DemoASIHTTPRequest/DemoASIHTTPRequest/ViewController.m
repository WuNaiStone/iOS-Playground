//
//  ViewController.m
//  DemoASIHTTPRequest
//
//  Created by zj－db0465 on 16/1/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

#import <ASIHTTPRequest/ASIHTTPRequest.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"GetJson" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionGetJson:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionGetJson:(UIButton *)sender {
    CompletionBlock completionBlock = ^(NSData *data) {
        NSLog(@"actionGetJson completionBlock ...");
        NSLog(@"data : %@", data);
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"data : %@", dataString);
    };
    [self getBaidu:completionBlock];
}

- (void)getBaidu:(CompletionBlock)completionBlock {
    NSURL *url = [NSURL URLWithString:@"http://xxxxxx/xxxxx.json"];
    ASIHTTPRequest *httpRequest = [ASIHTTPRequest requestWithURL:url];

    [httpRequest setDataReceivedBlock:^(NSData *data) {
        if (completionBlock) {
            completionBlock(data);
        }
    }];
    
    [httpRequest startSynchronous];
    int code = [httpRequest responseStatusCode];
    NSString *response = [httpRequest responseString];
}

@end

