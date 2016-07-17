//
//  AnimatorBubbleTransition.h
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/17.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimatorBubbleTransition : NSObject <

    UIViewControllerAnimatedTransitioning
>


@property (nonatomic, assign) CGPoint bubbleCenter;


@end
