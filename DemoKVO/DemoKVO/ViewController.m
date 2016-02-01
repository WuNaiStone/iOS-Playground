//
//  ViewController.m
//  DemoKVO
//
//  Created by zj－db0465 on 16/2/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface MyObject : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *age;
@property (nonatomic) NSString *language;

@end

@implementation MyObject


@end


@interface ViewController ()

@property (nonatomic) MyObject *myObject;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initMyObject];
    
    [self addKVO];
    
    [self addBtn];
}

- (void)initMyObject {
    self.myObject = [MyObject new];
    
    NSArray *array = @[@"name", @"age", @"language"];
    for (NSString *key in array) {
        [self.myObject setValue:@"unknown" forKey:key];
        
        NSString *value = [self.myObject valueForKey:key];
        NSLog(@"%@ - %@", key, value);
    }
    NSLog(@"\n");
}

- (void)addKVO {
    [self.myObject addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath >>> ");
    
    if (context == nil) {
        NSLog(@"keyPath : %@", keyPath);
        NSLog(@"object : %@", object);
        NSLog(@"change : %@", change);
        NSLog(@"context : %@", context);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)addBtn {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Change" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionChange:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionChange:(UIButton *)sender {
    NSString *name = [self.myObject valueForKey:@"name"];
    NSLog(@"Unknown Name : %@", name);
    [self.myObject setValue:@"New Name" forKey:@"name"];
    name = [self.myObject valueForKey:@"name"];
    NSLog(@"New Name : %@", name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
