//
//  DemoPersonCoreData.h
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/17.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonCoreData.h"

@interface DemoPersonCoreData : NSObject

+ (instancetype)sharedInstance;

- (void)addPersonCoreData;

- (NSArray *)queryPersonCoreData;

@end
