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
#import "SnackDetailViewController.h"

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
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [FlatWhiteDark CGColor];
//        self.layer.cornerRadius = 10;
        
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageview];
        _imageview.contentMode = UIViewContentModeScaleToFill;
        _imageview.backgroundColor = FlatWhite;
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 40, frame.size.width, 40)];
        [self addSubview:background];
//        background.layer.cornerRadius = 10;
        background.backgroundColor = RGB(241,236,226,1);
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, frame.size.width, 20)];
        [background addSubview:_label];
        _label.font = [UIFont boldSystemFontOfSize:11.0f];
        _label.textColor = RGB(166,147,108,1);
        _label.text = @"加载中···";
        
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

- (void)setObjectID:(NSString *)objectID
{
    _objectID = objectID;
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SnackDetailViewController *sdvc = [[SnackDetailViewController alloc] init];
    [sdvc setHidesBottomBarWhenPushed:YES];
    [[self viewController].navigationController pushViewController:sdvc animated:YES];
    
    sdvc.title = _label.text;
    sdvc.name = _label.text;
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
