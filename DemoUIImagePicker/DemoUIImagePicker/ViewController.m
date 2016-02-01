//
//  ViewController.m
//  DemoUIImagePicker
//
//  Created by zj－db0465 on 16/2/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "CSImagePickerViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate>

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addBtn];
    
    [self addImageView];
}

- (void)addBtn {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Image Picker" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionBtn:(UIButton *)sender {
    CSImagePickerViewController *imagePicker = [[CSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)addImageView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 250)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate

// 如果不重写这些方法，则选取photo之后只会dismiss picker，没有其他作用。
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *savedImage = editedImage ?: originalImage;
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(savedImage, nil, nil, nil);
    }
    
    __weak ViewController *weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        weakSelf.imageView.image = savedImage;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

}

@end
