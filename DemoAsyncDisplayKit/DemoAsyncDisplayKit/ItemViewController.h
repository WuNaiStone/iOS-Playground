//
//  ItemViewController.h
//  DemoAsyncDisplayKit
//
//  Created by Chris Hu on 16/4/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, ItemType) {
    ItemType_ASTextNode = 0,
    ItemType_ASImageNode
};

@interface ItemViewController : ViewController

@property (nonatomic, assign) NSInteger itemType;

@end
