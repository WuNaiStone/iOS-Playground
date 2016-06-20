//
//  DemoPersonRealmViewController.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "DemoPersonRealmViewController.h"
#import "ViewTableViewCellPerson.h"
#import "ViewEditPerson.h"
#import "DemoPersonRealm.h"
#import "PersonRealm.h"
#import "AppDelegate.h"

@interface DemoPersonRealmViewController () <
    UITableViewDataSource,
    UITableViewDelegate,
    ViewEditPersonDelegate,
    DemoPersonRealmDelegate
>

@end

@implementation DemoPersonRealmViewController {

    ViewEditPerson *_viewEditPerson;
    
    UITableView *_tableView;
    
    RLMResults *_persons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
    [self initViewEditPerson];
    
    [self initTableView];
    
    [DemoPersonRealm sharedInstance].delegateUpdated = self;
    
    [self updateDataSource];
}

- (void)initNavBar {
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAddOne:)];
    
    UIBarButtonItem *btnLeft2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(actionAddAll:)];
    
    UIBarButtonItem *btnLeft3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionUpdate:)];
    
    self.navigationItem.leftBarButtonItems = @[btnLeft, btnLeft2, btnLeft3];
    
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionSorted:)];
    
    UIBarButtonItem *btnRight2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionFiltered:)];
    
    self.navigationItem.rightBarButtonItems = @[btnRight, btnRight2];
}

- (void)actionAddOne:(UIBarButtonItem *)sender {
    _viewEditPerson.personRealm = nil;
    
    _viewEditPerson.hidden = NO;
}

- (void)actionAddAll:(UIBarButtonItem *)sender {
    for (NSInteger i = 0; i<1000; i++) {
        [[DemoPersonRealm sharedInstance] addPersonRealm];
    }
}

- (void)actionUpdate:(UIBarButtonItem *)sender {
    [[DemoPersonRealm sharedInstance] updatePersonRealm];
}

- (void)actionSorted:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorted By Property" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionSortedByName = [UIAlertAction actionWithTitle:@"Name" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _persons = [[DemoPersonRealm sharedInstance] queryPersonRealmSortedBy:@"name"];
        [_tableView reloadData];
        
    }];
    
    UIAlertAction *actionSortedByAge = [UIAlertAction actionWithTitle:@"Age" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _persons = [[DemoPersonRealm sharedInstance] queryPersonRealmSortedBy:@"age"];
        [_tableView reloadData];
        
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:actionSortedByName];
    [alert addAction:actionSortedByAge];
    [alert addAction:actionCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)actionFiltered:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Filtered By Property" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionFilteredByName = [UIAlertAction actionWithTitle:@"name BEGINSWITH 'A'" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _persons = [[DemoPersonRealm sharedInstance] queryPersonRealmFilteredBy:@"name BEGINSWITH 'A'"];
        [_tableView reloadData];
        
    }];
    
    UIAlertAction *actionFilteredByAge = [UIAlertAction actionWithTitle:@"age == 18" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _persons = [[DemoPersonRealm sharedInstance] queryPersonRealmFilteredBy:@"age == 18"];
        [_tableView reloadData];
        
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:actionFilteredByName];
    [alert addAction:actionFilteredByAge];
    [alert addAction:actionCancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)initViewEditPerson {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ViewEditPerson class]) owner:nil options:nil];
    _viewEditPerson = (ViewEditPerson *)[array lastObject];
    _viewEditPerson.frame = self.view.frame;
    _viewEditPerson.hidden = YES;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:_viewEditPerson];
    
    _viewEditPerson.delegate = self;
}

#pragma mark - <ViewEditPersonDelegate>

- (void)ViewEditPersonActionDone {
//    [self updateDataSource];
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

#pragma mark - <DemoPersonRealmDelegate>

- (void)DemoPersonRealmUpdated {
//    NSLog(@"%s", __func__);
    
    [self updateDataSource];
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
    
    PersonRealm *person     = (PersonRealm *)_persons[indexPath.row];
    cell.avatar.image       = [UIImage imageNamed:person.avatar];
    cell.lbName.text        = person.name;
    cell.lbWechatId.text    = person.wechatId;
    cell.lbAge.text         = [NSString stringWithFormat:@"%ld", (long)person.age];
    cell.lbCity.text        = person.city;
    cell.lbHeight.text      = [NSString stringWithFormat:@"%ld", (long)person.height];
    cell.lbWeight.text      = [NSString stringWithFormat:@"%ld", (long)person.weight];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonRealm *personRealm    = (PersonRealm *)_persons[indexPath.row];
    _viewEditPerson.personRealm = personRealm;
    
    _viewEditPerson.hidden = NO;
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
