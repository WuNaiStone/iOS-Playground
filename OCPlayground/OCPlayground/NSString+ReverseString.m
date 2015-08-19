//
//  NSString+ReverseString.m
//  OCPlayground
//
//  Created by zj－db0465 on 15/8/19.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import "NSString+ReverseString.h"

@implementation NSString (ReverseString)

- (NSString *)reversedString {
    NSUInteger len = [self length];
    NSMutableString *returnStr = [NSMutableString stringWithCapacity:len];
    while (len) {
        unichar c = [self characterAtIndex:--len]; // 两个字节
        [returnStr appendString:[NSString stringWithFormat:@"%C", c]];
    }
    return returnStr;
}

@end
