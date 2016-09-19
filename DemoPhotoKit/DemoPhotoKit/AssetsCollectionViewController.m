//
//  AssetsCollectionViewController.m
//  DemoPhotoKit
//
//  Created by Chris Hu on 15/11/6.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "AssetsCollectionViewController.h"
#import <Photos/Photos.h>
#import "AssetView.h"

@interface AssetsCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSMutableArray *assets;
@property (nonatomic) PHFetchResult *smartAlbums;

@end

@implementation AssetsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self initNavigationBar];
    
    [self loadAssets];
    
    [self createAlbum];
}

- (void)createAlbum {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"MyTestAlbum"];
        
        [PHAssetChangeRequest creationRequestForAssetFromImage:[UIImage imageNamed:@"Model.jpg"]];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
    }];
    // PHAssetCollectionChangeRequest can only be created or used within a -[PHPhotoLibrary performChanges:] or -[PHPhotoLibrary performChangesAndWait:] block.
}

#pragma mark - navigation bar

- (void)initNavigationBar {
    UIBarButtonItem *btnClose = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionBtnClose:)];
    self.navigationItem.leftBarButtonItem = btnClose;
    
    UIBarButtonItem *btnCamera = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(actionBtnCamera:)];
    self.navigationItem.rightBarButtonItem = btnCamera;
}

- (void)actionBtnClose:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionBtnCamera:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - <UICollectionViewDelegateFlowLayout>

// 每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4;
    return CGSizeMake(width, width);
}

// 边缘cell的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4 - 2;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    imageView.backgroundColor = [UIColor redColor];
    
    // 使用PHImageManager从PHAsset中请求图片
    PHImageManager *imageManager = [[PHImageManager alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [imageManager requestImageForAsset:self.assets[indexPath.row]
                                targetSize:CGSizeMake(width, width)
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                NSLog(@"%@", result);
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = result;
                });
            }
        }];
    });
    
    [cell.contentView addSubview:imageView];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4 - 2;
    __weak AssetsCollectionViewController *weakSelf = self;
    
    PHImageManager *imageManager = [[PHImageManager alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [imageManager requestImageForAsset:self.assets[indexPath.row] targetSize:CGSizeMake(width, width) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                NSLog(@"%@", result);
                dispatch_async(dispatch_get_main_queue(), ^{
                    AssetView *assetView = [[AssetView alloc] initWithFrame:self.view.frame];
                    [weakSelf.view addSubview:assetView];
                    [assetView showImage:result];
                    assetView.closeBlock = ^() {
                        NSLog(@"Close AssetView");
                    };
                });
            }
        }];
    });
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - PhotoKit

- (PHFetchResult *)defaultPHFetchResult {
    static dispatch_once_t onceToken;
    static PHFetchResult *smartAlbums = nil;
    dispatch_once(&onceToken, ^{
        // 所有智能相册
        smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    });
    return smartAlbums;
}

- (void)loadAssets {
    if (!self.assets) {
        self.assets = [[NSMutableArray alloc] init];
    }
    
    if (!self.smartAlbums) {
        self.smartAlbums = [self defaultPHFetchResult];
    }
    
    for (NSInteger i=0; i<self.smartAlbums.count; i++) {
        // 获取一个相册PHAssetCollection
        PHCollection *collection = self.smartAlbums[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            // 从一个相册中获取的PHFetchResult中包含的才是PHAsset
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            for (PHAsset *asset in fetchResult) {
                [self.assets addObject:asset];
            }
        } else {
            NSAssert1(NO, @"Fetch collection not PHCollection : %@", collection);
        }
    }
    
    [self.collectionView reloadData];
}

@end
