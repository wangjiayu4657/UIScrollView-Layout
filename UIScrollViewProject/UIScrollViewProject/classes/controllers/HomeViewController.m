//
//  HomeViewController.m
//  UIScrollViewProject
//
//  Created by fangjs on 16/5/30.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "HomeViewController.h"
#import "InternationalViewController.h"
#import "MilitaryViewController.h"
#import "SocialViewController.h"
#import "PoliticalViewController.h"
#import "EconomicViewController.h"
#import "SportsViewController.h"
#import "EntertainmentViewController.h"
#import "MyLabel.h"

@interface HomeViewController ()<UIScrollViewDelegate>

/**titleScrollView*/
@property (strong , nonatomic) UIScrollView *titleScrollView;

/**contentScrollView*/
@property (strong , nonatomic) UIScrollView *contentScrollView;

/**当前显示的控制器*/
@property (strong , nonatomic)  UIViewController *showingVC;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpScrollView];
    
    [self setUpChildController];
    
    [self setUpTitle];
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    [self scrollViewDidScroll:self.contentScrollView];
}

//初始化 UIScrollView
- (void) setUpScrollView {
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 35)];
    self.titleScrollView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.titleScrollView];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 99, ScreenWidth, ScreenHeight - 99)];
    self.contentScrollView.backgroundColor = [UIColor lightGrayColor];
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
    self.contentScrollView.pagingEnabled = YES;
    [self.view addSubview:self.contentScrollView];
}

//设置label标题
- (void) setUpTitle {
    CGFloat labelX = 0;
    CGFloat labelW = 100;
    CGFloat labelH = 35;
    NSInteger count = self.childViewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
        MyLabel *label = [[MyLabel alloc] init];
        label.tag = i;
        labelX = i * labelW;
        label.text = [self.childViewControllers[i] title];
        label.frame = CGRectMake(labelX, 0, labelW, labelH);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelCilck:)];
        [label addGestureRecognizer:tap];
        [self.titleScrollView addSubview:label];
    }
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(count * ScreenWidth, 0);
}

//添加控制器
- (void) setUpChildController {
    InternationalViewController *internationalVC = [[InternationalViewController alloc] init];
    internationalVC.title = @"国际";
    [self addChildViewController:internationalVC];
    
    MilitaryViewController *militaryVC = [[MilitaryViewController alloc] init];
    militaryVC.title = @"军事";
    [self addChildViewController:militaryVC];
    
    SocialViewController *socialVC = [[SocialViewController alloc] init];
    socialVC.title = @"社会";
    [self addChildViewController:socialVC];
    
    PoliticalViewController *politicalVC = [[PoliticalViewController alloc] init];
    politicalVC.title = @"政治";
    [self addChildViewController:politicalVC];
    
    EconomicViewController *economicVC = [[EconomicViewController alloc] init];
    economicVC.title = @"经济";
    [self addChildViewController:economicVC];
    
    SportsViewController *sportsVC = [[SportsViewController alloc] init];
    sportsVC.title = @"体育";
    [self addChildViewController:sportsVC];
    
    EntertainmentViewController *entertainmentVC = [[EntertainmentViewController alloc] init];
    entertainmentVC.title = @"娱乐";
    [self addChildViewController:entertainmentVC];
    
}

// 点击 label 时的响应事件
- (void) labelCilck:(UITapGestureRecognizer *) tap {
    NSInteger index = tap.view.tag;
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * ScreenWidth;
    // 设置 UIScrollView 偏移时的动画
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //让对应的顶部 label 的标题居中
    UILabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    //左边超出处理
    titleOffset.x = label.center.x - ScreenWidth / 2;
    if (titleOffset.x < 0) titleOffset.x = 0;
    
    //右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - ScreenWidth;
    if (titleOffset.x >= maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    self.showingVC = self.childViewControllers[index];
    if ([self.showingVC isViewLoaded]) return;
    
    self.showingVC.view.frame = CGRectMake(offsetX, 0, ScreenWidth, scrollView.frame.size.height);
    [self.contentScrollView addSubview:self.showingVC.view];
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scale = scrollView.contentOffset.x / ScreenWidth;
    if(scale< 0 || scale > self.titleScrollView.subviews.count - 1) return;
    
    //需要获取操作的左边 label
    NSInteger leftIndex = scale;
    MyLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    //需要获取操作的右边 label
    NSInteger rightIndex = leftIndex + 1;
    if(rightIndex == self.titleScrollView.subviews.count - 1) return;
    MyLabel *rightLabel = self.titleScrollView.subviews[rightIndex];
    
    //右边比例
    CGFloat rightScale = scale - leftIndex;
    //左边比例
    CGFloat leftScale =  1 - rightScale;
    
    //设置 label 字体的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}


- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}



@end
