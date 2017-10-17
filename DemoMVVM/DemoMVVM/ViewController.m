//
//  ViewController.m
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import "ViewController.h"

#import "ViewUserInfo.h"

@interface ViewController ()

/**
 View持有ViewModel，ViewModel持有Model
 */
@property (nonatomic, strong) ViewUserInfo *viewUserInfo;
@property (nonatomic, strong) ViewModelUserInfo *viewModelUserInfo;

@property (nonatomic, strong) UIButton *btnUpdate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.viewUserInfo];
    self.viewUserInfo.viewModelUserInfo = self.viewModelUserInfo;
    
    [self.view addSubview:self.btnUpdate];
}

- (ViewUserInfo *)viewUserInfo
{
    if (!_viewUserInfo) {
        _viewUserInfo = [[ViewUserInfo alloc] initWithFrame:self.view.bounds];
    }
    
    return _viewUserInfo;
}

- (ViewModelUserInfo *)viewModelUserInfo
{
    if (!_viewModelUserInfo) {
        _viewModelUserInfo = [[ViewModelUserInfo alloc] init];
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
    // Model -> View
    NSLog(@"Model -> View");
    [self.viewModelUserInfo updateModelFromMockWeb];
}

@end
