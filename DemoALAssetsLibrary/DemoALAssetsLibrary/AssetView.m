//
//  AssetView.m
//  DemoALAssetsLibrary
//
//  Created by zj－db0465 on 15/11/6.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "AssetView.h"

@implementation AssetView {

    UIImageView *imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBlurBackgroundView];
        [self addGestureRecognizer];
    }
    return self;
}

- (void)addBlurBackgroundView {
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    bgView.backgroundColor = [UIColor blueColor];
    bgView.alpha = 0.2;
    [self addSubview:bgView];
}

- (void)showImage:(UIImage *)image {
    imageView = [[UIImageView alloc] initWithFrame:self.frame];
    imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [self addSubview:imageView];
    
    [UIView animateWithDuration:0.2f animations:^{
        imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

- (void)addGestureRecognizer {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    [self addGestureRecognizer:tapGestureRecognizer];
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeGestureRecognizer];
}

- (void)actionTap:(UIGestureRecognizer *)sender {
    [UIView animateWithDuration:0.2f animations:^{
        imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
