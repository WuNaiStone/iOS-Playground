//
//  AppDelegate.m
//  DemoUIPasteboard
//
//  Created by Chris Hu on 16/8/11.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
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
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSLog(@"string : %@", pasteboard.string);
    NSLog(@"strings : %@", pasteboard.strings);
    NSLog(@"URL : %@", pasteboard.URL);
    NSLog(@"URLs : %@", pasteboard.URLs);
    NSLog(@"image : %@", pasteboard.image);
    NSLog(@"images : %@", pasteboard.images);
    NSLog(@"color : %@", pasteboard.color);
    NSLog(@"colors : %@", pasteboard.colors);
    
    // for example : https://www.bing.com , will automatically open the website.
    // 类似淘宝的复制淘口令, 然后打开对应链接.
    if (pasteboard.string) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pasteboard.string]];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
