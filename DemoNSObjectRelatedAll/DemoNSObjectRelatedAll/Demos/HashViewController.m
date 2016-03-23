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
     (NSIndexPath *) $1 = 0xc000000000000016
     (lldb) p two
     (NSIndexPath *) $2 = 0xc000000000000016
     (lldb) p three
     (NSIndexPath *) $3 = 0xc000000000200016
     (lldb) p four
     (NSIndexPath *) $4 = 0xc000000000200016
     (lldb) p five
     (NSIndexPath *) $5 = 0xc000000000200116
     (lldb) p one==two
     (bool) $6 = true
     */
    
    NSString *s1 = [[NSString alloc] initWithFormat:@"s"];
    NSString *s2 = [[NSString alloc] initWithFormat:@"s"];
    // 因此仅不可变字符串是同一内存地址，其他都是不同地址。
    
    NSMutableString *ms1 = [[NSMutableString alloc] initWithString:@"ms"];
    NSMutableString *ms2 = [[NSMutableString alloc] initWithString:@"ms"];
    /*
     (lldb) p s1
     (NSTaggedPointerString *) $11 = 0xa000000000000731 @"s"
     (lldb) p s2
     (NSTaggedPointerString *) $12 = 0xa000000000000731 @"s"
     (lldb) p ms1
     (__NSCFString *) $13 = 0x00007fede2839e30 @"ms"
     (lldb) p ms2
     (__NSCFString *) $14 = 0x00007fede2805bb0 @"ms"
     (lldb) p [ms1 isEqual:ms2]
     (BOOL) $15 = YES
     (lldb) p [ms1 isEqualToString:ms2]
     (BOOL) $16 = YES
     */
    
    NSArray *a1 = [[NSArray alloc] initWithObjects:@"1", @"2", nil];
    NSArray *a2 = [[NSArray alloc] initWithObjects:@"1", @"2", nil];
    
    NSMutableArray *ma1 = [[NSMutableArray alloc] initWithArray:@[@"1", @"2"]];
    NSMutableArray *ma2 = [[NSMutableArray alloc] initWithArray:@[@"1", @"2"]];
    /*
     (lldb) p a1
     (__NSArrayI *) $21 = 0x00007fede2830cb0 @"2 objects"
     (lldb) p a2
     (__NSArrayI *) $22 = 0x00007fede2826ee0 @"2 objects"
     (lldb) p ma1
     (__NSArrayM *) $23 = 0x00007fede282e780 @"2 objects"
     (lldb) p ma2
     (__NSArrayM *) $24 = 0x00007fede2848100 @"2 objects"
     (lldb) p [a1 isEqual:a2]
     (BOOL) $25 = YES
     (lldb) p [ma1 isEqual:ma2]
     (BOOL) $26 = YES
     */
    
    NSDictionary *d1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"value", @"key", nil];
    NSDictionary *d2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"value", @"key", nil];
    
    NSMutableDictionary *md1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value", @"key", nil];
    NSMutableDictionary *md2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value", @"key", nil];
    /*
     (lldb) p d1
     (__NSDictionaryI *) $31 = 0x00007fede2847c00 1 key/value pair
     (lldb) p d2
     (__NSDictionaryI *) $32 = 0x00007fede2847d00 1 key/value pair
     (lldb) p md1
     (__NSDictionaryM *) $33 = 0x00007fede2858480 1 key/value pair
     (lldb) p md2
     (__NSDictionaryM *) $34 = 0x00007fede28584b0 1 key/value pair
     (lldb) p [d1 isEqual:d2]
     (BOOL) $35 = YES
     (lldb) p [md1 isEqual:md2]
     (BOOL) $36 = YES
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
     (NSUInteger) $81 = 1116
     (lldb) p s2.hash
     (NSUInteger) $82 = 1116
     (lldb) p ms1.hash
     (NSUInteger) $83 = 801130
     (lldb) p ms2.hash
     (NSUInteger) $84 = 801130
     (lldb) p a1.hash
     (NSUInteger) $85 = 2
     (lldb) p a2.hash
     (NSUInteger) $86 = 2
     (lldb) p ma1.hash
     (NSUInteger) $87 = 2
     (lldb) p ma2.hash
     (NSUInteger) $88 = 2
     (lldb) p d1.hash
     (NSUInteger) $89 = 1
     (lldb) p d2.hash
     (NSUInteger) $90 = 1
     (lldb) p md1.hash
     (NSUInteger) $91 = 1
     (lldb) p md2.hash
     (NSUInteger) $92 = 1
     
     
     (lldb) p cls1.hash
     (NSUInteger) $93 = 140659655418304
     (lldb) p cls2.hash
     (NSUInteger) $94 = 140659655340752
     */
}

@end
