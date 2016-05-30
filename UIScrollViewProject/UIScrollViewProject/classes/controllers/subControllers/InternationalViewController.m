//
//  InternationalViewController.m
//  SwitchController
//
//  Created by fangjs on 16/5/30.
//  Copyright © 2016年 fangjs. All rights reserved.

/**  UIScrollView 的悬停效果  **/



#import "InternationalViewController.h"

@interface InternationalViewController ()<UIScrollViewDelegate>

/**redView*/
@property (weak , nonatomic) UIView *redView;
/**imageView*/
@property (weak , nonatomic) UIImageView *imageView;

@end


@implementation InternationalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    imageView.image = [UIImage imageNamed:@"ad_00"];
    self.imageView = imageView;
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, ScreenWidth, 44)];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    
    UIView *otherView = [[UIView alloc] initWithFrame:CGRectMake(0, 184, ScreenWidth, 600)];
    otherView.backgroundColor = [UIColor magentaColor];
    
    scroll.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(otherView.frame));
    
    [scroll addSubview:imageView];
    [scroll addSubview:redView];
    [scroll addSubview:otherView];
    
    
    [self.view addSubview:scroll];

}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGFloat offsetY = offset.y / 70;
    CGFloat scale = 1 - offsetY;
    
    scale = (scale > 1)? scale : 1;
    self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (offset.y > 140) {
        self.redView.frame = CGRectMake(0, 0, ScreenWidth, 44);
        [self.view addSubview:self.redView];
    }else {
        self.redView.frame = CGRectMake(0, 140, ScreenWidth, 44);
        [scrollView addSubview:self.redView];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
