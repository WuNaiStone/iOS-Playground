//
//  ViewController.m
//  DemoALAssetsLibrary
//
//  Created by zj－db0465 on 15/11/2.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "AssetsCollectionViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    btn.center = self.view.center;
    [btn setTitle:@"选择照片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionLoadAssets:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionLoadAssets:(UIButton *)sender {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 一个section放置cell的个数
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4;
    layout.itemSize = CGSizeMake(width, width);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    AssetsCollectionViewController *collectionViewController = [[AssetsCollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:collectionViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
