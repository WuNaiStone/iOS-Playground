//
//  ScrollViewAndCollectionViewController.m
//  DemoPhotoKit
//
//  Created by Chris Hu on 15/11/9.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ScrollViewAndCollectionViewController.h"
#import <Photos/Photos.h>

@interface ScrollViewAndCollectionViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) NSMutableArray *assets;
@property (nonatomic) PHFetchResult *smartAlbums;

@property (nonatomic) NSIndexPath *lastSelectedIndexPath;
@end

@implementation ScrollViewAndCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initNavigationBar];
    
    [self loadAssets];
    
    [self initCollectionView];
    [self initScrollView];
    [self setInitImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = self.view.frame.size.width / 4;
    layout.itemSize = CGSizeMake(width, width);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - width, self.view.frame.size.width, width) collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    _collectionView.backgroundColor = [UIColor greenColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
}

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:
                   CGRectMake(0, 26, self.view.frame.size.width, self.view.frame.size.height - _collectionView.frame.size.height - 26 - 1)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    NSInteger count = 3;
    for (NSInteger i = 0; i<count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(_scrollView.frame.size.width * i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 100 + i;
        [_scrollView addSubview:imageView];
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * count, _scrollView.frame.size.height);
}

- (void)setInitImage {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self collectionView:_collectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

// 每个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.frame.size.width / 4;
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.frame.size.width / 4 - 2;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    imageView.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:imageView];
    
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
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_lastSelectedIndexPath == indexPath) {
        return;
    }
    _lastSelectedIndexPath = indexPath;
    
    [self didSelectItemAtIndexPath:indexPath];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self updateScrollViewAsset:self.assets[indexPath.row] AtTag:100];
        [self updateScrollViewAsset:self.assets[indexPath.row + 1] AtTag:101];
    } else if (indexPath.row == self.assets.count) {
        [self updateScrollViewAsset:self.assets[indexPath.row - 1] AtTag:101];
        [self updateScrollViewAsset:self.assets[indexPath.row] AtTag:102];
    } else {
        [self updateScrollViewAsset:self.assets[indexPath.row - 1] AtTag:100];
        [self updateScrollViewAsset:self.assets[indexPath.row] AtTag:101];
        [self updateScrollViewAsset:self.assets[indexPath.row + 1] AtTag:102];
    }
}

- (void)updateScrollViewAsset:(PHAsset *)asset AtTag:(NSInteger)tag {
    PHImageManager *imageManager = [[PHImageManager alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [imageManager requestImageForAsset:asset targetSize:_scrollView.frame.size contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                NSLog(@"%@", result);
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (UIView *view in _scrollView.subviews) {
                        if ([view isKindOfClass:[UIImageView class]] && view.tag == tag) {
                            ((UIImageView *)view).image = result;
                        }
                    }
                });
            }
        }];
    });
}

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
