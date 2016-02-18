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
    UIButton *btnRotate;
    UIButton *btnFlash;
    
    
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
    
    [self addCameraSettingsButton];
    
    [stillCamera startCameraCapture];
}

#pragma mark - Camera Settings

- (void)addCameraSettingsButton {
    btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, gpuImageView.frame.size.height, 100, 50)];
    [btnCancel setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCancel];
    
    btnCamera = [[UIButton alloc] initWithFrame:CGRectMake(100, gpuImageView.frame.size.height, 100, 50)];
    btnCamera.center = CGPointMake(self.view.frame.size.width / 2, btnCamera.center.y);
    [btnCamera setImage:[UIImage imageNamed:@"Camera"] forState:UIControlStateNormal];
    [btnCamera addTarget:self action:@selector(actionCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCamera];

    btnFlash = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [btnFlash setImage:[UIImage imageNamed:@"Flash_On"] forState:UIControlStateNormal];
    [btnFlash addTarget:self action:@selector(actionFlash:) forControlEvents:UIControlEventTouchUpInside];
    [btnFlash setTitle:@"Off" forState:UIControlStateNormal];
    [self.view addSubview:btnFlash];
    
    btnRotate = [[UIButton alloc] initWithFrame:CGRectMake(gpuImageView.frame.size.width - 100, 0, 100, 50)];
    [btnRotate setImage:[UIImage imageNamed:@"Rotate"] forState:UIControlStateNormal];
    [btnRotate addTarget:self action:@selector(actionRotate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRotate];
}

- (void)actionCancel:(UIButton *)sender {
    if (!stillCamera) {
        return;
    }
    
    [stillCamera stopCameraCapture];
    [gpuImageView removeFromSuperview];
    gpuImageView = nil;
    
    [btnCancel removeFromSuperview];
    btnCancel = nil;
    [btnCamera removeFromSuperview];
    btnCamera = nil;
    [btnRotate removeFromSuperview];
    btnRotate = nil;
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

- (void)actionFlash:(UIButton *)sender {
    [stillCamera.inputCamera lockForConfiguration:nil];
    
    if ([btnFlash.titleLabel.text isEqualToString:@"Off"]) {
        [btnFlash setTitle:@"Auto" forState:UIControlStateNormal];
        [stillCamera.inputCamera setTorchMode:AVCaptureTorchModeAuto];
    } else if ([btnFlash.titleLabel.text isEqualToString:@"On"]) {
        [btnFlash setTitle:@"Off" forState:UIControlStateNormal];
        [stillCamera.inputCamera setTorchMode:AVCaptureTorchModeOff];
    } else {
        [btnFlash setTitle:@"On" forState:UIControlStateNormal];
        [stillCamera.inputCamera setTorchMode:AVCaptureTorchModeOn];
    }
    
    [stillCamera.inputCamera unlockForConfiguration];
}

- (void)actionRotate:(UIButton *)sender {
    [stillCamera rotateCamera];
}

@end
