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
@property (nonatomic, strong) ModelUserInfo *modelUserInfo;

@property (nonatomic, strong) UIButton *btnUpdate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.viewUserInfo];
    [self.view addSubview:self.btnUpdate];
    
    [self.viewModelUserInfo bindWithModel:self.modelUserInfo];
    
    // 在此使用setter方法来进行ViewModel的绑定，若改为bindWithViewModel更好理解。
//    self.viewUserInfo.viewModelUserInfo = self.viewModelUserInfo;
    [self.viewUserInfo bindWithViewModel:self.viewModelUserInfo];
    
    // 这里，View是独立出去的，所以将View持有ViewModel。
    // 如果是VC中的一个个单独的label或button等，则采用如下方式：
    // self.viewUserInfo.textFieldName.text = self.viewModelUserInfo.modelUserInfo.name;
    // self.viewUserInfo.textFieldCity.text = self.viewModelUserInfo.modelUserInfo.city;
}

- (void)actionUpdate:(UIButton *)sender
{
    // Model -> View
    NSLog(@"Model -> View");
    [self.viewModelUserInfo updateModelFromMockWeb];
}

// MARK: - getters
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

- (ModelUserInfo *)modelUserInfo {
    if (!_modelUserInfo) {
        _modelUserInfo = [ModelUserInfo new];
        _modelUserInfo.name = @"initial name";
        _modelUserInfo.age = 1;
        _modelUserInfo.city = @"initial city";
    }
    
    return _modelUserInfo;
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

@end
