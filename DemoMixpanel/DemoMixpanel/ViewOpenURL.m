//
//  ViewOpenURL.m
//  DemoMixpanel
//
//  Created by Chris Hu on 16/4/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewOpenURL.h"

@implementation ViewOpenURL

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    
    [self showPasteboardString];
    [self showPasteboardImage];
    [self addButtonClose];
    
    return self;
}

- (void)showPasteboardString {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 30)];
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    label.text = pasteboard.string;
}

- (void)showPasteboardImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.center;
    [self addSubview:imageView];

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    imageView.image = pasteboard.image;
}

- (void)addButtonClose {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 50, 0, 50, 30)];
    [btn setTitle:@"Close" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionClose:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self addSubview:btn];
}

- (void)actionClose:(UIButton *)sender {
    [self removeFromSuperview];
}


@end
