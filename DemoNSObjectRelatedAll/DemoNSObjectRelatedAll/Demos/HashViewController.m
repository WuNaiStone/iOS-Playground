//
//  HashViewController.m
//  DemoNSObjectRelatedAll
//
//  Created by Chris Hu on 16/3/23.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "HashViewController.h"


@interface MyClass : NSObject

@property (strong,nonatomic) NSString *name;

- (BOOL)isEqual:(id)object;

@end

@implementation MyClass

- (BOOL)isEqual:(id)object {
    return [self.name isEqual:((MyClass *)object).name];
}

@end


@interface HashViewController ()

@end

@implementation HashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self addButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)addButtons {
    UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [btnClose setTitle:@"Close" forState:UIControlStateNormal];
    [btnClose setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnClose setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btnClose addTarget:self action:@selector(actionClose:) forControlEvents:UIControlEventTouchUpInside];
    btnClose.layer.borderColor = [UIColor redColor].CGColor;
    btnClose.layer.borderWidth = 2.0f;
    [self.view addSubview:btnClose];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"Demo" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionDemo:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionClose:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionDemo:(UIButton *)sender {
    [self demoHash];
}

- (void)demoHash {
    NSIndexPath *one = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *two = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *three = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *four = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *five = [NSIndexPath indexPathForRow:1 inSection:1];
    /*
     (lldb) p one
     (NSIndexPath *) $7 = 0xc000000000000016
     (lldb) p two
     (NSIndexPath *) $8 = 0xc000000000000016
     (lldb) p three
     (NSIndexPath *) $9 = 0xc000000000200016
     (lldb) p four
     (NSIndexPath *) $10 = 0xc000000000200016
     (lldb) p five
     (NSIndexPath *) $11 = 0xc000000000200116
     */
    
    NSString *s1 = [[NSString alloc] initWithFormat:@"s"];
    NSString *s2 = [[NSString alloc] initWithFormat:@"s"];
    /*
    (lldb) p s1
    (NSTaggedPointerString *) $1 = 0xa000000000000731 @"s"
    (lldb) p s2
    (NSTaggedPointerString *) $2 = 0xa000000000000731 @"s"
     */
    
    
    NSArray *a1 = [[NSArray alloc] initWithObjects:@"1", @"2", nil];
    NSArray *a2 = [[NSArray alloc] initWithObjects:@"1", @"2", nil];
    /*
     (lldb) p a1
     (__NSArrayI *) $3 = 0x00007fa01bd4b5a0 @"2 objects"
     (lldb) p a2
     (__NSArrayI *) $4 = 0x00007fa01bd4a5e0 @"2 objects"
     */
    
    NSDictionary *d1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"value", @"key", nil];
    NSDictionary *d2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"value", @"key", nil];
    /*
     (lldb) p d1
     (__NSDictionaryI *) $5 = 0x00007fa01bd45800 1 key/value pair
     (lldb) p d2
     (__NSDictionaryI *) $6 = 0x00007fa01bd4da00 1 key/value pair
     */
    
    MyClass *cls1 = [[MyClass alloc] init];
    cls1.name = @"cls";
    
    MyClass *cls2 = [[MyClass alloc] init];
    cls2.name = @"cls";
    /*
     (lldb) p cls1
     (MyClass *) $12 = 0x00007fa01bd3bc60
     (lldb) p cls2
     (MyClass *) $13 = 0x00007fa01bd4b610
     (lldb) p [cls1 isEqual:cls2] 自定义对象要重写isEqual:方法，指定比较的方式。
     (BOOL) $14 = YES
     */
    
    /*
     NSObject的hash值暂时不清楚如何来的。
     (lldb) p s1.hash
     (NSUInteger) $15 = 1116
     (lldb) p s2.hash
     (NSUInteger) $16 = 1116
     (lldb) p a1.hash
     (NSUInteger) $17 = 2
     (lldb) p a2.hash
     (NSUInteger) $18 = 2
     (lldb) p d1.hash
     (NSUInteger) $19 = 1
     (lldb) p d2.hash
     (NSUInteger) $20 = 1
     (lldb) p cls1.hash
     (NSUInteger) $21 = 140325638356064
     (lldb) p cls2.hash
     (NSUInteger) $22 = 140325638419984
     */
}

@end
