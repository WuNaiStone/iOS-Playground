//
//  AView.h
//  DemoScrollViewPageControl
//
//  Created by Chris Hu on 16/1/13.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AViewScrollDelegate <NSObject>

- (void)viewDidScroll;

@end

@interface AView : UIView

@property (nonatomic, weak) id<AViewScrollDelegate> scrollDelegate;

@end
