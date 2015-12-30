//
//  ViewController.m
//  DemoBlurImage
//
//  Created by zj－db0465 on 15/12/30.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"

@interface ViewController ()

@end

@implementation ViewController {

    UIView *aView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:aView.bounds];
    imageView.image = [UIImage imageNamed:@"Model.jpg"];
    [aView addSubview:imageView];
    [self.view addSubview:aView];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 + 10, self.view.frame.size.width, 30)];
    [btn setTitle:@"Blur" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionBlur:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionBlur:(UIButton *)sender {
    UIImageView *imageViewBlur = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 + 50, self.view.frame.size.width, self.view.frame.size.height / 2 - 50)];
    imageViewBlur.image = [self blurUIView:aView];
    [self.view addSubview:imageViewBlur];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)blurUIView:(UIView *)view {
    UIGraphicsBeginImageContext(view.frame.size);
    [view drawViewHierarchyInRect:view.frame afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [snapshot applyLightEffect];
}

@end
