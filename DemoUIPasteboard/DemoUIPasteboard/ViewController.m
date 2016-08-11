//
//  ViewController.m
//  DemoUIPasteboard
//
//  Created by Chris Hu on 16/8/11.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewController.h"


#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController {

    UIView *aView;
    
    UILabel *lb;
    UIImageView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aView = [[UIView alloc] initWithFrame:self.view.frame];
    aView.backgroundColor = [UIColor blackColor];
    aView.alpha = 0.5;
    [self.view addSubview:aView];
    
    lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    lb.textAlignment = UIViewContentModeCenter;
    [self.view addSubview:lb];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 350)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchInfoFromUIPasteboard];
}

- (void)fetchInfoFromUIPasteboard {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSLog(@"string : %@", pasteboard.string);
    NSLog(@"strings : %@", pasteboard.strings);
    NSLog(@"URL : %@", pasteboard.URL);
    NSLog(@"URLs : %@", pasteboard.URLs);
    NSLog(@"image : %@", pasteboard.image);
    NSLog(@"images : %@", pasteboard.images);
    NSLog(@"color : %@", pasteboard.color);
    NSLog(@"colors : %@", pasteboard.colors);
    
    if (pasteboard.image) {
        imageView.image = pasteboard.image;
    }
}

@end
