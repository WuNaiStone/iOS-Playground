//
//  ViewController.m
//  DemoALAssetsLibrary
//
//  Created by zj－db0465 on 15/11/2.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadAssets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAssets {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            NSLog(@"group: %@", group);
            
            // 封面图片
            UIImage *cover = [[UIImage alloc] initWithCGImage:[group posterImage]];
            
            // 遍历group中的assets
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
                if (asset) {
                    NSLog(@"\nasset: %@", asset);
                    NSLog(@"ALAssetPropertyAssetURL : %@", [asset valueForProperty:ALAssetPropertyAssetURL]);
                    
                    UIImage *image = [[UIImage alloc] initWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                    
                    // url
                    NSString *url = [[[asset defaultRepresentation] url] absoluteString];
                    NSLog(@"url: %@", url);
                    
                    UIImage *thumbnail = [[UIImage alloc] initWithCGImage:[asset thumbnail]];
                    
                    UIImage *aspectRatioThumbnail = [[UIImage alloc] initWithCGImage:[asset aspectRatioThumbnail]];
                    
                    // 每个ALAsset都可能有多个representation表示, 即ALAssetRepresentation对象.
                    // 获取所有representations的UTI数组
                    NSArray *utiArrays = [NSArray arrayWithObject:[asset valueForProperty:ALAssetPropertyRepresentations]];
                    NSLog(@"utiArrays : %@", utiArrays);
                    
                    // 全尺寸图
                    UIImage *fullResolutionImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                    
                    // 全屏图
                    UIImage *fullScreenImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                    
                    // 创建时间
                    NSString *createTime = (NSString *)[asset valueForProperty:ALAssetPropertyDate];
                    NSLog(@"createTime : %@", createTime);
                    
                    // 拍摄位置
                    NSString *createLocation = (NSString *)[asset valueForProperty:ALAssetPropertyLocation];
                    NSLog(@"createLocation : %@", createLocation);
                    
                    // 尺寸
                    CGSize dimensions = [[asset defaultRepresentation] dimensions];
                    NSLog(@"dimensions : %f - %f", dimensions.width, dimensions.height);
                }
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
