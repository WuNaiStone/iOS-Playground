//
//  DemoURLRequestViewController.m
//  DemoRAC
//
//  Created by Chris Hu on 07/04/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "DemoURLRequestViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface DemoURLRequestViewController ()

@end

@implementation DemoURLRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    [[self setupRAC] subscribeNext:^(id  _Nullable x) {
        NSLog(@"json: %@", x);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // UI
//        });
    } error:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error);
    } completed:^{
        NSLog(@"completed");
    }];
     */
    
    RACSignal *s1 = [self setupRAC];
    RACSignal *s2 = [self setupRAC];
    RACSignal *s3 = [self setupRAC];
    
    // 注意merge, combineLatest, concat, then的区别...
//    [[s1 merge:s2] merge:s3]; // 三个信号量合并, 有一个发送消息即执行订阅者的任务
    
    // s1的信号量执行完毕(sendCompleted之后), 再执行s2.
    // 但仅返回最后一个信号量的数据
    [[[s1 then:^RACSignal * _Nonnull{
        return s2;
    }] then:^RACSignal * _Nonnull{
        return s3;
    }] subscribeNext:^(id  _Nullable x) {
        // s3信号量执行完之后调用
        // 此处的x只有s3的数据
    }];
    
    // 串行执行s1,s2, 且s1, s2的数据都会返回.
    [[s1 concat:s2] subscribeNext:^(id  _Nullable x) {
        // s1, s2的数据都会返回.
    }];
    
    [[RACSignal combineLatest:@[s1, s2, s3]] subscribeNext:^(RACTuple * _Nullable x) {
        // 三个信号量都执行并返回结果时, 才去执行订阅者的任务
    }];
    
    [self testPullAndPush];
}

- (RACSignal *)setupRAC {
    NSString *urlStr = @"https://api.github.com/";
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlStr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                NSError *err;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
                if (err) {
                    [subscriber sendError:error];
                } else{
                    [subscriber sendNext:json];
                    [subscriber sendCompleted];
                }
            }
        }];
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (void)testPullAndPush {
    // pull/push驱动
    [self testPull];
    [self testPush];
}

- (void)testPull {
    __block int a = 10;
    RACSignal *signalPull = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // pull:
        // 在没有人通过subscribeNext订阅该信号量之前, 此处的block是不会执行的. 所以视为pull驱动
        // 即: 有人订阅才发送信号.
        // 副作用: 每次订阅时, 可能导致block中的代码重复执行.
        // 通过添加replayLast可以消除副作用, 仅记录旧的signal返回的值, 而不会重复执行block.
        a += 5;
        
        [subscriber sendNext:@(a)];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }] replayLast];
    [signalPull subscribeNext:^(id  _Nullable x) {
        NSLog(@"a: %@", x); // 15
    }];
    [signalPull subscribeNext:^(id  _Nullable x) {
        NSLog(@"a: %@", x); // 20, 重复执行了.(pull驱动的副作用). 若添加replayLast, 则15
    }];
    
    
    RACSequence *sequence = [signalPull sequence];
    [sequence signal];
}

- (void)testPush {
    // push:
    // 队列在初始化的时候其内容就已经形成了, 而非pull驱动的那种(在订阅时才生成内容)
    NSArray *arr = @[@(1), @(2), @(3), @(4), @(5)];
    RACSequence *seq = [arr rac_sequence];
    [seq array];
    
    NSLog(@"%@", [[seq map:^id _Nullable(id  _Nullable value) {
        return @([value integerValue] * 3);
    }] array]); // 3,6,9,12,15
    
    NSLog(@"%@", [[seq filter:^BOOL(id  _Nullable value) {
        return [value integerValue] % 2 == 0;
    }] array]); // 2,4
    
    // flattenMap是先做map操作, 再做flatten操作
    NSArray *arr2 = @[@(5), @(10), @(11)];
    NSLog(@"%@", [[[@[[arr rac_sequence], [arr2 rac_sequence]] rac_sequence] flattenMap:^__kindof RACSequence * _Nullable(id  _Nullable value) {
        NSLog(@"%@", [value array]);
        return [value filter:^BOOL(id  _Nullable value) {
            return [value integerValue] % 2 == 1;
        }];
    }] array]); // 1,3,5,5,11
}

@end
