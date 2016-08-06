//
//  ViewController.m
//  DemoInsGPUImageFilter
//
//  Created by Chris Hu on 16/8/6.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewController.h"

#import <GPUImage/GPUImage.h>

#import "IFImageFilter.h"

@interface ViewController ()

@end

@implementation ViewController {

    NSArray<Class>* instagramFilters;
    
    NSInteger _filterIndex;
    
    GPUImagePicture *gpuImagePicture;
    
    GPUImageView *gpuImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    gpuImageView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:gpuImageView];
    
    UIImage *inputImage = [UIImage imageNamed:@"Model.jpg"];
    gpuImagePicture = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    instagramFilters = [IFImageFilter allFilterClasses];
    _filterIndex = 0;
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(actionTimer:) userInfo:nil repeats:YES];
}

- (void)actionTimer:(NSTimer *)sender {
    [gpuImagePicture removeAllTargets];
    
    NSInteger index = _filterIndex++ % instagramFilters.count;
    
    // OC中的写法与Swift很不一样.
    // Swift:   let filter = (instagramFilters[index] as! IFImageFilter.Type).init()
    IFImageFilter *filter = [[[instagramFilters objectAtIndex:index] alloc] init];
    [filter addTarget:gpuImageView];
    
    [gpuImagePicture addTarget:filter];
    
    [filter useNextFrameForImageCapture];
    
    [gpuImagePicture processImage];
    
    UIImage *filteredImage = [filter imageFromCurrentFramebuffer];
    
    // imageByFilteringImage与以上方式不能共用.
    // GPUImagePicture ---> IFImageFilter ---> GPUImageView
    /*
    UIImage *filteredImage2 = [filter imageByFilteringImage:[UIImage imageNamed:@"Model.jpg"]];
    */
     
    NSLog(@"%@", [[filter class] description]);
}

@end
