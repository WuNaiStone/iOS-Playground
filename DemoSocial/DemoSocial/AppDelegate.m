//
//  AppDelegate.m
//  DemoSocial
//
//  Created by Chris Hu on 16/4/27.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK/WeiboSDK.h>

@interface AppDelegate ()
<
    WeiboSDKDelegate
>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WeiboSDK registerApp:@"2158684538"];
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        NSLog(@"statusCode: %ld", (long)response.statusCode);
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        NSString *wbtoken = [(WBAuthorizeResponse *)response accessToken];
        NSLog(@"wbtoken : %@", wbtoken);
    } else {
        
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    NSLog(@"kWeiboAppKey");
}

@end
