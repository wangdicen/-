//
//  WDCAddImageImageView.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/2.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "WDCAddImageImageView.h"

#import "Header.h"
@interface WDCAddImageImageView()
{
    UIBezierPath *_path;
    UIImageView *_imageView;
}
@end

@implementation WDCAddImageImageView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ClearColor;
        
        _textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 50)];
        _textlabel.backgroundColor = ClearColor;
        [self addSubview:_textlabel];
        _textlabel.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.f);
        [_textlabel setTextColor:FlatWhiteDark];
        _textlabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    _path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, rect.size.width - 20.f, rect.size.height - 20.f) cornerRadius:7];
    _path.lineWidth = 2;
    [ClearColor setStroke];
    CGContextSetLineWidth(context, 2);
    CGContextAddPath(context, _path.CGPath);
    CGContextStrokePath(context);
    
    CGFloat dashes[] = {6,2};
    [_path setLineDash:dashes count:2 phase:0];
    [FlatWhite setStroke];
    [_path stroke];
}
/*
// Only override drawRect: if you perform custom drawing.
/
 / An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
