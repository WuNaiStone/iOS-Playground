//
//  main.m
//  OCPlayground
//
//  Created by zj－db0465 on 15/8/19.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ReverseString.h"
#import "MyClass.h"

#pragma mark - NSString

void testNSStringCompare() {
    /*
    typedef NS_ENUM(NSInteger, NSComparisonResult) {
        NSOrderedAscending = -1L,  // 前后两个字符串的比较结构符合人的思维理解
        NSOrderedSame, 
        NSOrderedDescending
    };
    
    #if NS_BLOCKS_AVAILABLE
        typedef NSComparisonResult (^NSComparator)(id obj1, id obj2);
    #endif
    */
    NSLog(@"%d", [@"abc" isEqualToString:@"a"]);    // 0
    NSLog(@"%d", [@"a" isEqualToString:@"a"]);      // 1
    
    NSLog(@"%ld", (long)[@"a" compare:@"abc"]);     // -1
    NSLog(@"%ld", (long)[@"a" compare:@"a"]);       // 0
    NSLog(@"%ld", (long)[@"abc" compare:@"a"]);     // 1
    NSLog(@"%ld", (long)[@"abc" compare:@"abd"]);   // -1
    NSLog(@"%ld", (long)[@"abc" compare:@"bbc"]);   // -1
    NSLog(@"%ld", (long)[@"100" compare:@"99"]);    // -1
    NSLog(@"%ld", (long)[@"100" compare:@"99" options:NSNumericSearch]); // 1
}

#pragma mark - Category

void testNSStringReverseCategory() {
    NSString *str = @"hello world";
    NSString *reversedStr = [str reversedString];
    NSLog(@"%@", str);
    NSLog(@"%@", reversedStr);
}

#pragma mark - NSUserDefaults

void testNSUserDefaults() {
//    [[NSUserDefaults standardUserDefaults] setObject:@"Chris" forKey:@"name"];
    NSDictionary *registerDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"forever",   @"name",
                                      @"mac",       @"os",
                                      @"google",    @"search",
                                      @YES,         @"bool",
                                      nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:registerDefaults];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"name"]);
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"os"]);
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"search"]);
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"bool"]);
}

#pragma mark - NSLocale

void testNSLocale() {
    NSArray *languages = [NSLocale preferredLanguages];
    NSLog(@"%@", languages);
    NSString *curLanguage = languages[0];
    NSLog(@"%@", curLanguage);
    
    NSLog(@"%@", [[NSBundle mainBundle] localizedInfoDictionary]);
    NSLog(@"%@", [[NSBundle mainBundle] localizations]);
}

#pragma mark - PerformSelector

void testPerformSelector() {
    MyClass *myObj = [[MyClass alloc] initWithName:@"chris" age:28];
    [myObj desc];
    if ([myObj respondsToSelector:@selector(descPerformSelector)]) {
        [myObj performSelector:@selector(descPerformSelector)]; // 调用时不在.h文件中声明也不会出错.
//        [myObj performSelector:@selector(descPerformSelectorNotExisted)]; // 编译时不做校验,而运行出错.
    }
}

#pragma mark - main

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testNSStringCompare();
        testNSStringReverseCategory();
        testNSUserDefaults();
        testNSLocale();
        testPerformSelector();
    }
    return 0;
}
