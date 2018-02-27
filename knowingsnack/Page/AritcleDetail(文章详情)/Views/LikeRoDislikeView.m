//
//  LikeRoDislikeView.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/31.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "LikeRoDislikeView.h"
#import "Header.h"
#import "YYAnimatedImageView.h"
#import "UIImageView+YYWebImage.h"

@interface LikeRoDislikeView()
{
    YYAnimatedImageView *_likegif;
    UILabel *_likelbl;
    
    YYAnimatedImageView *_dislikegif;
    UILabel *_dislikelbl;
}
@end


@implementation LikeRoDislikeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowColor = FlatGray.CGColor;
        self.layer.shadowRadius = 5;
        self.layer.shadowOffset = CGSizeMake(0, -6);
        
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2.0f, frame.size.height)];
        [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        _likegif = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(frame.size.width/4.0f - 50, 0, frame.size.height, frame.size.height)];
        [leftBtn addSubview:_likegif];
        NSURL *path = [[NSBundle mainBundle] URLForResource:@"like" withExtension:@"gif"];
        _likegif.yy_imageURL = path;
        _likegif.autoPlayAnimatedImage = NO;

        _likelbl = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/4.0f - 50 + frame.size.height/2.0f +20, 0, 100, frame.size.height)];
        [leftBtn addSubview:_likelbl];
        [_likelbl setText:@"120"];
        [_likelbl setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
        
        
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2.0f, 0, frame.size.width/2.0, frame.size.height)];
        [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        _dislikegif = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(frame.size.width/4.0f - 70, 0, frame.size.height * (550.f/400.f), frame.size.height)];
        [rightBtn addSubview:_dislikegif];
        NSURL *path2 = [[NSBundle mainBundle] URLForResource:@"dislike" withExtension:@"gif"];
        _dislikegif.yy_imageURL = path2;
        _dislikegif.autoPlayAnimatedImage = NO;
        
        _dislikelbl = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/4.0f - 50 + frame.size.height * (550.f/400.f)/2.0f +10, 0, 100, frame.size.height)];
        [rightBtn addSubview:_dislikelbl];
        [_dislikelbl setText:@"120"];
        [_dislikelbl setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, frame.size.height/2.f)];
        [self addSubview:line];
        line.center = CGPointMake(frame.size.width/2.0f, frame.size.height/2.f);
        line.backgroundColor = FlatGray;
        line.alpha = 0.6;
    }
    return self;
}


-(void)leftAction
{
    [_likegif startAnimating];
    [self performSelector:@selector(delayMethod:)
               withObject:_likegif/*可传任意类型参数*/
               afterDelay:0.7f];
}

-(void)rightAction
{
    
    [_dislikegif startAnimating];
    [self performSelector:@selector(delayMethod:)
                                            withObject:_dislikegif/*可传任意类型参数*/
                                            afterDelay:3.f];
}


-(void)delayMethod:(YYAnimatedImageView *)view
{
    [view stopAnimating];
    [view setCurrentAnimatedImageIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
