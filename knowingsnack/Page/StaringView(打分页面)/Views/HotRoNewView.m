//
//  HotRoNewView.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/11/1.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "HotRoNewView.h"
#import "Header.h"
#import "OneHotRoNewView.h"

@interface HotRoNewView()
{
    UILabel *_lbl;
    UIScrollView *_scroll;
}
@end

@implementation HotRoNewView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 20)];
        _lbl.text = @"近期热门";
        _lbl.textAlignment = NSTextAlignmentLeft;
        _lbl.font = [UIFont boldSystemFontOfSize:15.0f];
        [self addSubview:_lbl];
        
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT - 65, 10, 60, 20)];
//        [self addSubview:button];
//        [button setTitle:@"全部32 >" forState:UIControlStateNormal];
//        [button setTitle:@"全部32 >" forState:UIControlStateSelected];
//        [button setTitleColor:FlatGray forState:UIControlStateNormal];
//        [button setTitleColor:FlatGray forState:UIControlStateSelected];
//        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        
        
        CGFloat hei = frame.size.height;
        
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, SCREEN_WEIGHT, hei - 20 -20)];
        _scroll.contentSize = CGSizeMake((hei -80 + 10 +20 -10) *10 + 20 , hei - 20 -20);
        _scroll.showsHorizontalScrollIndicator = NO;
        
        
        for (int i = 0; i < 10; i++) {
              OneHotRoNewView *orv = [[OneHotRoNewView alloc] initWithFrame:CGRectMake(20 + (20 + hei - 20 -60)*i, 5, hei -20 - 60 , hei - 50)];
              orv.tag = OneHotOrNewView_TAG + i;
              [_scroll addSubview:orv];
//            orv.alpha = 0.0f;
        }
        
        [self addSubview:_scroll];
    }
    return self;
}



-(void)fetchDataInBackground
{
    AVQuery *query = [AVQuery queryWithClassName:@"Snack"];
    if(self.type == Hot)
    {
        [query whereKey:@"isHot" equalTo:@(YES)];
        _lbl.text = @"知食热门";
    }
    else if(self.type == New)
    {
         [query whereKey:@"isNew" equalTo:@(YES)];
        _lbl.text = @"新品推荐";
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        int i = 0;
        for (AVObject *object in objects) {
            
            if ([object[@"classification"] isEqualToString:[self typeString]]) {
                OneHotRoNewView *view = [_scroll viewWithTag:OneHotOrNewView_TAG + i];
                AVFile *file = object[@"image"];
                [file getThumbnail:YES width:300 height:357 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
                    view.image = image;
                    view.title = object[@"name"];
                    view.starfloatNum = [object[@"stars"] floatValue];
                    view.alpha = 1.0f;
                    view.objectID = object[@"objectId"];
                }];
//                [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
//                    view.image = [UIImage imageWithData:data];
//                    view.title = object[@"name"];
//                    view.starfloatNum = [object[@"stars"] floatValue];
//                    view.alpha = 1.0f;
//                    view.objectID = object[@"objectId"];
//                }];
                
                i ++;
            }
            else
            {
                
            }
            
        }
    }];
}


-(NSString *)typeString
{
    switch (self.viewcontrollertype) {
        case NameSnackViewController:
            return @"snack";
            break;
        case NameDrinkViewController:
            return @"drink";
            break;
        case NameMeatViewController:
            return @"meat";
            break;
        case NameFruitViewController:
            return @"fruit";
            break;
        case NameSpicyViewController:
            return @"spicy";
            break;
        case NameSweetViewController:
            return @"sweet";
            break;
        case NameFangBianViewController:
            return @"fangbian";
            break;
        default:
            break;
    }
    
}

@end
