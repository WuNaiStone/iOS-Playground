//
//  ViewModelUserInfo.h
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelUserInfo.h"

@interface ViewModelUserInfo : NSObject

@property (nonatomic, strong) ModelUserInfo *modelUserInfo;

/**
 模拟服务端等对Model进行修改
 */
- (void)updateModelFromMockWeb;

@end
