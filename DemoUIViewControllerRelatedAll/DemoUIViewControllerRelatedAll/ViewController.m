//
//  ViewController.m
//  DemoUIViewControllerRelatedAll
//
//  Created by Chris Hu on 16/3/3.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "LifeCycleViewController.h"
#import "DismissViewController.h"

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
    
    demos = @[@"UIViewController 生命周期",
              @"Dismiss ViewController",
              ];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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

    NSString *viewControllerName;
    switch (indexPath.row) {
        case 0:
            viewControllerName = @"LifeCycleViewController";
            break;
        case 1:
            viewControllerName = @"DismissViewController";
            break;
        default:
            break;
    }
    UIViewController *lifeCycle = [[NSClassFromString(viewControllerName) alloc] init];
    [self presentViewController:lifeCycle animated:YES completion:nil];
}

#pragma mark - Life Cycle

/**
 *  视图加载完成，并即将显示在屏幕上,还没有设置动画，可以改变当前屏幕方向或状态栏的风格等
 *
 *  @param animated 是否有动画效果
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
}

/**
 *  视图已经展示在屏幕上，可以对视图做一些关于展示效果方面的修改。
 *
 *  @param animated 是否有动画效果
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);
}

/**
 *  视图即将消失
 *
 *  @param animated 是否有动画效果
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"%s", __func__);
}

/**
 *  视图即将消失
 *
 *  @param animated 是否有动画效果
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"%s", __func__);
}

@end
