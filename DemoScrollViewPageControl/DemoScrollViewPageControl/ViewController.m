//
//  ViewController.m
//  DemoScrollViewPageControl
//
//  Created by zj－db0465 on 15/12/1.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"

#import "AViewController.h"

@interface ViewController ()

@property (nonatomic) UIView *headerView;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"ViewController";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    _headerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_headerView];
    
    [self initScrollView];
    [self initPageControl];
    [self initTimer];
    
    [self addAViewControllerButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:_headerView.bounds];
    [_headerView addSubview:_scrollView];
    
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, 0);
    
    for (NSInteger i=0; i<3; i++) {
        UIButton *btnImage = [[UIButton alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width * i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        [btnImage setBackgroundImage:[UIImage imageNamed:@"MVC.png"] forState:UIControlStateNormal];
        btnImage.contentMode = UIViewContentModeScaleAspectFit;
        [btnImage addTarget:self action:@selector(actionBtnImage:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btnImage];
    }
}

- (void)actionBtnImage:(UIButton *)sender {
    NSLog(@"actionBtnImage");
}

- (void)initPageControl {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((_headerView.frame.size.width - 100) / 2, 150, 100, 30)];
    [_headerView addSubview:_pageControl];
    
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
}

- (void)initTimer {
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(nextImageScrollView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)nextImageScrollView {
    NSInteger page = _pageControl.currentPage;
    page++;
    if (page == 3) {
        page = 0;
    }
    CGPoint point = CGPointMake(_scrollView.frame.size.width * page, 0);
    [_scrollView setContentOffset:point animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = [NSNumber numberWithFloat:(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5)].integerValue;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_timer) {
        [_timer invalidate];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self initTimer];
}


#pragma mark - AViewController
- (void)addAViewControllerButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50)];
    [btn setTitle:@"AViewController" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(actionAViewController:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.view addSubview:btn];
}

- (void)actionAViewController:(UIButton *)sender {
    AViewController *aViewController = [[AViewController alloc] init];
    [self presentViewController:aViewController animated:YES completion:nil];
}

@end
