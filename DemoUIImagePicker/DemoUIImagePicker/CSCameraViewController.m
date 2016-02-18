//
//  CSCameraViewController.m
//  DemoUIImagePicker
//
//  Created by zj－db0465 on 16/2/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CSCameraViewController.h"
#import "ToolBarView.h"

@interface CSCameraViewController () <
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property (nonatomic) ToolBarView *toolBarView;

@end

@implementation CSCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.allowsEditing = YES;
    self.delegate = self;
    
//    [self.view addSubview:self.toolBarView];
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

#pragma mark - UIImagePickerControllerDelegate

// 如果不重写这些方法，则选取photo之后只会dismiss picker，没有其他作用。
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImage *editedImage = [info valueForKey:UIImagePickerControllerEditedImage];
    UIImage *savedImage = editedImage ?: originalImage;
    UIImageWriteToSavedPhotosAlbum(savedImage, nil, nil, nil);
    
    __weak CSCameraViewController *weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        weakSelf.completionBlock(picker, info);
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
