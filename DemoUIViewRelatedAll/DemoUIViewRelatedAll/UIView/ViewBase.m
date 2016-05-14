//
//  ViewBase.m
//  DemoUIViewRelatedAll
//
//  Created by Chris Hu on 16/4/6.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewBase.h"

@implementation ViewBase

- (instancetype)init
{
    self = [super init];
    NSLog(@"%s", __func__);
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    NSLog(@"%s", __func__);
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    NSLog(@"%s", __func__);
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
