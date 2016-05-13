//
//  CarouselTableViewController.m
//  DemoiCarousel
//
//  Created by Chris Hu on 16/5/14.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CarouselTableViewController.h"
#import "ItemViewController.h"

@interface CarouselTableViewController ()

@end

@implementation CarouselTableViewController {

    NSArray *items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBtn];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    items = @[ @"iCarouselTypeLinear",
               @"iCarouselTypeRotary",
               @"iCarouselTypeInvertedRotary",
               @"iCarouselTypeCylinder",
               @"iCarouselTypeInvertedCylinder",
               @"iCarouselTypeWheel",
               @"iCarouselTypeInvertedWheel",
               @"iCarouselTypeCoverFlow",
               @"iCarouselTypeCoverFlow2",
               @"iCarouselTypeTimeMachine",
               @"iCarouselTypeInvertedTimeMachine",
               @"iCarouselTypeCustom"
            ];
}

- (void)addBtn {
    UIBarButtonItem *btnClose = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionButton:)];
    self.navigationItem.leftBarButtonItem = btnClose;
}

- (void)actionButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = items[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemViewController *itemVC = [[ItemViewController alloc] init];
    itemVC.iCarouselType = indexPath.row;
    [self.navigationController pushViewController:itemVC animated:YES];
}

@end
