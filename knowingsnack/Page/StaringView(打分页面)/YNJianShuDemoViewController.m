//
//  YNJianShuDemoViewController.m
//  YNPageScrollViewController
//
//  Created by ZYN on 16/7/19.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "YNJianShuDemoViewController.h"
#import "Header.h"

@interface YNJianShuDemoViewController ()
/// 自定义线条
@property (nonatomic, strong)  UIView *lineView;

@end

@implementation YNJianShuDemoViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"简书Demo";
    
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    [self.scrollViewMenu addSubview:self.lineView];
    
}

- (UIView *)lineView {
    
    if (!_lineView) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollViewMenu.frame.size.height - 0, self.scrollViewMenu.frame.size.width, 1)];
        _lineView = lineView;
        _lineView.backgroundColor = [UIColor colorWithComplementaryFlatColorOf:FlatWhiteDark withAlpha:0.8];
    }
    return _lineView;
    
}


@end
