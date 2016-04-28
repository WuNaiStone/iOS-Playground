//
//  ViewController.m
//  DemoSocial
//
//  Created by Chris Hu on 16/4/27.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

static const NSString *url = @"http://xiuxiu.mobile.meitudata.com/tuiguang/airbrush/download/en";

@interface ViewController () <
    UITableViewDataSource,
    UITableViewDelegate
>

@end

@implementation ViewController {
    UITableView *_tableView;
    
    NSArray *_items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _items = @[@"Twitter", @"Facebook", @"SinaWeibo", @"TencentWeibo"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self shareToTwitter];
            break;
        case 1:
            [self shareToFacebook];
            break;
        case 2:
            [self shareToSinaWeibo];
            break;
        case 3:
            [self shareToTencentWeibo];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)shareToTwitter {
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        return;
    }
    
    SLComposeViewController *sl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [sl setInitialText:@"This is my site"];
    
    [sl addURL:[NSURL URLWithString:url]];
    [self presentViewController:sl animated:YES completion:nil];
}

- (void)shareToFacebook {
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        return;
    }
    
    SLComposeViewController *sl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [sl setInitialText:@"This is my site"];
    
    [sl addURL:[NSURL URLWithString:url]];
    [self presentViewController:sl animated:YES completion:nil];
}

- (void)shareToSinaWeibo {
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        return;
    }
    
    SLComposeViewController *sl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    [sl setInitialText:@"This is my site"];
    
    [sl addURL:[NSURL URLWithString:url]];
    [self presentViewController:sl animated:YES completion:nil];
}

- (void)shareToTencentWeibo {
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTencentWeibo]) {
        return;
    }
    
    SLComposeViewController *sl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];
    [sl setInitialText:@"This is my site"];
    
    [sl addURL:[NSURL URLWithString:url]];
    [self presentViewController:sl animated:YES completion:nil];
}

@end
