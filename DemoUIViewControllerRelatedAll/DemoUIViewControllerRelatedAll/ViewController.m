//
//  ViewController.m
//  DemoUIViewControllerRelatedAll
//
//  Created by zj－db0465 on 16/3/3.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "LifeCycleViewController.h"

@interface ViewController () <

    UITableViewDataSource,
    UITableViewDelegate
>

@property (strong, nonatomic) UITableView *tableView;


@end

@implementation ViewController {

    NSArray *demos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    demos = @[@"UIViewController生命周期"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.textLabel.text = [demos objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    LifeCycleViewController *lifeCycle = [[LifeCycleViewController alloc] init];
    [self presentViewController:lifeCycle animated:YES completion:nil];
}

@end
