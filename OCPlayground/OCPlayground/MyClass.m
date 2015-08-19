//
//  MyClass.m
//  OCPlayground
//
//  Created by zj－db0465 on 15/8/19.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import "MyClass.h"

@implementation MyClass

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithName:(NSString *)name age:(NSInteger)age {
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
    }
    return self;
}

- (void)desc {
    NSLog(@"%@ : %ld", self.name, (long)self.age);
}

- (void)descPerformSelector {
    NSLog(@"%@ : %ld", self.name, (long)self.age);
}

@end
