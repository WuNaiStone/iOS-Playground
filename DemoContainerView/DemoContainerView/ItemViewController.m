//
//  ItemViewController.m
//  DemoContainerView
//
//  Created by zj－db0465 on 16/5/6.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ItemViewController.h"
#import "Item2ViewController.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addButtonBack];
    
    [self addLabel];
    
    [self addButtonItem2];
}

- (void)addButtonBack {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(actionBack:)];
    self.navigationItem.leftBarButtonItem = back;
}


- (void)actionBack:(UIButton *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)addButtonItem2 {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 50)];
    [btn setTitle:@"Push Item2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionItem2:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionItem2:(UIButton *)sender {
    Item2ViewController *item2VC = [[Item2ViewController alloc] init];
    [self.navigationController pushViewController:item2VC animated:YES];
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 30)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    label.text = self.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
