//
//  main.m
//  FactoryPattern
//
//  Created by zj－db0465 on 15/11/2.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>


// Engine
@interface Engine : NSObject

@end

@implementation Engine

- (void)create {
    NSLog(@"%s", __func__);
}

@end


// Wheel
@interface Wheel : NSObject

@end

@implementation Wheel

- (void)create:(NSInteger)count {
    NSLog(@"%s", __func__);
}

@end


// Underpan
@interface Underpan : NSObject

@end

@implementation Underpan

- (void)create {
    NSLog(@"%s", __func__);
}

@end


// Light
@interface Light : NSObject

@end

@implementation Light

- (void)create {
    NSLog(@"%s", __func__);
}

@end


// AwesomeLight
@interface AwesomeLight : NSObject

@end

@implementation AwesomeLight

- (void)create {
    NSLog(@"%s", __func__);
}

@end


// Car
@interface Car : NSObject

@end

@implementation Car

- (void)create:(Engine *)engine
         wheel:(Wheel *)wheel
      underpan:(Underpan *)underpan
         light:(Light *)light
  awesomeLight:(AwesomeLight *)awesomeLight
{
    NSLog(@"%s", __func__);
    NSLog(@"engine : %@", engine);
    NSLog(@"wheel : %@", wheel);
    NSLog(@"underpan : %@", underpan);
    NSLog(@"light : %@", light);
    NSLog(@"awesomeLight : %@", awesomeLight);
}

@end


 

// FactoryPattern
@interface CarFactory : NSObject

@end

@implementation CarFactory

- (Car *)createCar {
    Engine *engine = [[Engine alloc] init];
    [engine create];

    Wheel *wheel = [[Wheel alloc] init];
    [wheel create:3];

    Underpan *underpan = [[Underpan alloc] init];
    [underpan create];

    Light *light = [[Light alloc] init];
    [light create];

    AwesomeLight *awesomeLight = [[AwesomeLight alloc] init];
    [awesomeLight create];
    
    Car *car = [[Car alloc] init];
    [car create:engine wheel:wheel underpan:underpan light:light awesomeLight:awesomeLight];

    return car;
}

@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Engine *engine = [[Engine alloc] init];
        [engine create];

        // 添加Wheel的属性，如个数
        Wheel *wheel = [[Wheel alloc] init];
        [wheel create:3];
        
        Underpan *underpan = [[Underpan alloc] init];
        [underpan create];
        
        Light *light = [[Light alloc] init];
        [light create];
        
        AwesomeLight *awesomeLight = [[AwesomeLight alloc] init];
        [awesomeLight create];
        
        // 添加AwesomeLight，需要改动Car的定义和实现。
        // 如果要实例化多个car，则以上代码量很多。且以后若有修改，则涉及到的地方很多，扩展性不好。
        Car *car = [[Car alloc] init];
        [car create:engine wheel:wheel underpan:underpan light:light awesomeLight:awesomeLight];
        
        // FactoryPattern,即用户不需要一个个地实例化零件，且修改后调用的接口不变。调用端的耦合度降低。
        // 对用户而言，扩展性好。
        CarFactory *carFactory = [[CarFactory alloc] init];
        [carFactory createCar];
    }
    return 0;
}
