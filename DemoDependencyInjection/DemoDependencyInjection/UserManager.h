//
//  UserManager.h
//  DemoDependencyInjection
//
//  Created by zj－db0465 on 14/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

@property (nonatomic, strong) User *curUser;

+ (instancetype)sharedInstance;

@end
