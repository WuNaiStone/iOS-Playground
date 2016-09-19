//
//  ViewController.m
//  DemoPhotoKit
//
//  Created by Chris Hu on 15/11/2.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "AssetsCollectionViewController.h"
#import "ScrollViewAndCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testPhotoKit];
    [self listAllAlbums];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"选择照片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionLoadAssets:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    [btn1 setTitle:@"Use ScrollView and CollectionView" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(actionUseScrollViewAndCollectionView:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2.0f;
    [self.view addSubview:btn1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testPhotoKit {
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    if (authorizationStatus != PHAuthorizationStatusAuthorized) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    NSLog(@"PHAuthorizationStatusAuthorized");
                    [self listAllAlbums];
                } else {
                    NSLog(@"Not PHAuthorizationStatusAuthorized");
                }
            });
        }];
    }
}

- (void)listAllAlbums {
    PHFetchResult *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                          subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSLog(@"albums : %d", albums.count);
    
    
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                          subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSLog(@"smartAlbums : %d", smartAlbums.count);
    
    
    
    PHFetchResult *momentAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeMoment
                                                                          subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSLog(@"momentAlbums : %d", momentAlbums.count);
    
    
    
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    NSLog(@"topLevelUserCollections : %d", topLevelUserCollections.count);
    PHAssetCollection *myAlbum1 = (PHAssetCollection *)[topLevelUserCollections firstObject];
    for (PHAssetCollection *collection in topLevelUserCollections) {
        PHFetchResult *results = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        NSLog(@"results : %d", results.count);
        for (PHAsset *asset in results) {
//            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//            options.synchronous = YES;
//            options.resizeMode = PHImageRequestOptionsResizeModeExact;
//            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
                [self.view addSubview:imageView];
                imageView.image = result;
            }];
        }
    }
    
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    // 获取所有资源，包括图片和视频
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
//    PHFetchOptions *option = [[PHFetchOptions alloc] init];
//    // 1图片，2视频，3音频
//    option.predicate = [NSPredicate predicateWithFormat:@"self.mediaType==1"];
//    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    // 在资源的集合中获取第一个集合，并获取其中的图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = [assetsFetchResults firstObject];
    NSLog(@"%@, %@", asset.location, asset.localIdentifier);
    
    PHImageRequestID imageRequestID1 = [imageManager requestImageForAsset:asset
                                                              targetSize:CGSizeMake(100, 100)
                                                             contentMode:PHImageContentModeAspectFill
                                                                 options:nil
                                                           resultHandler:^(UIImage *result, NSDictionary *info) {
        NSLog(@"imageRequestID1");
    }];
    
    // 主要用于缓存PHAsset，这样可以快速获取照片或视频。
    [imageManager startCachingImagesForAssets:(NSArray *)assetsFetchResults targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:nil];
    
    
    
    PHImageRequestID imageRequestID2 = [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:CGSizeMake(100, 100)
                                              contentMode:PHImageContentModeAspectFill
                                                  options:nil
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSLog(@"imageRequestID2");
    }];
    
    NSLog(@"Done");
}

- (void)testCamera {
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authorizationStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
        }];
    } else if (authorizationStatus == AVAuthorizationStatusAuthorized) {
        
    } else {
        
    }
}

- (void)loadOnePhoto {
    // 获取所有资源的集合，并按资源创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    // 在资源的集合中获取第一个集合，并获取其中图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = assetsFetchResults[0];
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(300, 200) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSLog(@"%@", result);
    }];
}

- (void)loadPhotos {
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 所有用户创建相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    for (NSInteger i=0; i<smartAlbums.count; i++) {
        // 获取一个相册PHAssetCollection
        PHCollection *collection = smartAlbums[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            // 从一个相册中获取的PHFetchResult中包含的才是PHAsset
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            PHAsset *asset = nil;
            if (fetchResult.count != 0) {
                asset = fetchResult[0];
            }
            
            // 使用PHImageManager从PHAsset中请求图片
            PHImageManager *imageManager = [[PHImageManager alloc] init];
            [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result) {
                    NSLog(@"%@", result);
                }
            }];
        } else {
            NSAssert1(NO, @"Fetch collection not PHCollection: %@", collection);
        }
    }
}

- (void)actionLoadAssets:(UIButton *)sender {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4;
    layout.itemSize = CGSizeMake(width, width);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    AssetsCollectionViewController *assetsCollectionViewController = [[AssetsCollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:assetsCollectionViewController];
    
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
}

- (void)actionUseScrollViewAndCollectionView:(UIButton *)sender {
    ScrollViewAndCollectionViewController *scrollVC = [[ScrollViewAndCollectionViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:scrollVC];
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
}

@end
