//
//  ViewController.m
//  DemoARC
//
//  Created by Chris Hu on 28/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"

/**
 MRC下如何实现setter方法:
 完全遵循内存管理的原则: 先对原来的实例变量进行release, 再对传递尽量的obj进行retain, 最后赋值给实例变量.
 
 - (void)setObj:(NSObject *)obj {
    if (![_obj isEqual obj]) {
        [_obj release];
        _obj = [obj retain];
    }
 }
 
 */

@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController {
    __weak NSString *weakStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *hello = @"hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohello";
    
    // 1: hello, hello, null
    /**
     放到当前最近的autoreleasepool中, 该pool一直到viewWillAppear:结束时都未被drain.
     而在viewDidAppear中, 该pool已经drain, 即runloop已经开始了下一次迭代周期.
     在viewWillAppear与viewDidAppear之间, 调用AutoreleasePoolPage::pop方法对该pool中的autorelease对象进行释放.
     runloop的每个迭代开始时, 会自动创建一个autoreleasepool, 在迭代结束后执行drain. 而主线程自动开启了runloop.
     */
//    NSString *str = [NSString stringWithFormat:@"%@", hello];
//    weakStr = str;
    
    // 2: null, null, null
    /**
     str在自定义的一个autoreleasepool中, 脱离了该pool的作用域范围, 即被释放掉: 即出了}的范围, 就被释放掉了.
     */
//    @autoreleasepool {
//        NSString *str = [NSString stringWithFormat:@"%@", hello];
//        weakStr = str;
//    }
    
    // 3: hello, null, null
    /**
     该str是编译器自动插入ARC内存管理代码, 所以出了当前作用域str就被释放了
     当前作用域可以理解为当前的一个autoreleasepool或者类似的东西, 出该作用域的时候进行drain.
     这里, 也说明了autoreleasespool其实跟runloop没有直接关系.
     即如果有runloop, 则在runloop的迭代结束时drain(如viewDidLoad和viewWillAppear在同一个迭代中)
     如果没有runloop, 则可以理解为在当前作用域自动有一个autoreleasepool, 出了该作用域的时候drain.
     */
//    NSString *str = nil;
//    @autoreleasepool {
//        str = [NSString stringWithFormat:@"%@", hello];
//        weakStr = str;
//    }
    
    // 4: hello, null, null
    /**
     该str是编译器自动插入ARC内存管理代码, 所以出了当前作用域str就被释放了.
     weak_clear_no_lock
     weak_entry_for_referent
     weak_entry_remove
     */
    NSString *str = [[NSString alloc] initWithFormat:@"%@", hello];
    weakStr = str;
    
    NSLog(@"viewDidLoad : %@", weakStr);
    
    [self.view addSubview:self.btn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear : %@", weakStr);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear : %@", weakStr);
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
        _btn.backgroundColor = [UIColor blackColor];
        [_btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)actionBtn:(UIButton *)sender {
    NSLog(@"actionBtn : %@", weakStr);
    [weakStr stringByAppendingString:@"123"];
}
@end
