//
//  DemoPersonRealmViewController.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "DemoPersonRealmViewController.h"
#import "ViewTableViewCellPerson.h"
#import "DemoPersonRealm.h"
#import "PersonRealm.h"

@interface DemoPersonRealmViewController () <
    UITableViewDataSource,
    UITableViewDelegate
>

@end

@implementation DemoPersonRealmViewController {

    UITableView *_tableView;
    
    NSArray *_persons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
    [self initTableView];
    
    [self updateDataSource];
}

- (void)initNavBar {
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAdd:)];
    self.navigationItem.rightBarButtonItem = btnRight;
}

- (void)actionAdd:(UIBarButtonItem *)sender {
    [[DemoPersonRealm sharedInstance] addPersonRealm];
    
    [self updateDataSource];
}

- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([ViewTableViewCellPerson class]) bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"UITableViewCell-Realm"];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)updateDataSource {
    _persons = [[DemoPersonRealm sharedInstance] queryPersonRealm];
    
    [_tableView reloadData];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _persons.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

- (ViewTableViewCellPerson *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewTableViewCellPerson *cell = (ViewTableViewCellPerson *)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell-Realm" forIndexPath:indexPath];
    
    PersonRealm *person = (PersonRealm *)_persons[indexPath.row];
    cell.lbName.text = person.name;
    cell.lbAge.text  = [NSString stringWithFormat:@"%ld", (long)person.age];
    cell.lbCity.text = person.city;
    cell.lbJob.text = person.job;
    
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
