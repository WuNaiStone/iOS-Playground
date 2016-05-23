## DemoHttpRequest

Demo for iOS HTTP Request.

### Reachability
```
NSLog(@"isReachable : %d", [Reachability reachabilityForInternetConnection].isReachable);
NSLog(@"isReachableViaWiFi : %d", [Reachability reachabilityForInternetConnection].isReachableViaWiFi);
NSLog(@"isReachableViaWWAN : %d", [Reachability reachabilityForInternetConnection].isReachableViaWWAN);

NSLog(@"currentReachabilityStatus : %d", [[Reachability reachabilityForInternetConnection] currentReachabilityStatus]);

real = YES;
if (real) {
    [[RealReachability sharedInstance] startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(realReachabilityChanged:) name:kRealReachabilityChangedNotification object:nil];
} else {
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [reachability startNotifier];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}
```

### NSURLSession
```
NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URL_JSON]];
NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSLog(@"response : %@", response);

    NSError *jsonError;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
    NSLog(@"jsonData : %@", jsonData);
}];
[dataTask resume];
```

### AFNetworking
```
NSURL *url = [NSURL URLWithString:URL_JSON];
AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
[manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"JSON: %@", responseObject);
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"Error : %@", error.description);
}];
```
请参考博客:[iOS --- 强大的网络通信类库AFNetworking](http://blog.csdn.net/icetime17/article/details/41294935)

### RestKit
```
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
```
请参考博客:[iOS --- 使用RestKit与RESTful web服务器进行简单交互](http://blog.csdn.net/icetime17/article/details/48260695)
