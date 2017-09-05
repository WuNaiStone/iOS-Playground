//
//  ViewController.m
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import "ViewController.h"
#import "ViewModelUserInfo.h"

@interface ViewController ()

@property (nonatomic, strong) ViewModelUserInfo *viewModelUserInfo;

@property (nonatomic, strong) UIButton *btnUpdate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.viewModelUserInfo.viewUserInfo = [[ViewUserInfo alloc] initWithFrame:self.view.bounds];
    self.viewModelUserInfo.modelUserInfo = [ModelUserInfo new];
    [self.viewModelUserInfo bind];
    
    [self.view addSubview:self.viewModelUserInfo.viewUserInfo];
    
    
    [self.view addSubview:self.btnUpdate];
}

- (ViewModelUserInfo *)viewModelUserInfo
{
    if (!_viewModelUserInfo) {
        _viewModelUserInfo = [ViewModelUserInfo new];
    }
    
    return _viewModelUserInfo;
}

- (UIButton *)btnUpdate
{
    if (!_btnUpdate) {
        _btnUpdate = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 100, 50)];
        _btnUpdate.backgroundColor = [UIColor greenColor];
        [_btnUpdate setTitle:@"Update" forState:UIControlStateNormal];
        [_btnUpdate addTarget:self action:@selector(actionUpdate:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnUpdate;
}

- (void)actionUpdate:(UIButton *)sender
{
    self.viewModelUserInfo.modelUserInfo.name   = @"Chris";
    self.viewModelUserInfo.modelUserInfo.age    = 18;
    self.viewModelUserInfo.modelUserInfo.city   = @"Shanghai";
}

@end
