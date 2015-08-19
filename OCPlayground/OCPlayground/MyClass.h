//
//  MyClass.h
//  OCPlayground
//
//  Created by zj－db0465 on 15/8/19.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger age;

- (id)initWithName:(NSString *)name age:(NSInteger)age;

- (void)desc;

- (void)descPerformSelector;

@end
