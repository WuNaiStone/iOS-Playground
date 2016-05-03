//
//  ViewController.m
//  DemoAsyncDisplayKit
//
//  Created by Chris Hu on 16/1/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "TableController.h"
#import "ItemViewController.h"

@interface ViewController () <
    TableControllerDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemViewController *item = [[ItemViewController alloc] init];
    item.itemType = indexPath.row;
    [self presentViewController:item animated:YES completion:nil];
}

@end
