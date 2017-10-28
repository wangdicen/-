//
//  LunchView.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/27.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "LunchView.h"
#import "Header.h"

@implementation LunchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = FlatWhite;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_WEIGHT)];
        [self addSubview:imageview];
        imageview.image = IMAGE(@"lunch");
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_WEIGHT + 90, 97, 53)];
        lbl.text = @"知食";
        lbl.font = [UIFont systemFontOfSize:46];
        [self addSubview:lbl];
        
        UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(10, SCREEN_WEIGHT + 90+55, 180, 21)];
        lbl2.text = @"看见什么吃什么";
        lbl2.font = [UIFont systemFontOfSize:17];
        [self addSubview:lbl2];
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
