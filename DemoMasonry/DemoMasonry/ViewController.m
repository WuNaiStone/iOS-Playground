//
//  ViewController.m
//  DemoMasonry
//
//  Created by zj－db0465 on 16/2/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController {

    UIView *view1;
    UIView *view2;
    UIView *view3;
    UIView *view4;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addView1];
    [self addView2];
    [self addView3];
    [self addView4];
}

- (void)addView1 {
    view1 = [[UIView alloc] init];
    view1.translatesAutoresizingMaskIntoConstraints = NO; // 不需要了
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];

    UIEdgeInsets edge = UIEdgeInsetsMake(100, 10, 200, 10);
    
    // 对view1添加约束
    // view1相对于self.view的edges为edge。
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(edge);
    }];

    /*
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(edge.top);
        make.left.equalTo(self.view.mas_left).with.offset(edge.left);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-edge.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-edge.right);
    }];
     */
}

- (void)addView2 {
    view2 = [UIView new];
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).multipliedBy(1).offset(10);
        make.left.equalTo(self.view.mas_left).multipliedBy(1).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).multipliedBy(1).offset(-100);
        make.right.equalTo(self.view.mas_right).multipliedBy(1).offset(-20);
    }];
}

- (void)addView3 {
    view3 = [UIView new];
    view3.translatesAutoresizingMaskIntoConstraints = NO;
    view3.backgroundColor = [UIColor redColor];
    [view1 addSubview:view3];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_top).multipliedBy(1).offset(10);
        make.left.equalTo(view1.mas_left).multipliedBy(1).offset(20);
        make.bottom.equalTo(view1.mas_bottom).multipliedBy(1).offset(-30);
        make.right.equalTo(view1.mas_right).multipliedBy(1).offset(-40);
    }];
}

- (void)addView4 {
    view4 = [UIView new];
    view4.translatesAutoresizingMaskIntoConstraints = NO;
    view4.backgroundColor =[UIColor blackColor];
    [view3 addSubview:view4];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view3);
        make.width.mas_equalTo(60);
        make.height.equalTo(@30); // 传递NSNumber类型
//        make.size.equalTo(view3).sizeOffset(CGSizeMake(100, -50))
    }];
}

@end
