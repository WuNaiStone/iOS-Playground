//
//  CollectionViewLayout.m
//  DemoCollectionView
//
//  Created by zj－db0465 on 16/1/18.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CollectionViewLayout.h"

@implementation CollectionViewLayout

- (instancetype)initWithType:(LayoutCollectionView)type
{
    self = [super init];
    if (self) {
        self.type = type;
        
        if (type == Layout_DefaultFlow) {
            self = [[UICollectionViewFlowLayout alloc] init];
        }
    }
    return self;
}

// collectionView内容尺寸
- (CGSize)collectionViewContentSize {
    return CGSizeMake(250, 250);
}

@end
