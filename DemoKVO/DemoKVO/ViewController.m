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

static NSInteger nameContext = 0;
static NSInteger ageContext = 1;
static void * languageContext = &languageContext; // 一个静态变量存着它自己的指针，即什么都没有。

- (void)addKVO {
    [self.myObject addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:&nameContext];
    
    [self.myObject addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:&ageContext];
    
    [self.myObject addObserver:self forKeyPath:@"language" options:NSKeyValueObservingOptionNew context:&languageContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath >>> ");
    
    if (context == &nameContext) {
        NSLog(@"keyPath : %@", keyPath);
        NSLog(@"object : %@", object);
        NSLog(@"change : %@", change);
        
        // 放置keyPath的拼写错误导致crash
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(name))]) {
            NSLog(@"keyPath isEqualToString NSStringFromSelector name");
            
            // removeObserver，或者在dealloc中。
            @try {
                [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(age)) context:&ageContext];
            }
            @catch (NSException *exception) {
            }
            @finally {
            }
        }
    } else if (context == &ageContext) {
        NSLog(@"keyPath : %@", keyPath);
        NSLog(@"object : %@", object);
        NSLog(@"change : %@", change);
    } else if (context == &languageContext) {
        NSLog(@"keyPath : %@", keyPath);
        NSLog(@"object : %@", object);
        NSLog(@"change : %@", change);
    }
    else {
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
    
    
    [self.myObject setValue:@"New Age" forKey:@"age"];
    
    [self.myObject setValue:@"New Language" forKey:@"language"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
