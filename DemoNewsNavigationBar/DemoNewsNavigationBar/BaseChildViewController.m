//
//  BaseChildViewController.m
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "BaseChildViewController.h"
#import "NewsTableViewDataSourceManager.h"
#import "NewsDetailViewController.h"

@interface BaseChildViewController () <

    NewsTableViewDataSourceManagerDelegate
>

@end

@implementation BaseChildViewController {

    UITableView *_tableView;

    NewsTableViewDataSourceManager *_dataSourceManager;
    
    UISwipeGestureRecognizer *_leftSwipeGestureRecognizer;
    UISwipeGestureRecognizer *_rightSwipeGestureRecognizer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLabel];
    
    CGRect frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 44);
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NewsTableViewCell];
    
    _dataSourceManager = [[NewsTableViewDataSourceManager alloc] initWithTitle:self.title];
    _dataSourceManager.delegate = self;
    
    _tableView.dataSource = _dataSourceManager;
    _tableView.delegate = _dataSourceManager;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self prepareUIGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    label.text = self.title;
    [self.view addSubview:label];
    
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
}

#pragma mark - <NewsTableViewDataSourceManagerDelegate>

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc] init];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

- (void)reloadData {

}

#pragma mark - UIGestureRecognizer

- (void)prepareUIGestureRecognizer {
    _leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipeGesture:)];
    _leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_leftSwipeGestureRecognizer];
    
    _rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionSwipeGesture:)];
    _rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_rightSwipeGestureRecognizer];
}

- (void)actionSwipeGesture:(UISwipeGestureRecognizer *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSwipeGesture:)]) {
        [_delegate actionSwipeGesture:sender];
    }
}

@end
