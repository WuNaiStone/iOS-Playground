//
//  NewsTableViewDataSourceManager.h
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define NewsTableViewCell @"NewsTableViewCell"


@protocol NewsTableViewDataSourceManagerDelegate <NSObject>

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadData;

@end


@interface NewsTableViewDataSourceManager : NSObject <

    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, weak) id<NewsTableViewDataSourceManagerDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title;

@end
