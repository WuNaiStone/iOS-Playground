//
//  UserManager.m
//  DemoDependencyInjection
//
//  Created by zj－db0465 on 14/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (instancetype)sharedInstance {
    static UserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserManager alloc] init];
    });
    return sharedInstance;
}

- (void)setCurUser:(User *)curUser {
    _curUser = curUser;
    
    // cache user's thumbnail
}

@end
