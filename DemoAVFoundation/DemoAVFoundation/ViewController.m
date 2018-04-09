//
//  ViewController.m
//  DemoAVFoundation
//
//  Created by Chris Hu on 30/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSInteger, CameraMode) {
    CameraMode_Photo = 0,
    CameraMode_Video,
};

@interface ViewController () <
    AVCapturePhotoCaptureDelegate,
    AVCaptureVideoDataOutputSampleBufferDelegate
>

@property (nonatomic, strong) dispatch_queue_t cameraQueue;
@property (nonatomic, strong) dispatch_queue_t videoWriterQueue;
@property (nonatomic, strong) dispatch_queue_t audioWriterQueue;

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
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;

// 设置AVVideoCodecKey, flashMode等.
@property (nonatomic, strong) AVCapturePhotoSettings *photoSettings;

// previewLayer用于呈现session中的图像流
// 对于previewLayer上的点击需要转换到设备的坐标系统中, 如对焦.
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

// 将视频写入本地文件
@property (nonatomic, strong) AVAssetWriter *videoWriter;
@property (nonatomic, strong) AVAssetWriterInput *videoWriterInput;
@property (nonatomic, strong) AVAssetWriterInput *audioWriterInput;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

// 当前拍摄模式
@property (nonatomic, assign) CameraMode currentCameraMode;
@property (nonatomic, assign) BOOL isVideoRecording;

// operation
@property (nonatomic, strong) UIButton *btnCapture;
@property (nonatomic, strong) UIButton *btnRotate;
@property (nonatomic, strong) UIButton *btnFlash;

@property (nonatomic, strong) UIButton *btnSwitchCameraMode;

@property (nonatomic, strong) UILabel *lbVideoDuration;

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
    
    [self.view addSubview:self.btnSwitchCameraMode];
    [self.view addSubview:self.lbVideoDuration];
    
    self.currentCameraMode = CameraMode_Photo;
    self.lbVideoDuration.hidden = YES;
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

- (UIButton *)btnSwitchCameraMode {
    if (!_btnSwitchCameraMode) {
        _btnSwitchCameraMode = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 60, 40, 40)];
//        [_btnSwitchCameraMode setImage:[UIImage imageNamed:@"btn.camera.rotate"] forState:UIControlStateNormal];
        [_btnSwitchCameraMode setTitle:@"视频" forState:UIControlStateNormal];
        [_btnSwitchCameraMode addTarget:self action:@selector(actionBtnSwitchCameraMode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSwitchCameraMode;
}

- (UILabel *)lbVideoDuration {
    if (!_lbVideoDuration) {
        _lbVideoDuration = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 150) / 2, self.view.frame.size.height - 150, 150, 30)];
        _lbVideoDuration.textAlignment = NSTextAlignmentCenter;
        _lbVideoDuration.text = @"录制视频中...";
        _lbVideoDuration.font = [UIFont systemFontOfSize:12.f];
    }
    return _lbVideoDuration;
}

- (AVAssetWriterInput *)videoWriterInput {
    if (!_videoWriterInput) {
        NSDictionary *settings = @{
                                   AVVideoCodecKey: AVVideoCodecTypeH264,
                                   AVVideoWidthKey: @600,
                                   AVVideoHeightKey: @800
                                   };
        _videoWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:settings];
        _videoWriterInput.expectsMediaDataInRealTime = YES;
        _videoWriterInput.transform = CGAffineTransformMakeRotation(M_PI / 2.f);
    }
    return _videoWriterInput;
}

- (AVAssetWriterInput *)audioWriterInput {
    return nil;
}

// MARK: - actions

- (void)actionBtnCapture:(UIButton *)sender {
    switch (self.currentCameraMode) {
        case CameraMode_Photo:
        {
            dispatch_async(self.cameraQueue, ^{
                // photoSettings不能re-use, 需要重新创建
                AVCapturePhotoSettings *photoSettings = [AVCapturePhotoSettings photoSettingsFromPhotoSettings:self.photoSettings];
                [self.photoOutput capturePhotoWithSettings:photoSettings delegate:self];
            });
        }
            break;
        case CameraMode_Video:
        {
            if (self.isVideoRecording) {
                NSLog(@"停止录制");
                self.isVideoRecording = NO;
                self.lbVideoDuration.hidden = YES;
                
                [self.videoWriterInput markAsFinished];
                [self.videoWriter finishWritingWithCompletionHandler:^{
                    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:self.videoWriter.outputURL];
                    } completionHandler:^(BOOL success, NSError * _Nullable error) {
                        NSLog(@"保存视频成功");
                    }];
                }];
            } else {
                NSLog(@"开始录制");
                self.isVideoRecording = YES;
                self.lbVideoDuration.hidden = NO;
                
                [self p_setupVideoWriter];
                
                [self.videoOutput setSampleBufferDelegate:self queue:self.cameraQueue];
            }
        }
            break;
        default:
            break;
    }
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

