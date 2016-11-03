//
//  ViewController.m
//  DemoWebImageCache
//
//  Created by Chris Hu on 16/11/2.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "AppModel.h"

static NSString *const imageURLs = @"https://raw.githubusercontent.com/lcy237777480/FYLoadImage/master/apps.json";


@interface ViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@end


@implementation ViewController
{
//    __block NSMutableArray<AppModel *> *_appsList;
    NSArray *_urls;
    
    UITableView *_tableView;
    
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadJsonData];
    
    [self initOperationQueue];
    
    [self initTableView];
}

- (void)loadJsonData
{
    _urls = @[
            @"http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png",
            @"http://p19.qhimg.com/dr/48_48_/t0101e2931181bb540d.png",
            @"http://p17.qhimg.com/dr/48_48_/t012d281e8ec8e27c06.png",
            @"http://p18.qhimg.com/dr/48_48_/t0184f949337481f071.png",
            @"http://p17.qhimg.com/dr/48_48_/t015f10076f95e27e74.png",
            @"http://p16.qhimg.com/dr/48_48_/t01885f5596e1d30172.png",
            @"http://p19.qhimg.com/dr/48_48_/t0164ad383c622aabef.png",
            @"http://p17.qhimg.com/dr/48_48_/t017bc3cfcf3981b197.png",
            @"http://p18.qhimg.com/dr/48_48_/t012fea7312194537c2.png",
            @"http://p18.qhimg.com/dr/48_48_/t01e61cbba53fb9eb82.png",
            @"http://p18.qhimg.com/dr/48_48_/t0108c33d3321352682.png",
            @"http://p17.qhimg.com/dr/48_48_/t01077fd80ffb5c8740.png",
            @"http://p17.qhimg.com/dr/48_48_/t01f55acd4a3ed024eb.png",
            @"http://p16.qhimg.com/dr/48_48_/t018f89d6e0922f75a1.png",
            @"http://p0.qhimg.com/dr/48_48_/t0183a670f1dbff380f.png",
            @"http://p16.qhimg.com/dr/48_48_/t01c3f62a27c3de7af5.png",
              ];
    
//    _appsList = [NSMutableArray array];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager GET:imageURLs parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (obj) {
//                AppModel *model = [[AppModel alloc] init];
//                model.name = [[obj objectForKey:@"name"] string];
//                model.download = [[obj objectForKey:@"download"] string];
//                model.icon = [[obj objectForKey:@"icon"] string];
//                [_appsList addObject:model];
//            }
//        }];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"fail");
//    }];
}

- (void)initOperationQueue
{
    _queue = [[NSOperationQueue alloc] init];
    
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _appsList.count;
    return _urls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
//    AppModel *model = [_appsList objectAtIndex:indexPath.row];
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon]];
    
    
    cell.textLabel.text = _urls[indexPath.row];
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_urls[indexPath.row]]];
//    cell.imageView.image = [UIImage imageWithData:imageData];

    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_urls[indexPath.row]]];
        UIImage *image = [UIImage imageWithData:imageData];
        
        // 主线程的queue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.imageView.image = image;
        }];
    }];
    
    // 自定义的queue
    [_queue addOperation:operation];
    
    return cell;
}

@end
