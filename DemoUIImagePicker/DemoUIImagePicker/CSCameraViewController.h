//
//  CSCameraViewController.h
//  DemoUIImagePicker
//
//  Created by zj－db0465 on 16/2/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(UIImagePickerController *picker, NSDictionary *info);

@interface CSCameraViewController : UIImagePickerController

@property (nonatomic, copy) CompletionBlock completionBlock;

@end
