//
//  NewsTableViewDataSourceManager.m
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "NewsTableViewDataSourceManager.h"

@implementation NewsTableViewDataSourceManager {

    NSString *_title;
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsTableViewCell forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", _title, @"Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        [_delegate didSelectRowAtIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
