//
//  HowBlockCaptureVariables.m
//  DemoHowBlockCaptureVariables
//
//  Created by Chris Hu on 24/04/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "HowBlockCaptureVariables.h"

@implementation HowBlockCaptureVariables

// 全局变量
int global_var = 1;
id global_obj = nil;

// 静态全局变量
static int static_global_var = 2;
static id static_global_obj = nil;

- (void)myMethod {
    // 基本数据类型的局部变量
    int local_var = 1;
    id local_obj = nil;
    
    // 对象类型的局部变量
    __unsafe_unretained id unsafe_local_obj = nil;
//    __weak id weak_local_obj = nil;
    __strong id strong_local_var = nil;
    
    // 静态的局部变量
    static int static_local_var = 3;
    static id static_local_obj = nil;
    
    void(^MyBlock)(void) = ^{
        NSLog(@"global var basic %d", global_var);
        NSLog(@"global var object %@", global_obj);
        
        NSLog(@"static global var basic %d", static_global_var);
        NSLog(@"static global var object %@", static_global_obj);
        
        NSLog(@"local var basic %d", local_var);
        NSLog(@"local var object %@", local_obj);
        
        NSLog(@"local var object unsafe %@", unsafe_local_obj);
//        NSLog(@"local var object weak %@", weak_local_obj);
        NSLog(@"local var object strong %@", strong_local_var);
        
        NSLog(@"staitc local var basic %d", static_local_var);
        NSLog(@"staitc local var object %@", static_local_obj);
    };
    
    MyBlock();
}

@end
