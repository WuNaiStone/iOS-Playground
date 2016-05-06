//
//  ContainerCollectionViewController.m
//  DemoContainerView
//
//  Created by Chris Hu on 16/5/5.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ContainerCollectionViewController.h"
#import "CollectionViewCell.h"
#import "ItemViewController.h"

@interface ContainerCollectionViewController () <
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *items;

@end

@implementation ContainerCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.bounces = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.items = @[@"美食",
                  @"西餐",
                  @"电影",
                  @"丽人",
                  @"酒店",
                  @"周边游",
                  @"休闲",
                  @"购物",
                  @"折扣",
                  @"更多"
                  ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (CollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *iconName = self.items[indexPath.item];
    cell.label.text = iconName;
    cell.imageView.image = [UIImage imageNamed:iconName];
    
//    cell.label.text = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemViewController *itemVC = [[ItemViewController alloc] init];
    
    itemVC.name = self.items[indexPath.item];
    
//    itemVC.name = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.item];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:itemVC];
    [self presentViewController:nav animated:YES completion:nil];
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

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    // 每一个section中的每一行（列）之间的间隔
    // vertical：同一个section的上下两行（另起一行）之间的最小间隔
    // horizontal：同一个section的左右两列（另起一列）之间的最小间隔
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    // 每一个section中的每一行之间的间隔
    // vertical：一行间水平（horizontal）相邻两个item之间的最小间隔
    // horizontal：一列间上下（vertical）相邻两个item之间的最小间隔
    // 而item之间实际的间隔由UIEdgeInsets及item个数共同决定（各item之间尽量保持相同间距，不够就另起一行）
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

@end
