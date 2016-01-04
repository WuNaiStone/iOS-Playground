//
//  ViewController.m
//  DemoAsyncDisplayKit
//
//  Created by zj－db0465 on 16/1/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 主线程解码图像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.image = [UIImage imageNamed:@"Model.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    // 后台的异步线程解码图像
    ASImageNode *imageNode = [[ASImageNode alloc] init];
    imageNode.image = [UIImage imageNamed:@"Model.jpg"];
    imageNode.contentMode = UIViewContentModeScaleAspectFit;
    imageNode.frame = CGRectMake(0, 300, 200, 200);
    [self.view addSubview:imageNode.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
