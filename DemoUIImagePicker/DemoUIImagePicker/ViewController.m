//
//  ViewController.m
//  DemoUIImagePicker
//
//  Created by zj－db0465 on 16/2/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "CSImagePickerViewController.h"

#import "GPUImage.h"

@interface ViewController () <CSImagePickerViewControllerDelegate>

@end

@implementation ViewController
{
    // GPUImageStillCamera要放在成员变量或属性中. 否则GPUImageView显示空白.
    GPUImageStillCamera *stillCamera;
    GPUImageVideoCamera *videoCamera;
    GPUImageMovieWriter *movieWriter;
    
    GPUImageView *gpuImageView;
    UIButton *btnCamera;
    UIButton *btnCancel;
    
    
    GPUImageVignetteFilter *vignetteFilter;
}

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
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 50)];
    [btn1 setTitle:@"GPUImage" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(actionGPUImage:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2.0f;
    [self.view addSubview:btn1];
}

- (void)actionBtn:(UIButton *)sender {
    CSImagePickerViewController *imagePicker = [[CSImagePickerViewController alloc] init];
    imagePicker.csImagePickerViewControllerDelegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)addImageView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CSImagePickerViewControllerDelegate

- (void)csImagePicker:(CSImagePickerViewController *)picker didFinishPickerPhotoWith:(NSDictionary *)info {
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

#pragma mark - GPUImage


- (void)actionGPUImage:(UIButton *)sender {
    if (gpuImageView) {
        return;
    }
    
    gpuImageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150)];
    [self.view addSubview:gpuImageView];
    
    stillCamera = [[GPUImageStillCamera alloc] init];
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    vignetteFilter = [[GPUImageVignetteFilter alloc] init];
    [stillCamera addTarget:vignetteFilter];
    
    [vignetteFilter addTarget:gpuImageView];
    
    [stillCamera startCameraCapture];
    
    btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, gpuImageView.frame.size.height, 100, 50)];
    [btnCancel setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCancel];
    
    btnCamera = [[UIButton alloc] initWithFrame:CGRectMake(100, gpuImageView.frame.size.height, 100, 50)];
    btnCamera.center = CGPointMake(self.view.frame.size.width / 2, btnCamera.center.y);
    [btnCamera setImage:[UIImage imageNamed:@"Camera"] forState:UIControlStateNormal];
    [btnCamera addTarget:self action:@selector(actionCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCamera];
}

- (void)actionCancel:(UIButton *)sender {
    if (!stillCamera) {
        return;
    }
    
    [stillCamera stopCameraCapture];
    [gpuImageView removeFromSuperview];
    gpuImageView = nil;
    
    [btnCamera removeFromSuperview];
    btnCamera = nil;
    [btnCancel removeFromSuperview];
    btnCancel = nil;
}

- (void)actionCamera:(UIButton *)sender {
    if (!stillCamera) {
        return;
    }
    
    __weak ViewController *weakSelf = self;
    [stillCamera capturePhotoAsImageProcessedUpToFilter:vignetteFilter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        if (!processedImage) {
            NSLog(@"Error : %@", error.description);
            return;
        }
        
        weakSelf.imageView.image = processedImage;
        
        [weakSelf actionCancel:nil];
    }];
}

@end
