//
//  ViewController.m
//  DemoFMDB
//
//  Created by Chris Hu on 16/6/27.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <FMDB/FMDB.h>

@interface ViewController ()

@end

@implementation ViewController {

    FMDatabase *_db;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testFMDB];
}

- (void)testFMDB {
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [dir stringByAppendingPathComponent:@"testFMDB.sqlite"];
    
    _db = [FMDatabase databaseWithPath:dbPath];
    
    if ([_db open]) {
        BOOL b = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS myTable (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (b) {
            NSLog(@"Create table.");
        } else {
            NSLog(@"Fail to create table.");
            
            [_db close];
        }
    }
    
    [self delete];
    
    [self insert];
    
    [self query];
    
    [_db close];
}

- (void)delete {
//    [_db executeUpdate:@"DROP TABLE IF EXISTS myTable;"];
}

- (void)insert {
    for (NSInteger i=0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"name-%ld", (long)i];
        // 使用？来占位
        [_db executeUpdate:@"INSERT INTO myTable (name, age) VALUES (?, ?);", name, @(arc4random_uniform(20))];
    }
}

- (void)query {
    // 查询结果
    FMResultSet *results = [_db executeQuery:@"SELECT * FROM myTable"];
    
    // 遍历结果
    while ([results next]) {
        int id          = [results intForColumn:@"id"];
        NSString *name  = [results stringForColumn:@"name"];
        int age         = [results intForColumn:@"age"];
        NSLog(@"result: %d, %@, %d", id, name, age);
    }
}

@end
