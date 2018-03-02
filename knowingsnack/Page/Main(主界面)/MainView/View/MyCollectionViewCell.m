//
//  MyCollectionViewCell.m
//  knowingsnack
//
//  Created by travelsky on 2018/2/28.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "Header.h"
#import "SnackDetailViewController.h"

@implementation MyCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _topImage.backgroundColor = FlatWhite;
        _topImage.layer.borderWidth = 1.f;
        _topImage.layer.borderColor = FlatGray.CGColor;
        [self.contentView addSubview:_topImage];
        
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(1, frame.size.height - 40 - 1, frame.size.width -2, 40 -1)];
        [self.contentView addSubview:background];
        background.backgroundColor = RGB(241,236,226,1);
        
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, frame.size.width, 20)];
        [background addSubview:_botlabel];
        _botlabel.font = [UIFont boldSystemFontOfSize:11.0f];
        _botlabel.textColor = RGB(166,147,108,1);
        _botlabel.text = @"加载中···";
        
        
        _starview = [[CWStarRateView alloc] initWithFrame:CGRectMake(5, 20, frame.size.width /3.0f, 20)];
        //        _starview.scorePercent = 0.8;
        _starview.allowIncompleteStar = YES;
        _starview.delegate = self;
        _starview.userInteractionEnabled = NO;
        [background addSubview:_starview];
        
        
        _starNum = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width /3.0f + 15, 20, frame.size.width/3.0, 20)];
        [background addSubview:_starNum];
        _starNum.textColor = RGB(166,147,108,1);
        _starNum.font = [UIFont systemFontOfSize:7.0f];
        _starNum.text = @"10.0";
    }
    
    return self;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SnackDetailViewController *sdvc = [[SnackDetailViewController alloc] init];
    [sdvc setHidesBottomBarWhenPushed:YES];
    [[self viewController].navigationController pushViewController:sdvc animated:YES];
    
    sdvc.title = _botlabel.text;
    sdvc.name = _botlabel.text;
    sdvc.image = _topImage.image;
    sdvc.stars = _starview.scorePercent * 5.0f;
    sdvc.view.backgroundColor = FlatWhite;
    sdvc.objectId = self.objectID;
    
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
