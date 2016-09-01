//
//  CSSlider.h
//  CustomUISlider
//
//  Created by Chris Hu on 16/8/31.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSSliderDelegate;

typedef NS_ENUM(NSInteger, CSSliderTrackTintType) {
    CSSliderTrackTintType_Linear = 0,
    CSSliderTrackTintType_Divide,
};

@interface CSSlider : UISlider

@property (nonatomic, weak) id<CSSliderDelegate> delegate;

@property (nonatomic, assign) float middleVaule;

@property (nonatomic, assign) CSSliderTrackTintType trackTintType;

@property (nonatomic, strong) UIImage *csThumbImage;
@property (nonatomic, strong) UIColor *csMinimumTrackTintColor;
@property (nonatomic, strong) UIColor *csMaximumTrackTintColor;

- (void)increasePercentRate:(NSInteger)percent;
- (void)decreasePercentRate:(NSInteger)percent;

@end


@protocol CSSliderDelegate <NSObject>

- (void)CSSliderValueChanged:(CSSlider *)sender;
- (void)CSSliderTouchDown:(CSSlider *)sender;
- (void)CSSliderTouchUp:(CSSlider *)sender;
- (void)CSSliderTouchCancel:(CSSlider *)sender;

@end
