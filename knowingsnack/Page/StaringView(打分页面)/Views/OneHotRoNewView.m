//
//  OneHotRoNewView.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/11/1.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "OneHotRoNewView.h"
#import "Header.h"
#import "CWStarRateView.h"

@interface OneHotRoNewView()<CWStarRateViewDelegate>
{
    UIImageView *_imageview;
    UILabel *_label;
    CWStarRateView *_starview;
    UILabel *_starNum;
}
@end

@implementation OneHotRoNewView



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageview];
        _imageview.backgroundColor = FlatWhite;
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 80, frame.size.width, 50)];
        [self addSubview:background];
        background.backgroundColor = FlatTealDark;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, frame.size.width, 30)];
        [background addSubview:_label];
        _label.font = [UIFont boldSystemFontOfSize:12.0f];
        _label.textColor = [UIColor whiteColor];
        _label.text = @"旺旺雪饼";
        
        _starview = [[CWStarRateView alloc] initWithFrame:CGRectMake(5, 27, frame.size.width /2.0f, 15)];
//        _starview.scorePercent = 0.8;
        _starview.allowIncompleteStar = YES;
        _starview.delegate = self;
        _starview.userInteractionEnabled = NO;
        [background addSubview:_starview];
        
        
        _starNum = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width /2.0f + 10, 27, frame.size.width/2.0, 15)];
        [background addSubview:_starNum];
        _starNum.textColor = FlatWhite;
        _starNum.font = [UIFont systemFontOfSize:10.0f];
        _starNum.text = @"8.0";
    }
    return self;
}


-(void)setImage:(UIImage *)image
{
    _image = image;
    _imageview.image = image;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _label.text = title;
}

-(void)setStarfloatNum:(CGFloat)starfloatNum
{
    _starfloatNum = starfloatNum;
    _starview.scorePercent = starfloatNum/5.0f;
    
    
    _starNum.text = [NSString stringWithFormat:@"%.1f",starfloatNum * 2];
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
