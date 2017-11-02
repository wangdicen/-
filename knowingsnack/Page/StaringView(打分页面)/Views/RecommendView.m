//
//  RecommendView.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/31.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "RecommendView.h"
#import "Header.h"
#import "OneRecommendView.h"

@interface RecommendView()
{
    UIScrollView *_scroll;
}
@end

@implementation RecommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 20)];
        lbl.text = @"今日推荐";
        lbl.textAlignment = NSTextAlignmentLeft;
        lbl.font = [UIFont boldSystemFontOfSize:15.0f];
        [self addSubview:lbl];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT - 65, 10, 60, 20)];
        [self addSubview:button];
        [button setTitle:@"全部10 >" forState:UIControlStateNormal];
        [button setTitle:@"全部10 >" forState:UIControlStateSelected];
        [button setTitleColor:FlatGray forState:UIControlStateNormal];
        [button setTitleColor:FlatGray forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        
        
        CGFloat hei = frame.size.height;
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, SCREEN_WEIGHT, hei - 20 -20)];
        _scroll.contentSize = CGSizeMake((hei -80 + 10 +20) *10 + 20 , hei - 20 -20);
        _scroll.showsHorizontalScrollIndicator = NO;
        
        
        for (int i = 0; i < 10; i++) {
            OneRecommendView *orv = [[OneRecommendView alloc] initWithFrame:CGRectMake(20 + (20 + hei - 80 + 10)*i, 10, hei -80 + 10, hei - 80)];
            orv.tag = OneRecommendView_TAG + i;
            [_scroll addSubview:orv];
        }
        
        [self addSubview:_scroll];
    }
    return self;
}




-(void)fetchDataInBackground
{
    AVQuery *query = [AVQuery queryWithClassName:@"Recommand_Daily"];
    [query whereKey:@"type" equalTo:@"snack"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {

        int i = 0;
        for (AVObject *object in objects) {

            OneRecommendView *view = [_scroll viewWithTag:OneRecommendView_TAG + i];
            
            AVFile *file = object[@"image"];

            [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                view.image = [UIImage imageWithData:data];
                view.title = object[@"title"];
                view.text = object[@"text"];

            }];

            i ++;
        }
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
