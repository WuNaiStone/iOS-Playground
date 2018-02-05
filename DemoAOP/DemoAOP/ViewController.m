//
//  ViewController.m
//  DemoAOP
//
//  Created by Chris Hu on 2017/7/24.
//  Copyright © 2017年 com.chris. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


@interface NSMutableArray (Safe)

@end

@implementation NSMutableArray (Safe)

- (void)addObject1:(id)anObject {
    NSLog(@"addObject1 : %@", anObject);
    
    [self addObject:anObject];
}

// 为何这样？看似死循环
// safeAddObject会动态找到safeAddObject的实现, 而其实现已经与addObject1进行了互换.
// 即 [self addObject1:anObj]实际会调用safeAddObject的实现(在这里, 我们添加自定义的方法, 如判空等).
// 而 [self safeAddObject:anObj]实际会调用addObject1的实现(数组真正的addObject方法).
- (void)safeAddObject:(id)anObj {
    NSLog(@"safeAddObject : %@", anObj);
    
    if (anObj) {
        [self safeAddObject:anObj]; // 实际调用的方法实现, 其实是addObject1的实现
    } else {
        NSLog(@"anObj is nil.");
    }
}

- (void)swizzleMethod:(SEL)origSel withMethod:(SEL)newSel {
    Class cls = [self class];
    
    Method origMethod = class_getInstanceMethod(cls, origSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    
    // 首先添加origSel，若该类没有实现origSel但父类实现了，则class_getInstanceMethod会返回父类的方法。
    // 那么method_exchangeImplementations替换的实际上是父类的方法。
    // 而, 这里需要尽可能精确到该类自身的方法.
    // 所以，先添加origSel，
    // 若添加成功(则说明该类之前并未实现origSel方法), 添加后再用class_replaceMethod即可
    // 若未添加成功，即该类已有该方法，直接使用method_exchangeImplementations即可
    if (class_addMethod(cls, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        // 若newSel不存在，则class_addMethod。
        // 若newSel存在，则method_setImplementation。
        class_replaceMethod(cls, newSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@end


@interface UIViewController (Log)

@end

@implementation UIViewController (Log)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        
        SEL origSel = @selector(viewDidAppear:);
        SEL newSel  = @selector(xxx_viewDidAppear:);
        
        Method origMethod = class_getInstanceMethod(cls, origSel);
        Method newMethod  = class_getInstanceMethod(cls, newSel);
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        // ...
        // Method originalMethod = class_getClassMethod(class, originalSelector);
        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(cls, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        
        if (didAddMethod) {
            class_replaceMethod(cls, newSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, newMethod);
        }
    });
}

// 为何这样？看似死循环
// xxx_viewDidAppear会动态找到xxx_viewDidAppear的实现, 而其实现已经与viewDidAppear进行了互换.
// 即 [self viewWillAppear:animated]实际会调用xxx_viewDidAppear的实现(在这里, 我们添加自定义的方法, 如统计等).
// 而 [self xxx_viewDidAppear:animated]实际会调用viewDidAppear的实现(系统真正的调用方法).
- (void)xxx_viewDidAppear:(BOOL)animated {
    [self xxx_viewDidAppear:animated]; // 实际调用的方法实现, 其实是viewDidAppear的实现
    
    NSLog(@"xxx_viewDidAppear");
}

@end



@interface ViewController ()

@property (nonatomic, strong) NSString *tmpStr1;

@end

@implementation ViewController {
    NSString *tmpStr2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"this is ViewController's %s", __func__);
    
    __unused NSString *tmpStr3 = nil;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    [arr swizzleMethod:@selector(addObject1:) withMethod:@selector(safeAddObject:)];
    
    [arr addObject1:@"one"]; // 实际调用的方法实现, 其实是safeAddObject的实现
    
    [arr addObject1:nil];
    
    [arr addObject1:@"two"];
    
    NSLog(@"arr : %@", arr);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"this is ViewController's %s", __func__);
}

- (void)viewDidAppear:(BOOL)animated {  // VC生命周期中实际调用[self viewDidAppear:]的方法实现, 其实是xxx_viewDidAppear的实现
    [super viewDidAppear:animated];
    
    NSLog(@"this is ViewController's %s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
