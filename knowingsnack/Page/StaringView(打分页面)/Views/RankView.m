//
//  RankView.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/13.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "RankView.h"
#import "Chameleon.h"
#import "Header.h"
#import "OneRankView.h"

@interface RankView()
{
    UIScrollView *_scroll;
}
@end
@implementation RankView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 20)];
        lbl.text = @"知食 TOP250";
        lbl.textAlignment = NSTextAlignmentLeft;
        lbl.font = [UIFont boldSystemFontOfSize:15.0f];
        [self addSubview:lbl];
        
        CGFloat hei = frame.size.height;
        
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                 35,
                                                                 SCREEN_WEIGHT,
                                                                 hei - 35 - 25)];
        _scroll.contentSize = CGSizeMake((SCREEN_WEIGHT -(hei - 35 - 25)/4.0f)*3.0f +40.0f,
                                         hei - 35 - 25);
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.pagingEnabled = YES;
        
        CGFloat scrollheight = _scroll.frame.size.height;
        
        for (int i = 0; i<4; i++) {
            OneRankView *orv = [[OneRankView alloc] initWithFrame:CGRectMake(0,
                                                                             i * scrollheight/4.0,
                                                                             SCREEN_WEIGHT - 40,
                                                                             scrollheight/4.0)];
            orv.tag = OneHotOrNewView_TAG + i;
            orv.rankNum = i +1;
            [_scroll addSubview:orv];
        }
        for (int i = 4; i<8; i++) {
            OneRankView *orv = [[OneRankView alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT - 40,
                                                                             (i - 4) * scrollheight/4.0,
                                                                             SCREEN_WEIGHT - 40,
                                                                             scrollheight/4.0)];
            orv.tag = OneHotOrNewView_TAG + i;
            orv.rankNum = i +1;
            [_scroll addSubview:orv];
        }
        for (int i = 8; i<12; i++) {
            OneRankView *orv = [[OneRankView alloc] initWithFrame:CGRectMake((SCREEN_WEIGHT - 40)*2,
                                                                             (i -8) * scrollheight/4.0,
                                                                             SCREEN_WEIGHT,
                                                                             scrollheight/4.0)];
            orv.tag = OneHotOrNewView_TAG + i;
            orv.rankNum = i +1;
            [_scroll addSubview:orv];
        }
        
//        for (int i = 0; i < 10; i++) {
//            OneHotRoNewView *orv = [[OneHotRoNewView alloc] initWithFrame:CGRectMake(20 + (20 + hei - 20 -60)*i, 10, hei -20 - 60 , hei - 20)];
//            orv.tag = OneHotOrNewView_TAG + i;
//            [_scroll addSubview:orv];
//        }
        
        [self addSubview:_scroll];
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, hei - 30, SCREEN_WEIGHT, 30)];
        [button setTitle:@"全部250种" forState:UIControlStateNormal];
        [button setTitle:@"全部250种" forState:UIControlStateHighlighted];
        [button setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
        [button setTitleColor:FlatWhiteDark forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
//        button.backgroundColor =[UIColor blueColor];
        [self addSubview:button];

        
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
