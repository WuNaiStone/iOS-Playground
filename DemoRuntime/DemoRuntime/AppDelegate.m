//
//  AppDelegate.m
//  DemoRuntime
//
//  Created by Chris Hu on 15/10/1.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self simpleNilTest];
    
    return YES;
}

- (void)simpleNilTest {
    /**
     *  nil：defines the id of a null instance, 指向一个实例对象的空指针。
     *  Nil：defines the id of a null class, 指向一个类的空指针
     *  NULL: 指向其他类型（基本类型，C类型）的空指针
     *  NSNull：集合中的空值
     */
    
    NSString *string = nil;
    // 给nil发送消息，不会crash。
    // 因为执行 id objc_msgSend(id self, SEL op, ...)方法时，如果self为nil，函数不执行任何有意义的操作而直接返回。
    BOOL b1 = [string hasPrefix:@"prefix"];
    NSLog(@"b1 : %d", b1);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
