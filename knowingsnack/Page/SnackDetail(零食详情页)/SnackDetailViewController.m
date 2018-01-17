//
//  SnackDetailViewController.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/18.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "SnackDetailViewController.h"
#import "Header.h"
#import "StaringVIewInSD.h"


@interface SnackDetailViewController ()<UIScrollViewDelegate>
{
    UIImageView *_mainImageView;
    UIView *_mainImageViewBackground;
    UIScrollView *_scrollview;
    StaringVIewInSD *_staringViewInSD;
    
    UILabel *_SnackName;
    
    UILabel *_titleView;
    UIView *_newTitleView;
    
    UIView *_twoButton;
}
@end

@implementation SnackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    [self.view addSubview:_scrollview];
    _scrollview.contentSize = CGSizeMake(SCREEN_WEIGHT, SCREEN_HEIGHT *3.0f);
    _scrollview.delegate = self;
    _scrollview.backgroundColor = rgb(244, 249, 242);
    
    _mainImageViewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/2.0)];
    [_scrollview addSubview:_mainImageViewBackground];
    
    
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_HEIGHT/2.0 +44.0f - 150.f) * 142/172.0f, SCREEN_HEIGHT/2.0 +44.0f - 150.f)];
    _mainImageView.center =  CGPointMake(_mainImageViewBackground.frame.size.width/2.0f, _mainImageView.frame.size.height/2.0f + 45);
    [_scrollview addSubview:_mainImageView];
    
    _mainImageView.image = [UIImage imageNamed:@"demo"];
    _mainImageViewBackground.backgroundColor = [UIColor colorWithAverageColorFromImage:_mainImageView.image];
    
    _staringViewInSD = [[StaringVIewInSD alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    _staringViewInSD.center = CGPointMake(SCREEN_WEIGHT*4/5.0f, SCREEN_HEIGHT/2.0 + 80 );
    _staringViewInSD.starNum = 5;
    [_scrollview addSubview:_staringViewInSD];
    
    
    
    _SnackName = [[UILabel alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2.0 + 10, SCREEN_WEIGHT*3/5.0f - 15.0f, 120)];
    [_scrollview addSubview:_SnackName];
    _SnackName.textAlignment = NSTextAlignmentLeft;
    _SnackName.numberOfLines = 2.0f;
    _SnackName.text = @"大波浪薯片:铁板鱿鱼味";
    _SnackName.font = [UIFont boldSystemFontOfSize:23];
    
    _newTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    _newTitleView.layer.cornerRadius = 14.0f;
    _newTitleView.backgroundColor = [UIColor whiteColor];

    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 100, 24)];
    lbl.text = @"🔥757人正在热议..";
    lbl.textColor = FlatBlack;
    lbl.font = [UIFont systemFontOfSize:11.0f];
    [_newTitleView addSubview:lbl];
    

    _titleView =(UILabel *)self.navigationItem.titleView;
    self.navigationItem.titleView = _newTitleView;
    
    _twoButton = [[UIView alloc] initWithFrame:CGRectMake(0, _staringViewInSD.center.y + _staringViewInSD.frame.size.height/2.0f + 20, SCREEN_WEIGHT, 60)];
    [self.view addSubview:_twoButton];
    _twoButton.backgroundColor = rgb(236, 241, 237);
    
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat imageH = _staringViewInSD.center.y + _staringViewInSD.frame.size.height/2.0f + 20;


    if (offsetY > imageH) {
        self.navigationItem.titleView = _titleView;
    }
    else
    {
        self.navigationItem.titleView = _newTitleView;
    }
    
    // 该判断是实现scrollView内部的子控件悬停效果
    if (offsetY >= imageH) {
        // 将红色控件添加到控制器的view中，设置Y值为0
        CGRect redF = _twoButton.frame;
        redF.origin.y = 64.0f;
        _twoButton.frame = redF;
        [_twoButton removeFromSuperview];
        [self.view addSubview:_twoButton];
    }else{
        // 将红色控件添加到scrollView中，设置Y值为图片的高度
        CGRect redF = _twoButton.frame;
        redF.origin.y = _staringViewInSD.center.y + _staringViewInSD.frame.size.height/2.0f + 20;
        _twoButton.frame = redF;
        [_twoButton removeFromSuperview];
        [_scrollview addSubview:_twoButton];
    }
    
//    // 实现下拉放大顶部图片效果
//    CGFloat scale = 1 - (offsetY / 70);
//    scale = (scale >= 1) ? scale : 1;
//    self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
