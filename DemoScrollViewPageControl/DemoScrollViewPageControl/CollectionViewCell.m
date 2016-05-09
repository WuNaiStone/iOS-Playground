//
//  CollectionViewCell.m
//  DemoScrollViewPageControl
//
//  Created by Chris Hu on 16/5/9.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self bringSubviewToFront:self.btn];
}

- (IBAction)actionBtn:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}


@end
