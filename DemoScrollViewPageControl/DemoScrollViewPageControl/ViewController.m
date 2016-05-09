//
//  ViewController.m
//  DemoScrollViewPageControl
//
//  Created by Chris Hu on 15/12/1.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import "ViewController.h"

#import "CollectionViewCell.h"

#import "AViewController.h"

@interface ViewController () <

    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic) UIView *headerView;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSTimer *timer;


@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *items;

@end

static NSString * const reuseIdentifier = @"CollectionViewCell";

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
    
    
    [self initCollectionView];
    
    
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

#pragma mark - CollectionView

- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, 320, 200) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.items = @[@"Model1",
                   @"Model2",
                   @"Model3",
                   ];
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (CollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"MVC.png"];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    // 每一个section中的每一行（列）之间的间隔
    // vertical：同一个section的上下两行（另起一行）之间的最小间隔
    // horizontal：同一个section的左右两列（另起一列）之间的最小间隔
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    // 每一个section中的每一行之间的间隔
    // vertical：一行间水平（horizontal）相邻两个item之间的最小间隔
    // horizontal：一列间上下（vertical）相邻两个item之间的最小间隔
    // 而item之间实际的间隔由UIEdgeInsets及item个数共同决定（各item之间尽量保持相同间距，不够就另起一行）
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}


#pragma mark - AViewController
- (void)addAViewControllerButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
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
