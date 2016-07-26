//
//  ViewController.m
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import "NewsTitleDataSourceManager.h"
#import "BaseChildViewController.h"

@interface ViewController () <

    BaseChildViewControllerDelegate,
    NewsTitleDataSourceManagerDelegate

>


@end

@implementation ViewController {

    UICollectionView *_collectionView;
    
    NewsTitleDataSourceManager *_newsTitleDataSourceManager;
    
    NSInteger _currentChildIndex;
    
    UISwipeGestureRecognizer *_leftSwipeGestureRecognizer;
    UISwipeGestureRecognizer *_rightSwipeGestureRecognizer;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareUICollectionView];
    
    [self prepareBaseChildViewControllers];
}

- (void)prepareUICollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(64, 44);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"TitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.bounces = NO;
    
    //自定义navigationBar
    self.navigationItem.titleView = _collectionView;
    
    _newsTitleDataSourceManager = [[NewsTitleDataSourceManager alloc] init];
    _newsTitleDataSourceManager.delegate = self;
    
    _collectionView.dataSource = _newsTitleDataSourceManager;
    _collectionView.delegate = _newsTitleDataSourceManager;
}

- (void)prepareBaseChildViewControllers {
    for (NSString *title in _newsTitleDataSourceManager.titles) {
        BaseChildViewController *childVC = [[BaseChildViewController alloc] init];
        childVC.title = title;
        childVC.delegate = self;
        [self addChildViewController:childVC];
    }
    
    _currentChildIndex = 0;
    [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_currentChildIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    [self.view insertSubview:self.childViewControllers[_currentChildIndex].view belowSubview:_collectionView];
}

#pragma mark - <NewsTitleDataSourceManagerDelegate>

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _currentChildIndex) {
        return;
    }
    
    BaseChildViewController *fromChildVC    = self.childViewControllers[_currentChildIndex];
    BaseChildViewController *toChildVC      = self.childViewControllers[indexPath.item];
    
    CGFloat x_startOfFromChildVC,   x_endOfFromChildVC;
    CGFloat x_startOfToChildVC,     x_endOfToChildVC;
    
    if (indexPath.item          > _currentChildIndex) {
        x_startOfFromChildVC    = 0;
        x_endOfFromChildVC      = -CGRectGetWidth(fromChildVC.view.frame);
        
        x_startOfToChildVC      = CGRectGetWidth(toChildVC.view.frame);
        x_endOfToChildVC        = 0;
    } else if (indexPath.item   < _currentChildIndex) {
        x_startOfFromChildVC    = 0;
        x_endOfFromChildVC      = CGRectGetWidth(fromChildVC.view.frame);
        
        x_startOfToChildVC      = -CGRectGetWidth(toChildVC.view.frame);
        x_endOfToChildVC        = 0;
    }
    
    toChildVC.view.frame        = CGRectMake(
                                             x_startOfToChildVC,
                                             CGRectGetMinY(toChildVC.view.frame),
                                             CGRectGetWidth(toChildVC.view.frame),
                                             CGRectGetHeight(toChildVC.view.frame)
                                             );
    
    _currentChildIndex          = indexPath.item;
    
    // Curl 翻页效果
    // UIViewAnimationOptionTransitionCurlUp, UIViewAnimationOptionTransitionCurlDown
    // Flip 翻转效果
    // UIViewAnimationOptionTransitionFlipFromLeft, UIViewAnimationOptionTransitionFlipFromRight
    // UIViewAnimationOptionTransitionFlipFromTop, UIViewAnimationOptionTransitionFlipFromDown
    [self transitionFromViewController:fromChildVC
                      toViewController:toChildVC
                              duration:0.5
                               options:UIViewAnimationOptionTransitionNone
                            animations:^{
                                
                                fromChildVC.view.frame = CGRectMake(
                                                                    x_endOfFromChildVC,
                                                                    CGRectGetMinY(fromChildVC.view.frame),
                                                                    CGRectGetWidth(fromChildVC.view.frame),
                                                                    CGRectGetHeight(fromChildVC.view.frame)
                                                                    );

                                toChildVC.view.frame = CGRectMake(
                                                                  x_endOfToChildVC,
                                                                  CGRectGetMinY(toChildVC.view.frame),
                                                                  CGRectGetWidth(toChildVC.view.frame),
                                                                  CGRectGetHeight(toChildVC.view.frame)
                                                                  );
                                
                            }
                            completion:^(BOOL finished) {
                                [self.view bringSubviewToFront:_collectionView];
                            }];
}

#pragma mark - <BaseChildViewControllerDelegate>

- (void)actionSwipeGesture:(UISwipeGestureRecognizer *)sender {
    NSInteger index = 0;
    NSIndexPath *indexPath;
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            if (_currentChildIndex < _newsTitleDataSourceManager.titles.count - 1) {
                index = _currentChildIndex + 1;
            }
            break;
        case UISwipeGestureRecognizerDirectionRight:
            if (_currentChildIndex > 0) {
                index = _currentChildIndex - 1;
            }
            break;
        default:
            return;
    }
    
    indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    [self didSelectItemAtIndexPath:indexPath];
}

@end
