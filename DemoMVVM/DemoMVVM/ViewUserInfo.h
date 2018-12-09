//
//  ViewUserInfo.h
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModelUserInfo.h"

@interface ViewUserInfo : UIView

@property (nonatomic, strong) UITextField *textFieldName;
@property (nonatomic, strong) UITextField *textFieldAge;
@property (nonatomic, strong) UITextField *textFieldCity;

/**
 View持有ViewModel，ViewModel持有Model
 */
//@property (nonatomic, strong) ViewModelUserInfo *viewModelUserInfo;
- (void)bindWithViewModel:(ViewModelUserInfo *)viewModelUserInfo;

@end
