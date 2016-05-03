//
//  ItemViewController.m
//  DemoAsyncDisplayKit
//
//  Created by Chris Hu on 16/4/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ItemViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ItemViewController ()

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addBtns];
    
    [self showASNode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBtns {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setTitle:@"Back" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showASNode {
    switch (_itemType) {
        case ItemType_ASTextNode:
            [self addTextNode];
            break;
        case ItemType_ASImageNode:
            [self addImageNode];
            break;
            
        default:
            break;
    }
}

#pragma mark - ItemType_ASTextNode

- (void)addTextNode {
    ASTextNode *textNode = [[ASTextNode alloc] init];
    textNode.attributedString = [[NSAttributedString alloc] initWithString:@"ASTextNode"
                                                                attributes:nil];
    [self.view addSubnode:textNode];
}

#pragma mark - ItemType_ASImageNode

- (void)addImageNode {
    // 主线程解码图像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 200, 200)];
    UIImage *image1 = [UIImage imageNamed:@"Model.jpg"];
    imageView.image = image1;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    // 后台的异步线程解码图像
    ASImageNode *imageNode = [[ASImageNode alloc] init];
    UIImage *image2 = [UIImage imageNamed:@"Model.jpg"];
    imageNode.image = image2;
    imageNode.contentMode = UIViewContentModeScaleAspectFit;
    imageNode.frame = CGRectMake(100, 300, 200, 200);
    [self.view addSubnode:imageNode];
}

@end
