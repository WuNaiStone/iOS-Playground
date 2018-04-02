//
//  ViewController.m
//  DemoAVFoundation
//
//  Created by Chris Hu on 30/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <
    AVCapturePhotoCaptureDelegate
>

@property (nonatomic, strong) dispatch_queue_t cameraQueue;

// 将deviceInput作为session的输入
@property (nonatomic, strong) AVCaptureDevice *frontDevice;
@property (nonatomic, strong) AVCaptureDevice *backDevice;
@property (nonatomic, strong) AVCaptureDevice *currentDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *frontDeviceInput;
@property (nonatomic, strong) AVCaptureDeviceInput *backDeviceInput;
@property (nonatomic, strong) AVCaptureDeviceInput *currentDeviceInput;

// 建立并配置session
@property (nonatomic, strong) AVCaptureSession *captureSession;

// AVCapturePhotoOutput
// AVCaptureVideoDataOutput
@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;

// 设置AVVideoCodecKey, flashMode等.
@property (nonatomic, strong) AVCapturePhotoSettings *photoSettings;

// previewLayer用于呈现session中的图像流
// 对于previewLayer上的点击需要转换到设备的坐标系统中, 如对焦.
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;


// operation
@property (nonatomic, strong) UIButton *btnCapture;
@property (nonatomic, strong) UIButton *btnRotate;
@property (nonatomic, strong) UIButton *btnFlash;

@end

