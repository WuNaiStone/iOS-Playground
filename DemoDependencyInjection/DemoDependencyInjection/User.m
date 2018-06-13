//
//  User.m
//  DemoDependencyInjection
//
//  Created by zj－db0465 on 14/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithName:(NSString *)name
                         age:(NSInteger)age
                        city:(NSString *)city
{
    self = [super init];
    if (self) {
        self.name = name;
        self.age = age;
        self.city = city;
    }
    return self;
}

@end
