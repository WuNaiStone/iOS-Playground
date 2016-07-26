//
//  NewsTitleDataSourceManager.h
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TitleCollectionViewCell.h"


#define CellIdentifier @"TitleCollectionViewCell"

@protocol NewsTitleDataSourceManagerDelegate <NSObject>

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface NewsTitleDataSourceManager : NSObject <

    UICollectionViewDataSource,
    UICollectionViewDelegate
>

@property (nonatomic, copy) NSArray<NSString *> *titles;

@property (nonatomic, weak) id<NewsTitleDataSourceManagerDelegate> delegate;

@end
