//
//  CSImagePickerViewController.h
//  DemoUIImagePicker
//
//  Created by zj－db0465 on 16/2/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSImagePickerViewControllerDelegate;

@interface CSImagePickerViewController : UIImagePickerController

@property (nonatomic, weak) id<CSImagePickerViewControllerDelegate> csImagePickerViewControllerDelegate;

@end

@protocol CSImagePickerViewControllerDelegate <NSObject>

/**
 *  回调ViewController中的对应方法，更新Image。
 *
 *  @param picker CSImagePickerViewController
 *  @param info   NSDictionary
 */
- (void)csImagePicker:(CSImagePickerViewController *)picker didFinishPickerPhotoWith:(NSDictionary *)info;

@end
