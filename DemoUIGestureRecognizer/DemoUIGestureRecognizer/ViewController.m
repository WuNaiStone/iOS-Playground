//
//  ViewController.m
//  DemoUIGestureRecognizer
//
//  Created by zj－db0465 on 15/9/28.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    longGesture.minimumPressDuration = 2.0f;
    [self.view addGestureRecognizer:longGesture];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionGesture:(UIGestureRecognizer *)sender {
    NSLog(@"actionGesture : %@", sender);
    NSLog(@"numberOfTouches : %ld\n", (long)sender.numberOfTouches);
    if ([sender isKindOfClass:[UISwipeGestureRecognizer class]]) {
        NSLog(@"Swipe : %@", sender);
    }
}

@end
