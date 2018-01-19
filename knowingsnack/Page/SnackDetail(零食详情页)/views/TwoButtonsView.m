//
//  TwoButtonsView.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/17.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "TwoButtonsView.h"
#import "Header.h"

@interface TwoButtonsView(){
    UIButton *_button1;
    UIButton *_button2;
    
    UIView *_bottomline;
}
@end

@implementation TwoButtonsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isButton1Selected = YES;
        
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2.0, frame.size.height)];
        [_button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
        _button1.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_button1 setTitle:@"评论" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_button1 setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
        _button1.selected = YES;
        [self addSubview:_button1];
        
        
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2.0, 0, frame.size.width/2.0, frame.size.height)];
        _button2.titleLabel.font = [UIFont systemFontOfSize:13.0f];

        [_button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_button2 setTitle:@"小组" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_button2 setTitleColor:FlatWhiteDark forState:UIControlStateNormal];

        [self addSubview:_button2];
        
        _bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 2, frame.size.width/2.0, 2)];
        _bottomline.backgroundColor = [UIColor blackColor];
        [self addSubview:_bottomline];
        
    }
    return self;
}


-(void)button1Clicked:(UIButton *)sender
{
    [self.delegate afterButton1Select];
    [self animationOfButton1Select];
    self.isButton1Selected = YES;
    _button1.selected = YES;
    _button2.selected = NO;
}

-(void)button2Clicked:(UIButton *)sender
{
    [self.delegate afterButton2Select];
    [self animationOfButton2Select];
    self.isButton1Selected = NO;
    _button1.selected = NO;
    _button2.selected = YES;
}


-(void)animationOfButton1Select
{
    [UIView animateWithDuration:0.5 animations:^{
        _bottomline.frame = CGRectMake(0,
                                       self.frame.size.height - 2,
                                       self.frame.size.width/2.0,
                                       2);
    }];
}

-(void)animationOfButton2Select
{
    [UIView animateWithDuration:0.5 animations:^{
        _bottomline.frame = CGRectMake(self.frame.size.width/2.0,
                                       self.frame.size.height - 2,
                                       self.frame.size.width/2.0,
                                       2);
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
