//
//  ViewCAShapeLayerAnimation.h
//  DemoCAShapeLayer
//
//  Created by Chris Hu on 16/7/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewCAShapeLayerAnimationDelegate <NSObject>

- (void)ViewCAShapeLayerAnimationDidStart;

- (void)ViewCAShapeLayerAnimationDidStop;

@end

@interface ViewCAShapeLayerAnimation : UIView

@property (nonatomic, weak) id<ViewCAShapeLayerAnimationDelegate> delegate;

- (void)startAnimation;

@end
