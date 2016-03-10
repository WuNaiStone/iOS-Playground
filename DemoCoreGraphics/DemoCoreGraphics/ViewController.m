//
//  ViewController.m
//  DemoCoreGraphics
//
//  Created by Chris Hu on 16/3/10.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DrawView *drawView = [[DrawView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
