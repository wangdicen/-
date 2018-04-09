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
#import "RankDetailViewController.h"

@interface RankView()
{
    UIScrollView *_scroll;
}
@end
@implementation RankView


- (instancetype)initWithFrame:(CGRect)frame viewControllerType:(SnackViewControllerName)type
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 20)];
        lbl.text = @"知食 TOP250";
        if(type == NameFruitViewController ||
           type == NameSpicyViewController ||
           type == NameMeatViewController ||
           type == NameSweetViewController)
        {
            lbl.text = @"知食 TOP100";
        }
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
        if(type == NameFruitViewController ||
           type == NameSpicyViewController ||
           type == NameMeatViewController ||
           type == NameSweetViewController)
        {
            [button setTitle:@"全部100种" forState:UIControlStateNormal];
            [button setTitle:@"全部100种" forState:UIControlStateHighlighted];
        }
        [button setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
        [button setTitleColor:FlatWhiteDark forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(goToRankDetailView) forControlEvents:UIControlEventTouchUpInside];
//        button.backgroundColor =[UIColor blueColor];
        [self addSubview:button];

        
    }
    return self;
}


-(void)goToRankDetailView
{
    RankDetailViewController *rdvc = [[RankDetailViewController alloc] initWithType:self.viewcontrollertype];
    rdvc.viewcontrollerName = self.viewcontrollertype;
    rdvc.title = @"TOP 250";
    if(self.viewcontrollertype == NameFruitViewController ||
       self.viewcontrollertype == NameSpicyViewController ||
       self.viewcontrollertype == NameMeatViewController ||
       self.viewcontrollertype == NameSweetViewController)
    {
        rdvc.title = @"TOP 100";
    }
    rdvc.view.backgroundColor = [UIColor whiteColor];
    rdvc.hidesBottomBarWhenPushed = YES;
    [[self viewController].navigationController pushViewController:rdvc animated:YES];
    
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
-(void)setViewcontrollertype:(SnackViewControllerName)viewcontrollertype
{
    _viewcontrollertype = viewcontrollertype;
    [self getInfoFromBackground];

}


-(void)getInfoFromBackground
{
    AVQuery *query = [AVQuery queryWithClassName:@"Snack"];
    [query whereKey:@"classification" equalTo:[self typeString]];
    query.limit = 1000;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:@"stars" ascending:NO];
        NSArray *sortedArr = [objects sortedArrayUsingDescriptors:[NSArray arrayWithObject:des]];
        for (int i = 0; i< 12; i++) {
            if (i>=sortedArr.count) {
                break;
            }
            NSDictionary *object = sortedArr[i];
            OneRankView *orv = [_scroll viewWithTag:i + OneHotOrNewView_TAG];
            AVFile *file = object[@"image"];
            [file getThumbnail:YES width:300 height:357 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
                orv.image = image;
                orv.starfloatNum = [object[@"stars"] floatValue];
                orv.title = object[@"name"];
                orv.objectID = object[@"objectId"];
            }];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
