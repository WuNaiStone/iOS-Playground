//
//  User.h
//  DemoDependencyInjection
//
//  Created by zj－db0465 on 14/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *city;

- (instancetype)initWithName:(NSString *)name
                         age:(NSInteger)age
                        city:(NSString *)city;

@end
