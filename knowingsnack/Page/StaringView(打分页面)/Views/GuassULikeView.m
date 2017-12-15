//
//  GuassULikeView.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/13.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "GuassULikeView.h"
#import "CWStarRateView.h"
#import "Chameleon.h"
#import "Header.h"

@interface GuassULikeView()
{
    UIImageView *_imageview;
    UILabel *_titlelbl;
    CWStarRateView *_starview;
    UILabel *_starnumlbl;
    UILabel *_factorylbl;
    UILabel *_aboutkindlbl;
    UILabel *_onetextlbl;
    UIButton *_morebutton;
}
@end

@implementation GuassULikeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height = frame.size.height;
        
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, (height -30.0f) * 147.0/172.0f, height -30.0f)];
        _imageview.backgroundColor = FlatWhiteDark;
        _imageview.layer.shadowOpacity = 0.7;
        _imageview.layer.shadowColor = FlatGray.CGColor;
        _imageview.layer.shadowRadius = 5;
        _imageview.layer.shadowOffset = CGSizeMake(6, 6);
        [self addSubview:_imageview];
        
        _titlelbl =[[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15,
                                                             15,
                                                             SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30,
                                                             (height - 30)/5.0f)];
        [self addSubview:_titlelbl];
        _titlelbl.text = @"旺旺仙贝";
        _titlelbl.font = [UIFont boldSystemFontOfSize:18.0f];
        _titlelbl.textColor = [UIColor blackColor];
        
        _starview = [[CWStarRateView alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15, 15 + CGRectGetHeight(_titlelbl.frame) + 2, 80, 25)];
        _starview.allowIncompleteStar = YES;
        _starview.userInteractionEnabled = NO;
        [self addSubview:_starview];
        
        _starnumlbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15 +85, 15 + CGRectGetHeight(_titlelbl.frame) + 2, 30, 25)];
        [self addSubview:_starnumlbl];
        _starnumlbl.textColor = FlatGray;
        _starnumlbl.text = @"10.0";
        _starnumlbl.font = [UIFont systemFontOfSize:14.0f];
        
        _factorylbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15,
                                                                15 + CGRectGetHeight(_titlelbl.frame) + CGRectGetHeight(_starview.frame) + 4,
                                                                SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30,
                                                                18)];
        [self addSubview:_factorylbl];
        _factorylbl.textColor = FlatGray;
        _factorylbl.text = @"厂商：隔壁二大爷开的零食小卖部";
        _factorylbl.font = [UIFont systemFontOfSize:10.0f];
        

        _aboutkindlbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15,
                                                                  15 + CGRectGetHeight(_titlelbl.frame) + CGRectGetHeight(_starview.frame)+ CGRectGetHeight(_factorylbl.frame)+ 6,
                                                                  SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30,
                                                                  18)];
        [self addSubview:_aboutkindlbl];
        _aboutkindlbl.textColor = FlatGray;
        _aboutkindlbl.text = @"抹茶/饼干/重口味/甜食";
        _aboutkindlbl.font = [UIFont systemFontOfSize:10.0f];
        
        
        _onetextlbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15, height - 35,  SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30, 20)];
        [self addSubview:_onetextlbl];
        _onetextlbl.textColor = FlatBlackDark;
        _onetextlbl.text = @"2000+重口味的推荐";
        _onetextlbl.font = [UIFont systemFontOfSize:12.0f];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15, height - 52,  SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30 - 5, 1)];
        line1.backgroundColor = RGB(233, 233, 233, 0.6);
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1,  SCREEN_WEIGHT, 1)];
        line2.backgroundColor = RGB(233, 233, 233, 0.6);
        [self addSubview:line2];
        
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
