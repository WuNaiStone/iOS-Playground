//
//  ViewController.m
//  DemoNavigationItemAvatar
//
//  Created by Chris Hu on 16/6/9.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController {

    UITableView *_tableView;
    
    UIImageView *_imageViewAvatar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self addNavigationItemAvatar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Cell";
    
    return cell;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)addNavigationItemAvatar {
    UIView *titleView = [[UIView alloc] init];
    // titleView会自动被系统设置大小.
    // 使用imageViewAvatar的大小需要调整
    self.navigationItem.titleView = titleView;
    
    _imageViewAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
    _imageViewAvatar.layer.cornerRadius = 44;
    _imageViewAvatar.layer.masksToBounds = YES;
    _imageViewAvatar.image = [UIImage imageNamed:@"avatar.png"];
    _imageViewAvatar.center = CGPointMake(titleView.center.x, 22);
    
    [titleView addSubview:_imageViewAvatar];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;

    CGFloat scale = 1.0f;
    
    // 最大下拉距离设为500
    if (offsetY < 0) {
        // 最大scale为2.0
        scale = MIN(2.0, 1 - offsetY / 500);
    } else if (offsetY > 0) {
        // 最小scale为1.0
        scale = MAX(1.0, 1 - offsetY / 500);
    }
    
    _imageViewAvatar.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGRect frame = _imageViewAvatar.frame;
    frame.origin.y = -_imageViewAvatar.layer.cornerRadius / 2;
    // 根据scale更新frame值
    _imageViewAvatar.frame = frame;
}

@end
