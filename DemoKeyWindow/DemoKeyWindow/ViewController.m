//
//  ViewController.m
//  DemoKeyWindow
//
//  Created by Chris Hu on 16/4/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addLabel];
    [self addImage];
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 50)];
    [self.view addSubview:label];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"ViewController";
}

- (void)addImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 400)];
    [self.view addSubview:imageView];
    
    imageView.center = self.view.center;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"Model.jpg"];
}

@end
