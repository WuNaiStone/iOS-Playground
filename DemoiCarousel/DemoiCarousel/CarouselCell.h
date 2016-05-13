//
//  CarouselCell.h
//  AirBrush
//
//  Created by Chris Hu on 16/5/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselCell : UIView

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIButton *btn;

- (instancetype)initWithFrame:(CGRect)frame withIndex:(NSInteger)index;

@end
