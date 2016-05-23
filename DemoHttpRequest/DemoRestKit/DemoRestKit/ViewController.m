//
//  ViewController.m
//  DemoRestKit
//
//  Created by icetime17 on 15/9/2.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <RestKit/RestKit.h>
#import "Article.h"

@interface ViewController ()

@property (nonatomic) NSArray *articles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadArticles];
}

- (void)loadArticles {
    NSURL *baseURL = [NSURL URLWithString:@"http://127.0.0.1:5000"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // 使用AFHttpClient来初始化RKObjectManager, 与RESTful services交互
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:httpClient];
    
    // 建立RKObjectMappings, 用于配置JSON与本地Model的映射信息
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[Article class]];
    
    // 解析字段, 有多种方式. 使用addAttributeMappingsFromArray等进行添加
    // [articleMapping addAttributeMappingsFromArray:@[@"title", @"author", @"body"]];
    [articleMapping addAttributeMappingsFromDictionary:@{
                                                         @"title": @"title",
                                                         @"author": @"author",
                                                         @"body": @"body"
                                                         }];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // statuscode: 2xx
    
    // RKResponseDescriptor描述对返回数据的映射信息。
    // register mappings with the provider using a response descriptor
    // pathPattern: 添加到baseURL后面的API路径
    // keyPath: 对象在JSON数据中的路径
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping method:RKRequestMethodGET pathPattern:@"/json" keyPath:@"article" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    
    // 根据RKResponseDescriptor中的配置信息来映射Article对象
    NSDictionary *queryParams = nil;
    // [RKObjectManager sharedManager] 即为objectManager（单例模式）
    [objectManager getObjectsAtPath:@"/json" parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        _articles = mappingResult.array;
        NSLog(@"_articles.count : %ld", _articles.count);
        Article *article = [mappingResult firstObject];
        NSLog(@"article : %@ - %@ - %@", article.title, article.author, article.body);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to get articles...");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
