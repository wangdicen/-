//
//  WDCPlusButtonSubclass.m
//  Exercise
//
//  Created by 汪迪岑 on 2017/10/23.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "WDCPlusButtonSubclass.h"
#import "Chameleon.h"
#import "UIImage+ChangeImageColor.h"
#import "PlusViewController.h"


@implementation WDCPlusButtonSubclass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(void)load {
    [super registerSubclass];
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //        self.adjustsImageWhenHighlighted = NO;
        
    }
    
    return self;
}


+ (instancetype)plusButton
{
    
    UIImage *buttonImage = [UIImage imageNamed:@"tab_publish_add"];
    UIImage *highlightImage = [UIImage imageNamed:@"tab_publish_add_pressed"];
    UIImage *iconImage = [UIImage imageNamed:@"tab_publish_add"];
    UIImage *highlightIconImage = [UIImage imageNamed:@"tab_publish_add_pressed"];
    
    WDCPlusButtonSubclass *button = [WDCPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = ClearColor;
    
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:iconImage forState:UIControlStateNormal];
    [button setImage:highlightIconImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    ;
}


- (void)clickPublish {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddButtonClicked" object:nil];
    
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

@end
