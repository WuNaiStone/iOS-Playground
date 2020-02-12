//
//  ViewController.m
//  DemoRunloop
//
//  Created by hyx on 2020/2/12.
//  Copyright © 2020 icetime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSThread *thread2;
@property (nonatomic, strong) NSThread *thread3;
@property (nonatomic, strong) NSThread *thread4;

@property (nonatomic, assign) CFTimeInterval pingTimestamp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.greenColor;
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"thread %@", [NSThread currentThread]);
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
//    [[NSRunLoop currentRunLoop] performBlock:^{
//        NSLog(@"thread performBlock %@", [NSThread currentThread]);
//    }];
//    [[NSRunLoop currentRunLoop] performInModes:@[NSRunLoopCommonModes] block:^{
//        NSLog(@"thread performInModes %@", [NSThread currentThread]);
//    }];

    
//    [self addBackgroundRunLoop1];
//    [self addBackgroundRunLoop2];
//    [self addBackgroundRunLoop3];
    [self addBackgroundRunLoop4];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        sleep(10);
//    });
}

/// 线程保活
- (void)addBackgroundRunLoop1 {
    self.thread1 = [[NSThread alloc] initWithBlock:^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"%@", self.thread1.name);
            dispatch_async(dispatch_get_main_queue(), ^{
                /// 如果一段时间未打印，则可以判断主线程卡顿了。
                NSLog(@"main is ok.");
                self.pingTimestamp = CACurrentMediaTime();
            });
        }];
        // 线程存活，需要添加一个source1。一般是Timer或一个空的port
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run]; /// 会一直卡在这里不会继续往下走。
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
        
        // 后续的永远不会执行。
        NSLog(@"thread runloop");
    }];
    self.thread1.name = @"addBackgroundRunLoop1";
    [self.thread1 start];
}

- (void)addBackgroundRunLoop2 {
    /*
     AFN 2.x中使用了常驻子线程，在AFURLConnectionOperation.m文件中。
     AFURLConnectionOperation的start方法中，将operationDidStart方法丢在子线程networkRequestThread中执行。
     [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
     在operationDidStart方法中：
     self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
     [self.connection scheduleInRunLoop:runLoop forMode:runLoopMode];
     [self.connection start];
     这样，即做到了在子线程中发起网络请求和数据解析。而子线程一直常驻，不会停止。
     NSURLConnection发起的网络请求，需要在AFURLConnectionOperation中，自行进行请求处理和数据解析。
     
     AFN 3.x中移除了该常驻线程，使用的时候run，结束的时候stop即可。因为NSURLSession自己维护了一个线程池，做request线程的调度和管理。不在需要在当前线程中进行请求和数据解析，可以指定回调的delegateQueue了。
     */
    self.thread2 = [[NSThread alloc] initWithBlock:^{
        // 线程存活，需要添加一个source1。一般是Timer或一个空的port
        // addPort然后run，该线程才能一直存活。
        // addPort仅能通过removePort来移除
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
    self.thread2.name = @"addBackgroundRunLoop2";
    [self.thread2 start];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self performSelector:@selector(onTimerInBackgroundRunLoop2) onThread:self.thread2 withObject:nil waitUntilDone:NO];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)onTimerInBackgroundRunLoop2 {
    NSLog(@"%@", self.thread2.name);
}

- (void)addBackgroundRunLoop3 {
    /*
     推荐方式：添加一个BOOL开关来控制。
     BOOL shouldKeepRunning = YES;        // global
     NSRunLoop *rl = [NSRunLoop currentRunLoop];
     while (shouldKeepRunning && [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
     */
    __block BOOL shouldKeepRunning = YES;
    self.thread3 = [[NSThread alloc] initWithBlock:^{
        // 线程存活，需要添加一个source1。一般是Timer或一个空的port
        // addPort然后run，该线程才能一直存活。
        // addPort仅能通过removePort来移除
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        while (shouldKeepRunning) {
            @autoreleasepool {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }
    }];
    self.thread3.name = @"addBackgroundRunLoop3";
    [self.thread3 start];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self performSelector:@selector(onTimerInBackgroundRunLoop3) onThread:self.thread3 withObject:nil waitUntilDone:NO];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        shouldKeepRunning = NO;
    });
}
- (void)onTimerInBackgroundRunLoop3 {
    NSLog(@"%@", self.thread3.name);
}

- (void)addBackgroundRunLoop4 {
    /*
     CFRunLoopRun与CFRunLoopStop
     [[NSRunLoop currentRunLoop] run]方法对应的runloop无法停止。
     若需要停止，则只能使用runMode:beforeDate
     */
    self.thread4 = [[NSThread alloc] initWithBlock:^{
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        CFRunLoopRun();
        //CFRunLoopStop(CFRunLoopGetCurrent());
    }];
    self.thread4.name = @"addBackgroundRunLoop4";
    [self.thread4 start];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self performSelector:@selector(onTimerInBackgroundRunLoop4) onThread:self.thread4 withObject:nil waitUntilDone:NO];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)onTimerInBackgroundRunLoop4 {
    NSLog(@"%@", self.thread4.name);
}

@end
