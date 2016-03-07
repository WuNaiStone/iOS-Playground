//
//  ViewController.m
//  DemoRuntime
//
//  Created by zj－db0465 on 15/10/1.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface NSObject (Associate)

+ (void)test;

@end

@implementation NSObject (Associate)

- (void)test {
    NSLog(@"%s", __func__);
}

@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSObject test]; //先到NSObject的metaclass中找+test，没找到，到其metaclass的superclass（仍然是NSObject自身）的-test方法即可。
    
    [self printIvarList];
    [self printPropertyList];
    [self printMethodList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printIvarList {
    u_int count = 0;
    // 获取所有成员变量，对于属性会自动生成_成员变量
    Ivar *ivars = class_copyIvarList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]); // runtime是用C写的。
        NSString *str = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSLog(@"ivarName : %@", str);
    }
}

- (void)printPropertyList {
    u_int count = 0;
    // 获取所有属性
    objc_property_t *properties = class_copyPropertyList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *str = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", str);
    }
    free(properties);
}

- (void)printMethodList {
    u_int count = 0;
    // 获取所有方法
    Method *methods = class_copyMethodList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        // 方法类型是SEL选择器类型
        SEL methodName = method_getName(method);
        NSString *str = [NSString stringWithCString:sel_getName(methodName) encoding:NSUTF8StringEncoding];
        
        int arguments = method_getNumberOfArguments(method);
        NSLog(@"methodName : %@, arguments Count: %d", str, arguments);
    }
    free(methods);
}

@end