- (void)actionBtnSwitchCameraMode:(UIButton *)sender {
    [self.captureSession stopRunning];
    [self.captureSession beginConfiguration];

    switch (self.currentCameraMode) {
        case CameraMode_Photo:
            [self p_switchToVideoMode];
            
            NSLog(@"切换至视频模式");
            [_btnSwitchCameraMode setTitle:@"照片" forState:UIControlStateNormal];
            break;
        case CameraMode_Video:
            [self p_switchToPhotoMode];
            
            NSLog(@"切换至拍照模式");
            [_btnSwitchCameraMode setTitle:@"视频" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    [self.captureSession commitConfiguration];
    [self.captureSession startRunning];
}

- (void)p_switchToPhotoMode {
    [self.captureSession removeOutput:self.videoOutput];
    
    self.photoOutput = [AVCapturePhotoOutput new];
    if (![self.captureSession canAddOutput:self.photoOutput]) {
        NSLog(@"session can not add output photoOutput");
        return;
    }
    [self.captureSession addOutput:self.photoOutput];
    self.currentCameraMode = CameraMode_Photo;
    
    // 设置photoSettings
    NSDictionary *settingsDict = @{
                                   AVVideoCodecKey: AVVideoCodecTypeJPEG,
                                   };
    self.photoSettings = [AVCapturePhotoSettings photoSettingsWithFormat:settingsDict];
    self.photoSettings.flashMode = AVCaptureFlashModeOff;
}

- (void)p_switchToVideoMode {
    [self.captureSession removeOutput:self.photoOutput];
    
    self.videoOutput = [AVCaptureVideoDataOutput new];
    [self.videoOutput setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]}];
//    [self.videoOutput setSampleBufferDelegate:self queue:self.cameraQueue];
    if (![self.captureSession canAddOutput:self.videoOutput]) {
        NSLog(@"session can not add output videoOutput");
    }
    [self.captureSession addOutput:self.videoOutput];
    self.currentCameraMode = CameraMode_Video;
    
//    // 设置photoSettings
//    NSDictionary *settingsDict = @{
//                                   AVVideoCodecKey: AVVideoCodecTypeJPEG,
//                                   };
//    self.photoSettings = [AVCapturePhotoSettings photoSettingsWithFormat:settingsDict];
//    self.photoSettings.flashMode = AVCaptureFlashModeOff;
}

// MARK: - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output
didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(nullable NSError *)error
{
    if (error) {
        NSLog(@"fail to capture photo, due to %@", error.localizedDescription);
        return;
    }
    
    NSData *data = [photo fileDataRepresentation];
    UIImage *image = [UIImage imageWithData:data];
    
    // 前置摄像头需要做mirror
    AVCaptureDeviceInput *currentDeviceInput = self.captureSession.inputs.firstObject;
    if (currentDeviceInput.device.position == AVCaptureDevicePositionFront) {
        image = [[UIImage alloc] initWithCGImage:image.CGImage scale:1.f orientation:UIImageOrientationLeftMirrored];
    }
    
//    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    NSError *errorOfSavingImage;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } error:&errorOfSavingImage];
    if (errorOfSavingImage) {
        NSLog(@"fail to save image to photos, due to %@", errorOfSavingImage.localizedDescription);
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"video output : %@", output);
//    CFRetain(sampleBuffer);
    
//    dispatch_async(self.videoWriterQueue, ^{
        //    [self.videoWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
        
//        [self.videoWriterInput appendSampleBuffer:sampleBuffer];
    
//        CFRelease(sampleBuffer);
//    });
    
    switch (self.videoWriter.status) {
        case AVAssetWriterStatusUnknown:
        {
//            dispatch_async(self.videoWriterQueue, ^{
                [self.videoWriter startWriting];
                [self.videoWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
//            });
        }
            break;
        case AVAssetWriterStatusWriting:
        {
//            dispatch_async(self.videoWriterQueue, ^{
            // video recording
            if (self.videoWriterInput.isReadyForMoreMediaData) {
                [self.videoWriterInput appendSampleBuffer:sampleBuffer];
            }
//            });
            
//            dispatch_async(self.audioWriterQueue, ^{
                // audio recording
//            if (self.audioWriterInput.isReadyForMoreMediaData) {
//                [self.audioWriterInput appendSampleBuffer:sampleBuffer];
//            }
//            });
        }
            break;
        case AVAssetWriterStatusCompleted:
            
            break;
        default:
            break;
    }
    
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

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd h:m:s";
    }
    return _dateFormatter;
}

- (void)p_setupVideoWriter {
    NSString *time = [self.dateFormatter stringFromDate:[NSDate date]];
    
    NSString *videoPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    videoPath = [videoPath stringByAppendingString:[NSString stringWithFormat:@"/%@.mp4", time]];
    _videoWriter = [AVAssetWriter assetWriterWithURL:[NSURL fileURLWithPath:videoPath] fileType:AVFileTypeMPEG4 error:nil];
    _videoWriter.shouldOptimizeForNetworkUse = YES;
    
    if ([_videoWriter canAddInput:self.videoWriterInput]) {
        [_videoWriter addInput:self.videoWriterInput];
    }
//    if ([_videoWriter canAddInput:self.audioWriterInput]) {
//        [_videoWriter addInput:self.audioWriterInput];
//    }
    
    self.videoWriterQueue = dispatch_queue_create("com.icetime.camera.video_writer_queue", DISPATCH_QUEUE_SERIAL);
    self.audioWriterQueue = dispatch_queue_create("com.icetime.camera.audio_writer_queue", DISPATCH_QUEUE_SERIAL);
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
