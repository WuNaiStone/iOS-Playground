//
//  DemoViewControllerTransitionViewController.m
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "DemoViewControllerTransitionViewController.h"
#import "DemoViewControllerTransitionPresentedViewController.h"

@interface DemoViewControllerTransitionViewController ()

@end

@implementation DemoViewControllerTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo];
}

- (void)demo {
    switch (_demoType) {
        case DemoViewControllerTransitionTypeBubble:
        {
            [self prepareBubble];
        }
            break;
        default:
            break;
    }
    
}

- (void)prepareBubble {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 80) / 2,
                              self.view.frame.size.height - 80 - 64,
                              80,
                              80);
    [self.view addSubview:button];
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:60];
    
    button.layer.cornerRadius = 40;
    [button addTarget:self action:@selector(actionBubble:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionBubble:(UIButton *)sender {
    DemoViewControllerTransitionPresentedViewController *presentedVC = [[DemoViewControllerTransitionPresentedViewController alloc] init];
    [self presentViewController:presentedVC animated:YES completion:nil];
}

@end
