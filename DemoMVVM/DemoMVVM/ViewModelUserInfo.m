//
//  ViewModelUserInfo.m
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import "ViewModelUserInfo.h"

@implementation ViewModelUserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modelUserInfo = [[ModelUserInfo alloc] init];
    }
    return self;
}

- (void)updateModelFromMockWeb
{
    self.modelUserInfo.name   = @"Chris1";
    self.modelUserInfo.age    = 1;
    self.modelUserInfo.city   = @"Shanghai1";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.modelUserInfo.name   = @"Chris18";
        self.modelUserInfo.age    = 18;
        self.modelUserInfo.city   = @"Shanghai18";
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.modelUserInfo.name   = @"Chris28";
        self.modelUserInfo.age    = 28;
        self.modelUserInfo.city   = @"iloveShanghai28";
    });
}

@end
