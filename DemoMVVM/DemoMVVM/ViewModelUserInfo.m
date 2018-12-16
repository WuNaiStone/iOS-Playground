//
//  ViewModelUserInfo.m
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import "ViewModelUserInfo.h"

@interface ViewModelUserInfo ()

@property (nonatomic, strong) ModelUserInfo *modelUserInfo;

@end

@implementation ViewModelUserInfo

- (void)bindWithModel:(ModelUserInfo *)modelUserInfo {
    _modelUserInfo = modelUserInfo;
}

- (void)updateModelFromMockWeb
{
    self.name   = @"Chris 1";
    self.age    = 1;
    self.city   = @"Shanghai 1";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.name   = @"Chris 18";
        self.age    = 18;
        self.city   = @"Shanghai 18";
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.name   = @"Chris 28";
        self.age    = 28;
        self.city   = @"iloveShanghai 28";
    });
}

// MARK: - getters & setters

- (NSString *)name {
    return [NSString stringWithFormat:@"ViewModel's %@", _modelUserInfo.name];
}

- (void)setName:(NSString *)name {
    _modelUserInfo.name = name;
}

- (int)age {
    return _modelUserInfo.age;
}

- (void)setAge:(int)age {
    _modelUserInfo.age = age;
}

- (NSString *)city {
    return [NSString stringWithFormat:@"ViewModel's %@", _modelUserInfo.city];
}

- (void)setCity:(NSString *)city {
    _modelUserInfo.city = city;
}

@end
