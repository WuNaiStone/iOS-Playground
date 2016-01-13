//
//  AView.m
//  DemoScrollViewPageControl
//
//  Created by zj－db0465 on 16/1/13.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "AView.h"

@interface AView () <UIScrollViewDelegate>

@end

@implementation AView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 10, 0);
        scrollView.pagingEnabled = YES;
        scrollView.bounces = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.decelerationRate = 1.0f;
        [self addSubview:scrollView];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_scrollDelegate respondsToSelector:@selector(viewDidScroll)]) {
        [_scrollDelegate viewDidScroll];
    }
}

@end
