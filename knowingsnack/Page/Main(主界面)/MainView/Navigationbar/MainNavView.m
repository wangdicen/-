//
//  MainNavView.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "MainNavView.h"
#import "Chameleon.h"
#import "Header.h"
#import "RigisterViewController.h"

@implementation MainNavView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    UISearchBar *searchbar = [[UISearchBar alloc] init];
    searchbar.delegate = self;
    searchbar.frame = CGRectMake(0, 0, SCREEN_WEIGHT *0.80f, 28);
    searchbar.layer.cornerRadius = 5;
    searchbar.layer.masksToBounds = YES;
    //边框线粗细
    [searchbar.layer setBorderWidth:1];
    //设置边框为白色是为了盖住UISearchBar上的灰色
    [searchbar.layer setBorderColor:FlatWhite.CGColor];
    searchbar.placeholder=@"零食 饮料 泡面 奶茶等";
    
    //通过kvc来设置placeholder的字体和颜色
    UITextField * searchField = [searchbar valueForKey:@"_searchField"];
    [searchField setValue:FlatGray forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont fontWithName:@"Arial" size:14] forKeyPath:@"_placeholderLabel.font"];
    
    [self addSubview:searchbar];
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
//    btn.backgroundColor = FlatBlue;
////    btn.backgroundColor = ClearColor;
//    [btn setImage:IMAGE(@"setting_review") forState:UIControlStateNormal];
//    [btn setImage:IMAGE(@"setting_review") forState:UIControlStateSelected];
//
//    [searchbar addSubview:btn];
//    btn.center = CGPointMake(searchbar.frame.size.width - 28/2.0, searchbar.frame.size.height /2.0f);
    
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
