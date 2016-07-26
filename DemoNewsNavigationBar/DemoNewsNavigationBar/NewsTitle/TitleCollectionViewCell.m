//
//  TitleCollectionViewCell.m
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    
    self.label.layer.cornerRadius = 10;
    self.label.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.label.backgroundColor = [UIColor orangeColor];
    } else {
        self.label.backgroundColor = [UIColor clearColor];
    }
}


@end
