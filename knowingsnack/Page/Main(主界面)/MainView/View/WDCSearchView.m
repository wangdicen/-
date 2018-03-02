//
//  WDCSearchView.m
//  knowingsnack
//
//  Created by travelsky on 2018/2/28.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "WDCSearchView.h"
#import "Header.h"
#import "SearchDetailViewController.h"

@interface WDCSearchView()
{
//    UIButton *_hot1;
//    UIButton *_hot2;
//    UIButton *_hot3;
    
    UIButton *_regular1;
    UIButton *_regular2;
    UIButton *_regular3;
    UIButton *_regular4;
    UIButton *_regular5;
}
@end

@implementation WDCSearchView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
        [self addSubview:lbl];
        lbl.text = @"热门搜索";
        lbl.font = [UIFont fontWithName:@"Arial" size:14.f];
        lbl.textColor = FlatGray;
        
        
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 60, 25)];
        image1.image = [UIImage imageNamed:@"orange_kuang"];
        [self addSubview:image1];
        image1.userInteractionEnabled = YES;
        
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 60+5, 50, 60, 25)];
        image2.image = [UIImage imageNamed:@"orange_kuang"];
        [self addSubview:image2];
        image2.userInteractionEnabled = YES;

        
        UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (60+5)*2, 50, 60, 25)];
        image3.image = [UIImage imageNamed:@"orange_kuang"];
        [self addSubview:image3];
        image3.userInteractionEnabled = YES;

        
        UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (60+5)*3, 50, 60, 25)];
        image4.image = [UIImage imageNamed:@"orange_kuang"];
        [self addSubview:image4];
        image4.userInteractionEnabled = YES;

        
        UIImageView *image5 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (60+5)*4, 50, 60, 25)];
        image5.image = [UIImage imageNamed:@"orange_kuang"];
        [self addSubview:image5];
        image5.userInteractionEnabled = YES;

        
        //______________________________________________________
        
        _regular1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
        [image1 addSubview:_regular1];
        [_regular1 setTitle:@"可口可乐" forState:UIControlStateNormal];
        _regular1.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.f];
        [_regular1 setTitleColor:FlatOrange forState:UIControlStateNormal];
        _regular1.backgroundColor = ClearColor;
        [_regular1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        _regular2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
        [image2 addSubview:_regular2];
        [_regular2 setTitle:@"抹茶" forState:UIControlStateNormal];
        _regular2.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.f];
        [_regular2 setTitleColor:FlatOrange forState:UIControlStateNormal];
        _regular2.backgroundColor = ClearColor;
        [_regular2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        
        _regular3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
        [image3 addSubview:_regular3];
        [_regular3 setTitle:@"橙" forState:UIControlStateNormal];
        _regular3.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.f];
        [_regular3 setTitleColor:FlatOrange forState:UIControlStateNormal];
        _regular3.backgroundColor = ClearColor;
        [_regular3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        
        _regular4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
        [image4 addSubview:_regular4];
        [_regular4 setTitle:@"烧烤" forState:UIControlStateNormal];
        _regular4.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.f];
        [_regular4 setTitleColor:FlatOrange forState:UIControlStateNormal];
        _regular4.backgroundColor = ClearColor;
        [_regular4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        
        _regular5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
        [image5 addSubview:_regular5];
        [_regular5 setTitle:@"自热火锅" forState:UIControlStateNormal];
        _regular5.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.f];
        [_regular5 setTitleColor:FlatOrange forState:UIControlStateNormal];
        _regular5.backgroundColor = ClearColor;
        [_regular5 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        
        
    }
    return self;
}


-(void)btnAction:(UIButton *)sender
{
    SearchDetailViewController *sdvc = [[SearchDetailViewController alloc] init];
    sdvc.title = sender.titleLabel.text;
    sdvc.searchText = sender.titleLabel.text;
    sdvc.hidesBottomBarWhenPushed = YES;
    [[self viewController].navigationController pushViewController:sdvc animated:YES];
}

//获得view所在的controller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
