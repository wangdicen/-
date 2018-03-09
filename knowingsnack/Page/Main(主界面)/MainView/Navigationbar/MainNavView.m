//
//  MainNavView.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "MainNavView.h"
#import "Chameleon.h"
#import "Header.h"
#import "RigisterViewController.h"
#import "SearchDetailViewController.h"

@interface MainNavView()
{
    
}
@end

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
    _searchbar = [[UISearchBar alloc] init];
    _searchbar.delegate = self;
    _searchbar.backgroundColor = [UIColor whiteColor];
    _searchbar.frame = CGRectMake(0, 0, SCREEN_WEIGHT *0.80f, 28);
    _searchbar.layer.cornerRadius = 5;
    _searchbar.layer.masksToBounds = YES;
    //边框线粗细
    [_searchbar.layer setBorderWidth:1];
    //设置边框为白色是为了盖住UISearchBar上的灰色
    [_searchbar.layer setBorderColor:FlatWhite.CGColor];
    _searchbar.placeholder=@"零食 饮料 泡面 奶茶等";
    
    //通过kvc来设置placeholder的字体和颜色
    UITextField * searchField = [_searchbar valueForKey:@"_searchField"];
    [searchField setValue:FlatGray forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont fontWithName:@"Arial" size:14] forKeyPath:@"_placeholderLabel.font"];
    
    [self addSubview:_searchbar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidesKeyboard) name:@"hidesKeyboard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard) name:@"showKeyboard" object:nil];
}

- (void)hidesKeyboard
{
    [_searchbar resignFirstResponder];
}

- (void)showKeyboard
{
    [_searchbar becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hidesKeyboard" object:nil];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChatBtn_changeToCancel" object:nil];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:_searchbar.text,@"text", nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"goToSearchDetail"
                                                        object:nil userInfo:info];
    _searchbar.text = nil;
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
