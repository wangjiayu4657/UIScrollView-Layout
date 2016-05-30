//
//  MyLabel.m
//  UIScrollViewProject
//
//  Created by fangjs on 16/5/30.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "MyLabel.h"


static const CGFloat YJred = 0.4;
static const CGFloat YJblue = 0.6;
static const CGFloat YJgreen = 0.7;

@implementation MyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor colorWithRed:YJred green:YJgreen blue:YJblue alpha:1.0];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;

    CGFloat red = YJred + (1 - YJred) *scale;
    CGFloat green = YJgreen + (0 - YJgreen) * scale;
    CGFloat blue = YJblue + (0 - YJblue) * scale;
    
    
    [self setTextColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0]];
//    self.backgroundColor = [UIColor colorWithRed:1 - scale green:0 blue:0 alpha:1.0];
    
    
    CGFloat transformScale = 1 + scale * 0.3;
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
