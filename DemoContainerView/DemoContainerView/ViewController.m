//
//  ViewController.m
//  DemoContainerView
//
//  Created by Chris Hu on 16/4/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "ContainerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addLabels];
}

- (void)addLabels {
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.frame), 30)];
    lb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb];
    lb.text = NSStringFromClass(self.class);
}

- (void)addBtns {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Display Container View" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionButton:(UIButton *)sender {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    if ([segue.identifier isEqualToString:@"ContainerViewController"]) {
        ContainerViewController *containerVC = (ContainerViewController *)segue.destinationViewController;
        containerVC.parentVC = self;
    }
}

- (void)displayContentController: (UIViewController*)content {
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    content.view.center = self.view.center;
    [self.view addSubview:self.containerView];
    [content didMoveToParentViewController:self];
}

- (void)hideContentController: (UIViewController*)content {
    [content willMoveToParentViewController:self];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}

@end