@implementation ViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupCamera];
    [self p_setupPreviewLayer];
    
    [self.view addSubview:self.btnCapture];
    [self.view addSubview:self.btnRotate];
    [self.view addSubview:self.btnFlash];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 开始获取图像流
    dispatch_async(self.cameraQueue, ^{
        [self.captureSession startRunning];
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 停止获取图像流
    dispatch_async(self.cameraQueue, ^{
        [self.captureSession stopRunning];
    });
}

// MARK: - getters

- (UIButton *)btnCapture {
    if (!_btnCapture) {
        _btnCapture = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80) / 2, self.view.frame.size.height - 100, 80, 80)];
        [_btnCapture setImage:[UIImage imageNamed:@"btn.camera.capture"] forState:UIControlStateNormal];
        [_btnCapture addTarget:self action:@selector(actionBtnCapture:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCapture;
}

- (UIButton *)btnRotate {
    if (!_btnRotate) {
        _btnRotate = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height -60, 40, 40)];
        [_btnRotate setImage:[UIImage imageNamed:@"btn.camera.rotate"] forState:UIControlStateNormal];
        [_btnRotate addTarget:self action:@selector(actionBtnRotate:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRotate;
}

- (UIButton *)btnFlash {
    if (!_btnFlash) {
        _btnFlash = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 20, 40, 40)];
        [_btnFlash setImage:[UIImage imageNamed:@"btn.camera.flashOff"] forState:UIControlStateNormal];
        [_btnFlash addTarget:self action:@selector(actionBtnFlash:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnFlash;
}

// MARK: - actions

- (void)actionBtnCapture:(UIButton *)sender {
    dispatch_async(self.cameraQueue, ^{
        // photoSettings不能re-use, 需要重新创建
        AVCapturePhotoSettings *photoSettings = [AVCapturePhotoSettings photoSettingsFromPhotoSettings:self.photoSettings];
        [self.photoOutput capturePhotoWithSettings:photoSettings delegate:self];
    });
}

- (void)actionBtnRotate:(UIButton *)sender {
    AVCaptureDevice *currentDevice = self.currentDevice;
    AVCaptureDevice *targetDevice;
    AVCaptureDeviceInput *currentInput = self.currentDeviceInput;
    AVCaptureDeviceInput *targetInput;
    if (currentDevice == self.backDevice) {
        targetDevice = self.frontDevice;
    } else if (currentDevice == self.frontDevice) {
        targetDevice = self.backDevice;
    }
    
    [self.captureSession beginConfiguration];
    
    targetInput = [AVCaptureDeviceInput deviceInputWithDevice:targetDevice error:nil];
    [self.captureSession removeInput:currentInput];
    if (![self.captureSession canAddInput:targetInput]) {
        NSLog(@"session can not add input deviceInput");
        [self.captureSession commitConfiguration];
        return;
    }
    [self.captureSession addInput:targetInput];
    self.currentDevice = targetDevice;
    self.currentDeviceInput = targetInput;
    
    [self.captureSession commitConfiguration];
}

- (void)actionBtnFlash:(UIButton *)sender {
    if ([self.currentDevice hasFlash] && [self.currentDevice isFlashAvailable]) {
        [self.captureSession beginConfiguration];
        
        if (self.photoSettings.flashMode == AVCaptureFlashModeOff) {
            self.photoSettings.flashMode = AVCaptureFlashModeOn;
        } else if (self.photoSettings.flashMode == AVCaptureFlashModeOn) {
            self.photoSettings.flashMode = AVCaptureFlashModeOff;
        }
        
        [self.captureSession commitConfiguration];
    }
    
    NSString *imgFlash = self.photoSettings.flashMode == AVCaptureFlashModeOn ? @"btn.camera.flashOn" : @"btn.camera.flashOff";
    [self.btnFlash setImage:[UIImage imageNamed:imgFlash] forState:UIControlStateNormal];
}

// MARK: - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output
didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(nullable NSError *)error
{
    NSData *data = [photo fileDataRepresentation];
    UIImage *image = [UIImage imageWithData:data];
    
    // 前置摄像头需要做mirror
    AVCaptureDeviceInput *currentDeviceInput = self.captureSession.inputs.firstObject;
    if (currentDeviceInput.device.position == AVCaptureDevicePositionFront) {
        image = [[UIImage alloc] initWithCGImage:image.CGImage scale:1.f orientation:UIImageOrientationLeftMirrored];
    }
    
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
}

// MARK: - private

/**
 deviceInput -> session -> output
 将session加到previewLayer上边即可
 */
- (void)p_setupCamera {
    // 寻找device
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    if (device.position == AVCaptureDevicePositionBack) {
//        NSLog(@"back");
//    } else if (device.position == AVCaptureDevicePositionFront) {
//        NSLog(@"front");
//    }
    
    AVCaptureDeviceDiscoverySession *deviceDiscorySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                                                                                                   mediaType:AVMediaTypeVideo
                                                                                                                    position:AVCaptureDevicePositionUnspecified];
    if (deviceDiscorySession.devices.count <= 0) {
        NSLog(@"no capture device");
        return;
    }
    for (AVCaptureDevice *device in deviceDiscorySession.devices) {
        if (device.position == AVCaptureDevicePositionBack) {
            [device lockForConfiguration:nil];
            device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            [device unlockForConfiguration];
            
            self.backDevice = device;
            self.backDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.backDevice error:nil];
        } else if (device.position == AVCaptureDevicePositionFront) {
            self.frontDevice = device;
            self.frontDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.frontDevice error:nil];
        }
    }
    
    // 建立并配置session
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    // 将deviceInput作为session的输入
    if (![self.captureSession canAddInput:self.backDeviceInput]) {
        NSLog(@"session can not add input deviceInput");
        return;
    }
    [self.captureSession addInput:self.backDeviceInput];
    self.currentDevice = self.backDevice;
    self.currentDeviceInput = self.backDeviceInput;
    
    // AVCapturePhotoOutput
    // AVCaptureVideoDataOutput
    self.photoOutput = [AVCapturePhotoOutput new];
    if (![self.captureSession canAddOutput:self.photoOutput]) {
        NSLog(@"session can not add output photoOutput");
        return;
    }
    [self.captureSession addOutput:self.photoOutput];
    
    // 设置photoSettings
    NSDictionary *settingsDict = @{
                                   AVVideoCodecKey: AVVideoCodecTypeJPEG,
                                   };
    self.photoSettings = [AVCapturePhotoSettings photoSettingsWithFormat:settingsDict];
    self.photoSettings.flashMode = AVCaptureFlashModeOff;
    
    self.cameraQueue = dispatch_queue_create("com.icetime.camera.capture_session_queue", DISPATCH_QUEUE_SERIAL);
}

- (void)p_setupPreviewLayer {
    // previewLayer用于呈现session中的图像流
    // 对于previewLayer上的点击需要转换到设备的坐标系统中, 如对焦.
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame= self.view.bounds;
    [self.view.layer addSublayer:self.previewLayer];
}

@end
