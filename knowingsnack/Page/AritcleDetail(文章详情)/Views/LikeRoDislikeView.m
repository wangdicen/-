//
//  LikeRoDislikeView.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/31.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "LikeRoDislikeView.h"
#import "Header.h"

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
        [self addSubview:leftBtn];
        
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2.0f, 0, frame.size.width/2.0, frame.size.height)];
        [self addSubview:rightBtn];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, frame.size.height/2.f)];
        [self addSubview:line];
        line.center = CGPointMake(frame.size.width/2.0f, frame.size.height/2.f);
        line.backgroundColor = FlatGray;
        line.alpha = 0.6;
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
