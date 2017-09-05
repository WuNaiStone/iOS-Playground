//
//  ViewUserInfo.m
//  DemoMVVM
//
//  Created by Chris Hu on 2017/9/4.
//  Copyright © 2017年 com.icetime. All rights reserved.
//

#import "ViewUserInfo.h"

@implementation ViewUserInfo

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 200, 30)];
        self.textFieldName.text = @"name";
        [self addSubview:self.textFieldName];
        
        self.textFieldAge = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 30)];
        self.textFieldAge.text = @"age";
        [self addSubview:self.textFieldAge];
        
        self.textFieldCity = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 200, 30)];
        self.textFieldCity.text = @"city";
        [self addSubview:self.textFieldCity];
    }
    return self;
}

@end
