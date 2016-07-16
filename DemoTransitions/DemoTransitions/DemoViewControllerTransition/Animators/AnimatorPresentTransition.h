//
//  AnimatorPresentTransition.h
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimatorPresentTransition : NSObject <

    UIViewControllerAnimatedTransitioning
>

- (instancetype)initFromViewController:(UIViewController *)from toViewController:(UIViewController *)to;

@end
