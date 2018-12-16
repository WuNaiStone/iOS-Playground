//
//  ModelUserInfo.m
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import "ModelUserInfo.h"

@implementation ModelUserInfo

- (void)setName:(NSString *)name
{
    _name = name;
    
    NSLog(@"Model name : %@", name);
}

- (void)setAge:(int)age
{
    _age = age;
    
    NSLog(@"Model age : %ld", (long)age);
}

- (void)setCity:(NSString *)city
{
    _city = city;
    
    NSLog(@"Model city : %@", city);
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"name : %@, age : %ld, city : %@", _name, (long)_age, _city];
}

@end
