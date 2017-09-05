//
//  ViewModelUserInfo.h
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewUserInfo.h"
#import "ModelUserInfo.h"

@interface ViewModelUserInfo : NSObject

@property (nonatomic, strong) ViewUserInfo  *viewUserInfo;
@property (nonatomic, strong) ModelUserInfo *modelUserInfo;

- (void)bind;

@end
