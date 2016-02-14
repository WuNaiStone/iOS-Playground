//
//  ViewController.m
//  DemoNSCache
//
//  Created by zj－db0465 on 16/2/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <
    NSCacheDelegate
>

@end

@implementation ViewController {
    UIImageView *_imageView;
    
    NSString *_imageName;
    NSCache *_cache;
    
    NSString *_imageUrl;
    NSString *_keyImageUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 200, 250)];
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    
    [self addBtnClearNSCache];
    [self addBtnLocal];
    [self addBtnNetwork];
    
    _cache = [[NSCache alloc] init];
    _cache.name = @"Image NSCache";
    _cache.delegate = self;
    
    _imageName = @"Model.png";
    [self demoNSCacheLocalImage:_imageName];
    
    _imageUrl = @"http://n.sinaimg.cn/ent/transform/20160105/JGXC-fxnerek0974413.jpg";
    _keyImageUrl = @"NetworkImage.png";
    [self demoNSCacheNetworkImage:_imageUrl];
}

- (void)addBtnClearNSCache {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 160, self.view.frame.size.width, 50)];
    [btn setTitle:@"Clear NSCache" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionClearNSCache:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionClearNSCache:(UIButton *)sender {
    NSLog(@"Clear NSCache ...... ");
    [_cache removeAllObjects];
}

- (void)addBtnLocal {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Local Image" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionLocalImage:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionLocalImage:(UIButton *)sender {
    NSData *data = [self imageDataForImageName:_imageName];
    UIImage *image = [UIImage imageWithData:data];
    [_imageView setImage:image];
}

- (void)addBtnNetwork {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 50)];
    [btn setTitle:@"Network Image" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionNetworkImage:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionNetworkImage:(UIButton *)sender {
    NSData *data = [self imageDataForImageURL:_imageUrl];
    UIImage *image = [UIImage imageWithData:data];
    [_imageView setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - local image

- (void)demoNSCacheLocalImage:(NSString *)imageName {
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:imageName]);
    [self write:imageData forKey:imageName];
}

#pragma mark - network image
- (void)demoNSCacheNetworkImage:(NSString *)imageUrl {
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]];
    [self write:imageData forKey:_keyImageUrl];
}

#pragma mark - NSCache related operations

- (NSString *)filePathForKey:(NSString *)key {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@", key]];
    return filePath;
}

- (void)write:(NSData *)data forKey:(NSString *)key {
    NSString *filePath = [self filePathForKey:key];

    // 存储NSCache中
    [_cache setObject:data forKey:key];
    
    // 异步存储于sandbox的文件中
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    });
}

- (NSData *)imageDataForImageName:(NSString *)imageName {
    if (!imageName) {
        return nil;
    }
    
    NSData *cacheData = [_cache objectForKey:imageName];
    if (cacheData) {
        NSLog(@"NSCache Data ...... ");
        return cacheData;
    } else {
        NSLog(@"Sandbox file Data ...... ");
        NSString *filePath = [self filePathForKey:imageName];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
//        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        if (data) {
            [self write:data forKey:imageName];
        }
        return data;
    }
}

- (NSData *)imageDataForImageURL:(NSString *)imageUrl {
    if (!imageUrl) {
        return nil;
    }
    
    NSData *cacheData = [_cache objectForKey:_keyImageUrl];
    if (cacheData) {
        NSLog(@"NSCache Data ...... ");
        return cacheData;
    } else {
        NSString *filePath = [self filePathForKey:_keyImageUrl];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        //        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        if (data) {
            NSLog(@"Sandbox file Data ...... ");
            [self write:data forKey:_keyImageUrl];
        } else {
            NSLog(@"Network Data ...... ");
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            [self write:data forKey:_keyImageUrl];
        }
        return data;
    }
}

#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"NSCacheDelegate ...... ");
    NSLog(@"cache : %@", cache.name);
}

@end
