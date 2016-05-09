//
//  CollectionViewCell.h
//  DemoContainerView
//
//  Created by Chris Hu on 16/5/6.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnIcon;

@property (nonatomic, strong) IBOutlet UILabel *label;

@end
