//
//  OneRankView.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/13.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "OneRankView.h"
#import "Chameleon.h"
#import "CWStarRateView.h"
#import "SnackDetailViewController.h"

@interface OneRankView()<CWStarRateViewDelegate>
{
    UILabel *_ranklbl;
    UIImageView *_imageview;
    UILabel *_titlelbl;
    UILabel *_commentNumLbl;
    CWStarRateView *_starview;
    UILabel *_starlbl;
    
}
@end

@implementation OneRankView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        CGFloat height = frame.size.height;
        CGFloat width = frame.size.width;
        
        _ranklbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, height - 10.0f, height - 10)];
        [self addSubview:_ranklbl];
        _ranklbl.text = [NSString stringWithFormat:@"%d",(int)_rankNum];
        _ranklbl.textColor = [UIColor blackColor];
        _ranklbl.textAlignment = NSTextAlignmentCenter;
        _ranklbl.font = [UIFont systemFontOfSize:15];
        _ranklbl.backgroundColor = [UIColor clearColor];
        
        
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5 + height - 10.0f + 5,
                                                                   5,
                                                                   (height - 10.0f)*2.0/3.0f,
                                                                   height - 10.0f)];
        [self addSubview:_imageview];
        _imageview.backgroundColor = FlatWhite;
        _imageview.layer.borderWidth = 1;
        _imageview.layer.borderColor = [FlatWhiteDark CGColor];
        
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(5 + height - 10.0f + 5 + (height - 10.0f)*2.0/3.0f + 5,
                                                                      0,
                                                                      width - (5 + height - 10.0f + 5 + (height - 10.0f)*2.0/3.0f + 5),
                                                                      height)];
        [self addSubview:background];
        background.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5 + height - 10.0f + 5 + (height - 10.0f)*2.0/3.0f + 5,
                                                                height -1,
                                                                width - (5 + height - 10.0f + 5 + (height - 10.0f)*2.0/3.0f + 5),
                                                                1.0f)];
        line.backgroundColor = FlatWhite;
        [self addSubview:line];
        
        _titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(5,
                                                              5,
                                                              background.frame.size.width - 10.0f,
                                                              background.frame.size.height * 2.0f/ 3.0f - 6.0f)];
        [background addSubview:_titlelbl];
        _titlelbl.font = [UIFont systemFontOfSize:12.0f];
        _titlelbl.textColor = FlatBlackDark;
        _titlelbl.text = @"旺旺仙贝";
        
        _starview = [[CWStarRateView alloc] initWithFrame:CGRectMake(0,
                                                                     background.frame.size.height * 2.0f/ 3.0f -5,
                                                                     background.frame.size.width/6.0f,
                                                                     15)];
        _starview.allowIncompleteStar = YES;
        _starview.delegate = self;
        _starview.userInteractionEnabled = NO;
        [background addSubview:_starview];
        
    
        _starlbl = [[UILabel alloc] initWithFrame:CGRectMake(background.frame.size.width/6.0f + 5,
                                                             background.frame.size.height * 2.0f/ 3.0f -5,
                                                             15,
                                                             15)];
        [background addSubview:_starlbl];
        _starlbl.textColor = FlatBlack;
        _starlbl.font = [UIFont systemFontOfSize:8.0f];
        _starlbl.text = @"8.0";
        
        
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
    _titlelbl.text = title;
}

-(void)setRankNum:(NSInteger)rankNum
{
    _rankNum = rankNum;
    _ranklbl.text = [NSString stringWithFormat:@"%d",(int)rankNum];
}

-(void)setStarfloatNum:(CGFloat)starfloatNum
{
    _starfloatNum = starfloatNum;
    _starview.scorePercent = starfloatNum/5.0f;
    _starlbl.text = [NSString stringWithFormat:@"%.1f",starfloatNum * 2];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SnackDetailViewController *sdvc = [[SnackDetailViewController alloc] init];
    [sdvc setHidesBottomBarWhenPushed:YES];
    [[self viewController].navigationController pushViewController:sdvc animated:YES];
    
    sdvc.title = self.title;
    sdvc.name = self.title;
    sdvc.image = self.image;
    sdvc.stars = self.starfloatNum;
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
