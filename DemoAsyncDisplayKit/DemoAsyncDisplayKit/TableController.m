//
//  TableController.m
//  DemoAsyncDisplayKit
//
//  Created by Chris Hu on 16/4/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "TableController.h"
#import <UIKit/UIKit.h>
#import "ItemViewController.h"

@interface TableController() <
    UITableViewDataSource,
    UITableViewDelegate
>

@end

@implementation TableController {
    NSArray *_items;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = @[@"ASTextNode", @"ASImageNode"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = _items[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        [_delegate didSelectRowAtIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
