//
//  DemoPersonRealm.h
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoPersonRealm : NSObject

+ (instancetype)sharedInstance;

- (void)addPersonRealm;

- (NSArray *)queryPersonRealm;

@end
