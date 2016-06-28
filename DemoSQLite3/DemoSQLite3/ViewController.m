//
//  ViewController.m
//  DemoSQLite3
//
//  Created by Chris Hu on 16/6/27.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

@end

@implementation ViewController {

    sqlite3 *db;
    
    sqlite3_stmt *statement;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testSQLite3];
}

- (void)testSQLite3 {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"testSQLite3.sqlite3"];
    
    if (sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
        char *errMsg;
        NSString *sql_stmt = @"CREATE TABLE IF NOT EXISTS myTable (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);";
        if (sqlite3_exec(db, [sql_stmt UTF8String] , NULL, NULL, &errMsg) == SQLITE_OK) {
            
            [self insert];
            
            [self query];
            
            sqlite3_close(db);
        } else {
            NSLog(@"Fail to create table.");
            sqlite3_close(db);
        }
    }
}

- (void)insert {
    for (NSInteger i=0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"name-%ld", (long)i];
        NSString *sql_stmt = [NSString stringWithFormat:@"INSERT INTO myTable (name, age) VALUES (\"%@\", \"%@\");", name, @(arc4random_uniform(20))];
        sqlite3_prepare_v2(db, [sql_stmt UTF8String], -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"insert.");
        } else {
            NSLog(@"Failed to insert.");
        }
        sqlite3_reset(statement);
    }
}

- (void)query {
    NSString *sql_stmt = [NSString stringWithFormat:@"SELECT * FROM myTable"];
    if (sqlite3_prepare_v2(db, [sql_stmt UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            NSString *age  = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
            NSLog(@"name : %@, age : %@", name, age);
        }
    }
    sqlite3_reset(statement);
}

@end
