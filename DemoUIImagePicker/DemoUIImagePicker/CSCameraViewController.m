//
//  CSCameraViewController.m
//  DemoUIImagePicker
//
//  Created by zj－db0465 on 16/2/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CSCameraViewController.h"
#import "ToolBarView.h"

@interface CSCameraViewController ()

@property (nonatomic) ToolBarView *toolBarView;

@end

@implementation CSCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.toolBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [[[NSBundle mainBundle] loadNibNamed:@"ToolBarView" owner:self options:nil] objectAtIndex:0];
        _toolBarView.frame = CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 100);
        
        [_toolBarView.btnClose addTarget:self action:@selector(actionClose:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBarView.btnCamera addTarget:self action:@selector(actionCamera:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _toolBarView;
}

- (void)actionClose:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionCamera:(UIButton *)sender {
    
}

@end
