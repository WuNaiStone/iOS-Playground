//
//  AssetsCollectionViewController.m
//  DemoALAssetsLibrary
//
//  Created by zj－db0465 on 15/11/6.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "AssetsCollectionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetsCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic) ALAssetsLibrary *assetsLibrary;
@property (nonatomic) NSMutableArray *assets;

@end

@implementation AssetsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationBar];
    
    [self loadAssets];
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

#pragma mark - <UICollectionViewDataSource>

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
    
    ALAsset *asset = self.assets[indexPath.row];
    imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [cell.contentView addSubview:imageView];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

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


#pragma mark - assets library

- (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t onceToken;
    static ALAssetsLibrary *assetsLibrary = nil;
    dispatch_once(&onceToken, ^{
        assetsLibrary = [[ALAssetsLibrary alloc] init];
    });
    return assetsLibrary;
}

- (void)loadAssets {
    if (!self.assets) {
        self.assets = [[NSMutableArray alloc] init];
    }
    
    if (!self.assetsLibrary) {
        self.assetsLibrary = [self defaultAssetsLibrary];
    }
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            NSLog(@"group: %@", group);
            
            // 封面图片
            UIImage *cover = [[UIImage alloc] initWithCGImage:[group posterImage]];
            
            // 遍历group中的assets
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
                if (asset) {
                    [self.assets addObject:asset];
                    
if (0) {
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
                }
                
                [self.collectionView reloadData];
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
