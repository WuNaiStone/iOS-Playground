//
//  ViewController.m
//  DemoUIButtonBackgroundColor
//
//  Created by Chris Hu on 16/7/7.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+CS_BackgroundColor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addBtns];
}

- (void)addBtns{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor greenColor];
    
    [btn setTitle:@"Button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(actionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//    [btn addTarget:self action:@selector(actionButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
//    [btn addTarget:self action:@selector(actionButtonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    
    
    [btn setBackgroundColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
}

- (void)actionButtonTouchDown:(UIButton *)sender {
    sender.backgroundColor = [UIColor blueColor];
}

- (void)actionButtonTouchUpOutside:(UIButton *)sender {
    sender.backgroundColor = [UIColor greenColor];
}

- (void)actionButtonTouchUpInside:(UIButton *)sender {
    sender.backgroundColor = [UIColor greenColor];
}





@end
