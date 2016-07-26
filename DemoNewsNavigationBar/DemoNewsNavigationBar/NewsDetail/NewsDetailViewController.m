//
//  NewsDetailViewController.m
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSStringFromClass([self class]);
    
    self.view.backgroundColor = [UIColor orangeColor];
}

@end
