//
//  ViewController.m
//  DemoUIViewRelatedAll
//
//  Created by icetime17 on 16/1/7.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController () <

    UITableViewDataSource, UITableViewDelegate
>

@end

@implementation ViewController {

    NSArray *demos;
    UITableView *tableViewDemos;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"UIView Related Demos";
    
    [self addTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define ReuseCellIdentifier @"ReuseCellIdentifier"

- (void)addTableView {
    demos = @[@"AutoResize"];
    
    tableViewDemos = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:tableViewDemos];
    
    tableViewDemos.dataSource = self;
    tableViewDemos.delegate = self;
    [tableViewDemos registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCellIdentifier];
    cell.textLabel.text = demos[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableViewDemos deselectRowAtIndexPath:indexPath animated:YES];
    
    DemoViewController *demo = [[DemoViewController alloc] init];
    demo.demos = demos;
    demo.title = demos[indexPath.row];
    [self.navigationController pushViewController:demo animated:YES];
}

@end
