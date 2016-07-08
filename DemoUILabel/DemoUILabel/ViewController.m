//
//  ViewController.m
//  DemoUILabel
//
//  Created by Chris Hu on 16/2/13.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self demoUILabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)demoUILabel {
    NSString *text = @"The Foundation framework defines a base layer of Objective-C classes. In addition to providing a set of useful primitive object classes, it introduces several paradigms that define functionality not covered by the Objective-C language. The Foundation framework is designed with these goals in mind. The Foundation framework includes the root object class, classes representing basic data types such as strings and byte arrays, collection classes for storing other objects, classes representing system information such as dates, and classes representing communication ports. See Cocoa Objective-C Hierarchy for Foundation for a list of those classes that make up the Foundation framework.";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    label.backgroundColor = [UIColor grayColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.text = text;
    [self.view addSubview:label];

    // 根据字符串大小计算label的大小
//    CGSize size = [label.text sizeWithFont:[UIFont boldSystemFontOfSize:17.0f] constrainedToSize:CGSizeMake(self.view.frame.size.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
    
    // sizeWithFont:xxx方法已启用，现更新为boundingRectWithSize:xxx方法
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]} context:nil].size;
    
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, size.height);
}


@end
