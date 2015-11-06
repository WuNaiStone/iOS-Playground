//
//  ViewController.m
//  DemoALAssetsLibrary
//
//  Created by zj－db0465 on 15/11/2.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "AssetsCollectionViewController.h"
#import "AssetView.h"

@interface ViewController () <UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"选择照片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionLoadAssets:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    btn1.tag = 200;
    [btn1 setTitle:@"系统相册" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(actionImagePicker:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2.0f;
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 50)];
    btn2.tag = 300;
    [btn2 setTitle:@"拍照" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(actionImagePicker:) forControlEvents:UIControlEventTouchUpInside];
    btn2.layer.borderColor = [UIColor redColor].CGColor;
    btn2.layer.borderWidth = 2.0f;
    [self.view addSubview:btn2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionLoadAssets:(UIButton *)sender {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 一个section放置cell的个数
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4;
    layout.itemSize = CGSizeMake(width, width);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    AssetsCollectionViewController *collectionViewController = [[AssetsCollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:collectionViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)actionImagePicker:(UIButton *)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if (sender.tag == 200) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *savedImage = editedImage ?: originalImage;
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(savedImage, nil, nil, nil);
    }
    
    __weak ViewController *weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        AssetView *assetView = [[AssetView alloc] initWithFrame:self.view.frame];
        [weakSelf.view addSubview:assetView];
        
        [assetView showImage:savedImage];
    }];
}

@end
