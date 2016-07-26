//
//  NewsTitleDataSourceManager.m
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "NewsTitleDataSourceManager.h"

@implementation NewsTitleDataSourceManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titles = @[
                        @"头条",
                        @"上海",
                        @"互联网",
                        @"科技",
                        @"体育",
                        @"汽车",
                        @"教育",
                        @"游戏",
                        @"娱乐",
                        @"视频",
                        @"图片",
                        @"笑话",
                        ];
    }
    return self;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (TitleCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TitleCollectionViewCell *cell = (TitleCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.label.text = _titles[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectItemAtIndexPath:)]) {
        [_delegate didSelectItemAtIndexPath:indexPath];
    }

}

#pragma mark - <UICollectionViewDelegateFlowLayout>

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(64, 64);
//}

@end
