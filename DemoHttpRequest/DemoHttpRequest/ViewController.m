//
//  ViewController.m
//  DemoHttpRequest
//
//  Created by zj－db0465 on 16/2/17.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

#define URL_JSON   @"http://192.241.217.249/city"

#define NSURLConnection_AsynchronousRequest 1001

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addBtns];
}

- (void)addBtns {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"NSData dataWithContentsOfURL" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionNSDataWithContentsOfURL:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    [btn1 setTitle:@"AFNetworking" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(actionAFNetworking:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2.0f;
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 50)];
    [btn2 setTitle:@"NSURLSession" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(actionNSURLSession:) forControlEvents:UIControlEventTouchUpInside];
    btn2.layer.borderColor = [UIColor redColor].CGColor;
    btn2.layer.borderWidth = 2.0f;
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 50)];
    [btn3 setTitle:@"NSURLConnection: AsynchronousRequest" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn3 addTarget:self action:@selector(actionNSURLConnection:) forControlEvents:UIControlEventTouchUpInside];
    btn3.layer.borderColor = [UIColor redColor].CGColor;
    btn3.layer.borderWidth = 2.0f;
    btn3.tag = NSURLConnection_AsynchronousRequest;
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 500, self.view.frame.size.width, 50)];
    [btn4 setTitle:@"NSURLConnection: Request" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn4 addTarget:self action:@selector(actionNSURLConnection:) forControlEvents:UIControlEventTouchUpInside];
    btn4.layer.borderColor = [UIColor redColor].CGColor;
    btn4.layer.borderWidth = 2.0f;
    [self.view addSubview:btn4];
}

- (void)actionNSDataWithContentsOfURL:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:URL_JSON];
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"string : %@", string);
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *jsonError;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
    NSLog(@"jsonData : %@", jsonData);
}

- (void)actionAFNetworking:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:URL_JSON];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error : %@", error.description);
    }];
}

- (void)actionNSURLSession:(UIButton *)sender {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URL_JSON]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"response : %@", response);
        
        NSError *jsonError;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSLog(@"jsonData : %@", jsonData);
    }];
    [dataTask resume];
}

- (void)actionNSURLConnection:(UIButton *)sender {
    if (sender.tag == NSURLConnection_AsynchronousRequest) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URL_JSON]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"response : %@", response);
            
            NSError *jsonError;
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            NSLog(@"jsonData : %@", jsonData);
        }];
    } else {
        
    }
}

@end
