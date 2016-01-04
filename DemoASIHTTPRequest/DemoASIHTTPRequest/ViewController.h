//
//  ViewController.h
//  DemoASIHTTPRequest
//
//  Created by zj－db0465 on 16/1/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(NSData *data);

@interface ViewController : UIViewController

- (void)getBaidu:(CompletionBlock)completionBlock;

@end

