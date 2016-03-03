//
//  UIViewAutoResize.m
//  DemoUIViewRelatedAll
//
//  Created by icetime17 on 16/2/13.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "UIViewAutoResize.h"

#define TagBackUIView 1001

@implementation UIViewAutoResize

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self demo];
    }
    
    NSLog(@"%s", __func__);
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    
    NSLog(@"%s", __func__);
    return self;
}

+ (void)initialize
{
    if (self == [UIView class]) {
    }
    
    NSLog(@"%s", __func__);
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    
    NSLog(@"%s", __func__);
    return self;
}

- (BOOL)canBecomeFirstResponder {
    NSLog(@"%s", __func__);
    return [super canBecomeFirstResponder];
}

- (BOOL)canBecomeFocused {
    NSLog(@"%s", __func__);
    return [super canBecomeFocused];
}


- (void)demo {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    backView.backgroundColor = [UIColor blackColor];
    backView.center = self.center;
    backView.tag = TagBackUIView;
    // 准许子视图自适应
    backView.autoresizesSubviews = YES;
    [self addSubview:backView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    topView.backgroundColor = [UIColor redColor];
    // 设置子视图的适应方式，
    // 宽高可变，即上下左右的间距都不变。
    topView.autoresizingMask =  UIViewAutoresizingFlexibleWidth |   // 宽度可变
                                UIViewAutoresizingFlexibleHeight;   // 高度可变

    // 左上的margin可变，即topView距离backView的右下margin保持不变。
//    topView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin |  // 左margin可变
//                                UIViewAutoresizingFlexibleTopMargin;    // 上margin可变
    
    [backView addSubview:topView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 100, self.frame.size.width, 50)];
    [btn setTitle:@"AutoResize" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionAutoResize:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self addSubview:btn];
}

- (void)actionAutoResize:(UIButton *)sender {
    UIView *backView = [self viewWithTag:TagBackUIView];
    backView.frame = CGRectMake(backView.frame.origin.x - 5, backView.frame.origin.y - 5, backView.frame.size.width + 10, backView.frame.size.height + 10);
}

@end
