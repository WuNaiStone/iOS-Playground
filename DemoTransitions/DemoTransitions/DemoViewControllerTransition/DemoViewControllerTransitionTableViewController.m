//
//  DemoViewControllerTransitionTableViewController.m
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "DemoViewControllerTransitionTableViewController.h"
#import "DemoViewControllerTransitionViewController.h"

#define CellReuseIdentifier @"CellReuseIdentifier"

@interface DemoViewControllerTransitionTableViewController ()

@end

@implementation DemoViewControllerTransitionTableViewController {


    NSArray *_demos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"DemoViewControllerTransition";
    
    [self addBtns];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _demos = @[
               @"Bubble",
               ];
}

- (void)addBtns{
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionBack:)];
    self.navigationItem.leftBarButtonItem = btnLeft;
}

- (void)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _demos[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoViewControllerTransitionViewController *demoVC = [[DemoViewControllerTransitionViewController alloc] init];
    demoVC.demoType = DemoViewControllerTransitionTypeBubble;
    demoVC.navigationItem.title = _demos[indexPath.row];
    [self.navigationController pushViewController:demoVC animated:YES];
}

@end
