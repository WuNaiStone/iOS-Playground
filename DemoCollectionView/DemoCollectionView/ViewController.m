//
//  ViewController.m
//  DemoCollectionView
//
//  Created by zj－db0465 on 15/9/16.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#define _CELL "acell"
#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController {
    UICollectionView *collectionView;
    UICollectionViewFlowLayout *layout;
    
    NSInteger sectionCount;
    NSInteger itemCount;
    
    UIButton *btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addCollectionView];
    
    [self addButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButton {
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"ScrollDirectionVertical" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionScrollDirection:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionScrollDirection:(UIButton *)sender {
    layout.scrollDirection = !layout.scrollDirection;
    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        [btn setTitle:@"ScrollDirectionVertical" forState:UIControlStateNormal];
        collectionView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 200);
    } else {
        [btn setTitle:@"ScrollDirectionHorizontal" forState:UIControlStateNormal];
        collectionView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 200);
    }
}

- (void)addCollectionView {
    layout = [[UICollectionViewFlowLayout alloc] init];
    // layout的样式，也可以在UICollectionViewDelegateFlowLayout中设置
    // UICollectionView默认采取纵向排列样式，UICollectionViewScrollDirectionVertical
    // 该样式针对section而言！！！
    // section0为红色，section1为绿色.
    // Vertical: section是vertical放置，而item是horizontal放置。一个section中的item在一行中放置不下，就另起一行往下放置。
    // Horizontal: section是horizontal放置，而item是vertical放置。一个section中的item在一列中放置不下，就另起一列放置。
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];

    collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 200) collectionViewLayout:layout];
    UIView *bgView = [[UIView alloc] initWithFrame:collectionView.frame];
    bgView.backgroundColor = [UIColor blackColor];
    collectionView.backgroundView = bgView;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@_CELL];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    sectionCount = 2;
    itemCount = 3;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@_CELL forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.backgroundColor = [UIColor redColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor blueColor];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 设置section的insets属性，即边距。
    if (section == sectionCount - 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    // 最小行间距
    // vertical：同一个section的上下两行（另起一行）之间的最小间隔
    // horizontal：同一个section的左右两列（另起一列）之间的最小间隔
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    // 最小item间距
    // vertical：一行间水平（horizontal）相邻两个item之间的最小间隔
    // horizontal：一列间上下（vertical）相邻两个item之间的最小间隔
    // 而item之间实际的间隔由UIEdgeInsets及item个数共同决定（各item之间尽量保持相同间距，不够就另起一行）
    return 20.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    // vertical：section的header的height
    // horizontal：section的header的width
    if (section == sectionCount - 1) {
        return CGSizeMake(30, 30);
    }
    return CGSizeMake(10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    // vertical：section的footer的height
    // horizontal：section的footer的width
    if (section == sectionCount - 1) {
        return CGSizeMake(30, 30);
    }
    return CGSizeMake(10, 10);
}

@end
