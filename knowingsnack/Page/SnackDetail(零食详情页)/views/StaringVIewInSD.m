//
//  StaringVIewInSD.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/3.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "StaringVIewInSD.h"
#import "CWStarRateView.h"
#import "StaringDetailViewController.h"

@interface StaringVIewInSD(){
    UILabel *_starnumlbl;
    CWStarRateView *_starview;
}
@end

@implementation StaringVIewInSD

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(-5, 5);
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = 0.8;
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 2, self.frame.size.width, self.frame.size.height/4.0f)];
    [self addSubview:label];
    label.text = @"知食评分";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:8.0f];
    
    
    _starnumlbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/4.0, self.frame.size.width, self.frame.size.height/2.f)];
    [self addSubview:_starnumlbl];
    _starnumlbl.text = [NSString stringWithFormat:@"%d", (int)_starNum];
    _starnumlbl.textAlignment = NSTextAlignmentCenter;
    _starnumlbl.textColor = [UIColor blackColor];
    _starnumlbl.font = [UIFont boldSystemFontOfSize:20.0f];
    
    _starview = [[CWStarRateView alloc] initWithFrame:CGRectMake(2, self.frame.size.height *3.0f/4.0f, self.frame.size.width - 5, self.frame.size.height/4.f -5)];
    _starview.allowIncompleteStar = YES;
    _starview.userInteractionEnabled = NO;
    [self addSubview:_starview];
}



- (void)setStarNum:(float)starNum
{
    _starview.scorePercent = starNum/5.0f;

    _starnumlbl.text = [NSString stringWithFormat:@"%.1f",starNum/5.0f *10.0f];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.objectID == nil) {
        return;
    }
    StaringDetailViewController *sdvc = [[StaringDetailViewController alloc] init];
    sdvc.objectID = self.objectID;
    [[self viewController] presentViewController:sdvc animated:YES completion:^{
        
    }];
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
