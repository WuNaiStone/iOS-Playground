//
//  ViewController.m
//  DemoNSUserDefaults
//
//  Created by zj－db0465 on 16/2/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"key1 - %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"key1"]);
    [[NSUserDefaults standardUserDefaults] setValue:@"value1" forKey:@"key1"];
    NSLog(@"key1 - %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"key1"]);
    
    NSLog(@"key2 - %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"key2"]);
    [[NSUserDefaults standardUserDefaults] setObject:@100 forKey:@"key2"];
    NSLog(@"key2 - %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"key2"]);
    
    
    NSUserDefaults *customUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"CustomUserDefaults"];
    NSLog(@"key3 - %@", [customUserDefaults valueForKey:@"key3"]);
    [customUserDefaults setValue:@"value3" forKey:@"key3"];
    NSLog(@"key3 - %@", [customUserDefaults valueForKey:@"key3"]);

    NSLog(@"key4 - %@", [customUserDefaults objectForKey:@"key4"]);
    [customUserDefaults setObject:@200 forKey:@"key4"];
    NSLog(@"key4 - %@", [customUserDefaults objectForKey:@"key4"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
