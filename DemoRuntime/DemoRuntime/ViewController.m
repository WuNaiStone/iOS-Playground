//
//  ViewController.m
//  DemoRuntime
//
//  Created by Chris Hu on 15/10/1.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

#import "UIControl+CS_FixMultiClick/UIControl+CS_FixMultiClick.h"

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

@implementation ViewController {

    UIButton *btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSObject test]; //先到NSObject的metaclass中找+test，没找到，到其metaclass的superclass（仍然是NSObject自身）的-test方法即可。
    
    [self printRuntime];
    
    [self fixUIButtonClickIssue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Runtime 的基本用法

- (void)printRuntime {
    [self printIvarList];
    [self printPropertyList];
    [self printMethodList];
}

- (void)printIvarList {
    NSLog(@"%s", __func__);
    u_int count = 0;
    // 获取所有成员变量，对于属性会自动生成_成员变量
    Ivar *ivars = class_copyIvarList([UIView class], &count);
    for (int i = 0; i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]); // runtime是用C写的。
        NSString *str = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSLog(@"ivarName : %@", str);
    }
    free(ivars);
}

- (void)printPropertyList {
    NSLog(@"%s", __func__);
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
    NSLog(@"%s", __func__);
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
//        
//        const char *retType = method_copyReturnType(method);
//        if (retType != "@") {
//            str = [NSString stringWithCString:retType encoding:NSUTF8StringEncoding];
//            NSLog(@"returnType : %@", str);
//        }
//        
//        const char *argType = method_copyArgumentType(method, i);
//        if (argType != NULL && argType != "@") {
//            str = [NSString stringWithCString:argType encoding:NSUTF8StringEncoding];
//            NSLog(@"returnType : %@", str);
//        }
    }
    free(methods);
}

#pragma mark - 使用Runtime解决UIButton重复点击问题
#pragma mark -

- (void)fixUIButtonClickIssue {
    NSLog(@"%s", __func__);
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(actionFixMultiClick_performSelector:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
    
    btn.cs_acceptEventInterval = 1;
    [btn addTarget:self action:@selector(btnClickedOperations) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 使用UIButton的enabled来控制

- (void)actionFixMultiClick_enabled:(UIButton *)sender {
    sender.enabled = NO;
    [self btnClickedOperations];
}

- (void)btnClickedOperations {
    self.view.backgroundColor = [UIColor colorWithRed:((arc4random() % 255) / 255.0)
                                                green:((arc4random() % 255) / 255.0)
                                                 blue:((arc4random() % 255) / 255.0)
                                                alpha:1.0f];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"btnClickedOperations");
        btn.enabled = YES;
    });
}

#pragma mark - 使用performSelector来控制

- (void)actionFixMultiClick_performSelector:(UIButton *)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(btnClickedOperations) object:nil];
    
    [self performSelector:@selector(btnClickedOperations) withObject:nil afterDelay:1];
}

#pragma mark - 使用runtime来控制, 见UIButton的CS_FixMultiClick category.

@end
