//
//  CarouselCell.m
//  AirBrush
//
//  Created by Chris Hu on 16/5/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CarouselCell.h"

@interface CarouselCell ()

@end


#define WidthCell   CGRectGetWidth(self.frame)
#define HeightCell  CGRectGetHeight(self.frame)

@implementation CarouselCell {
    
    NSInteger _index; // CarouselCell的index
}

- (instancetype)initWithFrame:(CGRect)frame withIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        _index = index;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self initImageView];
    [self initBtn];
}

- (void)initImageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:_imageView];
        
        _imageView.center = self.center;
        
        _imageView.layer.cornerRadius = 5.0f;
        _imageView.layer.masksToBounds = YES;
        
        _imageView.image = [UIImage imageNamed:@"Model.jpg"];
    }
}

#pragma mark - button

- (void)initBtn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140, 40)];
        [self addSubview:_btn];
        
        _btn.center = self.center;
        [self bringSubviewToFront:_btn];
        
        [_btn setBackgroundColor:[UIColor lightGrayColor]];
        _btn.layer.cornerRadius = 5.0f;
        
        [_btn setTitle:[NSString stringWithFormat:@"Button %ld", (long)_index] forState:UIControlStateNormal];
        
        [_btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)actionBtn:(UIButton *)sender {
    NSLog(@"%s", __func__);
}

@end
