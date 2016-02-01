//
//  ViewController.m
//  DemoKVC
//
//  Created by zj－db0465 on 16/1/28.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

@interface MyObject : NSObject

@property (nonatomic) NSString *name;

@end

@implementation MyObject

@end


@interface ViewController ()

@property (nonatomic) NSString *name;

@property (nonatomic) MyObject *myObject;

@end

@implementation ViewController {

    NSString *anotherName;
    
    MyObject *myObject1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myObject = [MyObject new];
    
    // NonKVC
    [self testNonKVC];
    
    // KVC
    [self testKVC];
    
}

- (void)testNonKVC {
    //  NonKVC, .语法
    NSLog(@">>>>>>>> testingNonKVC \n");
    
    //  属性
    self.name = @".Name";
    NSLog(@".name : %@", self.name);
    // KVC
    NSLog(@"name valueForKey : %@", [self valueForKey:@"name"]);
    NSLog(@"\n");
    
    // 实例变量
    anotherName = @".Another Name";
    NSLog(@".anotherName : %@", anotherName);
    // KVC
    NSLog(@"anotherName valueForKey : %@", [self valueForKey:@"anotherName"]);
    NSLog(@"\n");
    
    
    // MyObject
    MyObject *myObject = [MyObject new];
    myObject.name = @"myObject Name";
    NSLog(@"myObject.name : %@", myObject.name);
    // KVC
    NSLog(@"myObject valueForKey : %@", [myObject valueForKey:@"name"]);
    NSLog(@"myObject valueForKeyPath : %@", [myObject valueForKeyPath:@"name"]);
    NSLog(@"\n");
    
    self.myObject.name = @"self.myObject Name";
    NSLog(@"self.myObject.name : %@", myObject.name);
    // KVC
    NSLog(@"myObject valueForKey : %@", [myObject valueForKey:@"name"]);
    NSLog(@"myObject valueForKeyPath : %@", [myObject valueForKeyPath:@"name"]);
    NSLog(@"\n");
    
    myObject1 = [MyObject new];
    myObject1.name = @"myObject1 Name";
    NSLog(@"myObject1.name : %@", myObject1.name);
    // KVC
    NSLog(@"myObject1 valueForKeyPath : %@", [self valueForKeyPath:@"myObject1.name"]);
    NSLog(@"\n");
}


- (void)testKVC {
    // KVC
    NSLog(@">>>>>>>> testingKVC \n");
    
    // 属性
    [self setValue:@"Name" forKey:@"name"];
    NSLog(@"name valueForKey : %@", [self valueForKey:@"name"]);
    NSLog(@"name valueForKeyPath : %@", [self valueForKeyPath:@"name"]);
    NSLog(@"\n");
    
    // 实例变量
    [self setValue:@"Another Name" forKey:@"anotherName"];
    NSLog(@"anotherName valueForKey : %@", [self valueForKey:@"anotherName"]);
    NSLog(@"anotherName valueForKeyPath : %@", [self valueForKeyPath:@"anotherName"]);
    NSLog(@"\n");

    
    // MyObject
    MyObject *myObject = [MyObject new];
    [myObject setValue:@"myObject Name" forKey:@"name"];
    NSLog(@"myObject valueForKey : %@", [myObject valueForKey:@"name"]);
    NSLog(@"myObject valueForKeyPath : %@", [myObject valueForKeyPath:@"name"]);
    NSLog(@"\n");
    
    
    myObject1 = [MyObject new];
    [self setValue:@"myObject1 Name" forKeyPath:@"myObject1.name"];
    NSLog(@"myObject1 valueForKeyPath : %@", [self valueForKeyPath:@"myObject1.name"]);
    //  对self直接使用forKey等会出错，因self本身就没有该key。只能使用keyPath相关方法。
    //  [self setValue:@"myObject1 Name" forKey:@"myObject1.name"];
    //  NSLog(@"myObject1 valueForKey : %@", [self valueForKey:@"myObject1.name"]);
    NSLog(@"\n");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
