//
//  TableController.h
//  DemoAsyncDisplayKit
//
//  Created by Chris Hu on 16/4/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableControllerDelegate <NSObject>

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TableController : NSObject

@property (nonatomic, weak) IBOutlet id<TableControllerDelegate> delegate;

@end
