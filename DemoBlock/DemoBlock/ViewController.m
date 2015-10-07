//
//  ViewController.m
//  DemoBlock
//
//  Created by zj－db0465 on 15/9/17.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@property (nonatomic) UILabel *lbBlock;
@property (nonatomic) UIButton *lbBtn;

@property (nonatomic) UILabel *lb;
@property (nonatomic) UIButton *btn;

@property (nonatomic, copy) int (^myBlock)(int a, int b);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self blockTest];
    [self blockTestPassing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)blockTest {
    _lbBlock = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.bounds), 40)];
    _lbBlock.backgroundColor = [UIColor grayColor];
    _lbBlock.textAlignment = NSTextAlignmentCenter;
    _lbBlock.text = @"block label";
    [self.view addSubview:_lbBlock];
    
    _lbBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 40)];
    _lbBtn.layer.borderColor = [[UIColor redColor] CGColor];
    _lbBtn.layer.borderWidth = 1.0f;
    [_lbBtn setTitle:@"block button" forState:UIControlStateNormal];
    [_lbBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_lbBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [_lbBtn addTarget:self action:@selector(actionBlock:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lbBtn];
}

- (IBAction)actionBlock:(UIButton *)sender {
    if (![_lbBlock.text isEqualToString:@"block label"]) {
        _lbBlock.text = @"block label";
        return;
    }
    int sum = 0;
    
    // property
    _myBlock = ^int (int a, int b) {
        return b + a;
    };
    sum = _myBlock(10, 20);
    
    // 局部变量
//    int (^myBlock) (int a, int b) = ^int (int a, int b) {
//        return a - b;
//    };
//    sum  = myBlock(10, 20);
    
    // typedef
//    typedef int (^MyBlock)(int a, int b);
//    MyBlock myBlock = ^int (int a, int b) {
//        return a * b;
//    };
//    sum = myBlock(10, 20);
    
    _lbBlock.text = [NSString stringWithFormat:@"%d", sum];
}

- (void)blockTestPassing {
    _lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, CGRectGetWidth(self.view.bounds), 40)];
    _lb.backgroundColor = [UIColor grayColor];
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.text = @"initial label";
    [self.view addSubview:_lb];
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), 40)];
    _btn.layer.borderColor = [[UIColor redColor] CGColor];
    _btn.layer.borderWidth = 1.0f;
    [_btn setTitle:@"ViewController" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [_btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (IBAction)action:(UIButton *)sender {
    TestViewController *testVC = [[TestViewController alloc] init];
//    __weak ViewController *weakSelf = self;
//    testVC.blockUpdateBtnTitle = ^(NSString *btnTitle) {
////        weakSelf.lb.text = [NSString stringWithFormat:@"%@", btnTitle];
//        weakSelf.lb.text = btnTitle;
//    };
    [self presentViewController:testVC animated:NO completion:nil];
}

@end
