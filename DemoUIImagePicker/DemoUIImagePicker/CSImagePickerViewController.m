//
//  CSImagePickerViewController.m
//  DemoUIImagePicker
//
//  Created by zj－db0465 on 16/2/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CSImagePickerViewController.h"
#import "TopBarView.h"
#import "CSCameraViewController.h"

@interface CSImagePickerViewController () <
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (nonatomic) TopBarView *topBarView;

@end

@implementation CSImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBarHidden = YES;
    self.toolbarHidden = YES;
    
    // UINavigationControllerDelegate和UIImagePickerControllerDelegate共用
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (TopBarView *)topBarView {
    if (!_topBarView) {
        _topBarView = [[[NSBundle mainBundle] loadNibNamed:@"TopBarView" owner:self options:nil] objectAtIndex:0];
        _topBarView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
        
        [_topBarView.btnBack addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
        [_topBarView.btnCamera addTarget:self action:@selector(actionCamera:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _topBarView;
}

- (void)actionBack:(UIButton *)sender {
    if (self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self popViewControllerAnimated:YES];
    }
}

- (void)actionCamera:(UIButton *)sender {
    CSCameraViewController *cameraVC = [[CSCameraViewController alloc] init];
    
    [self presentViewController:cameraVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

// 如果不重写这些方法，则选取photo之后只会dismiss picker，没有其他作用。
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if (_csImagePickerViewControllerDelegate && [_csImagePickerViewControllerDelegate respondsToSelector:@selector(csImagePicker:didFinishPickerPhotoWith:)]) {
        [_csImagePickerViewControllerDelegate csImagePicker:picker didFinishPickerPhotoWith:info];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationBar addSubview:self.topBarView];
    // 去掉其他的topBarView
    for (UIView *subView in [self.navigationBar subviews]) {
        if (subView != self.topBarView) {
            subView.hidden = YES;
        }
    }
    
    if ([NSStringFromClass([viewController class]) isEqualToString:@"PUUIAlbumListViewController"]) {
        [self.topBarView.btnBack setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    } else {
        [self.topBarView.btnBack setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

}

@end
