//
//  ViewController.m
//  DemoTableViewParallax
//
//  Created by Chris Hu on 16/11/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@end

@implementation ViewController
{
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"MyTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (MyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 1) {
        cell.parallaxImage.image = [UIImage imageNamed:@"image1.jpg"];
    } else {
        cell.parallaxImage.image = [UIImage imageNamed:@"image0.jpg"];
    }
    
    return cell;
}

@end
