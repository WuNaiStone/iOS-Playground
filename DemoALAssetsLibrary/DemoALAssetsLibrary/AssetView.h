//
//  AssetView.h
//  DemoALAssetsLibrary
//
//  Created by zj－db0465 on 15/11/6.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CloseBlock)();

@interface AssetView : UIView

@property (nonatomic, copy) CloseBlock closeBlock;

- (void)showImage:(UIImage *)image;

@end
