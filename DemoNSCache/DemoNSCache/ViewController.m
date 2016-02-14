//
//  ViewController.m
//  DemoNSCache
//
//  Created by zj－db0465 on 16/2/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    UIImageView *_imageView;
    
    NSString *_imageName;
    NSData *_data;
    NSCache *_cache;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 200, 250)];
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    
    [self addBtn];
    
    [self demoNSCache];
}

- (void)addBtn {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"NSCache" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionNSCache:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionNSCache:(UIButton *)sender {
    NSData *data = [self readForKey:_imageName];
    UIImage *image = [UIImage imageWithData:data];
    [_imageView setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)demoNSCache {
    _imageName = @"Model.png";
    _data = UIImagePNGRepresentation([UIImage imageNamed:_imageName]);
    _cache = [[NSCache alloc] init];
    
    [self write:_data forKey:_imageName];
    
}

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

- (NSData *)readForKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    
    NSData *cacheData = [_cache objectForKey:key];
    if (cacheData) {
        NSLog(@"NSCache Data ...... ");
        return cacheData;
    } else {
        NSLog(@"Sandbox file Data ...... ");
        NSString *filePath = [self filePathForKey:key];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
//        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        if (data) {
            [_cache setObject:data forKey:key];
        }
        return data;
    }
}

@end
