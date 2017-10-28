//
//  AppIconImage.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/28.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "AppIconImage.h"
#import "Header.h"

@implementation AppIconImage


#define kBorderWidth 8

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        self.backgroundColor = ClearColor;
        
    }
    return self;
}


- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected == YES) {
        self.backgroundColor = FlatYellowDark;
    }
    else{
        self.backgroundColor = ClearColor;
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSNumber *num = [NSNumber numberWithInteger:self.tag];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:num forKey:@"tag"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"iconchange" object:nil userInfo:dic];
}



- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    /**
     画圆形边框
     */
    CGRect bigRect = CGRectMake(rect.origin.x + kBorderWidth,
                                rect.origin.y+ kBorderWidth,
                                rect.size.width - kBorderWidth*2,
                                rect.size.height - kBorderWidth*2);
    //设置空心圆的线条宽度
    CGContextSetLineWidth(ctx, kBorderWidth);
    //以矩形bigRect为依据画一个圆
    CGContextAddEllipseInRect(ctx, bigRect);
    //填充当前绘画区域的颜色
    [ClearColor set];
    //(如果是画圆会沿着矩形外围描画出指定宽度的（圆线）空心圆)/（根据上下文的内容渲染图层）
    CGContextStrokePath(ctx);
    

    /**
     *  裁剪图片
     */
    CGRect smallRect = CGRectMake(rect.origin.x + kBorderWidth,
                                  rect.origin.y + kBorderWidth,
                                  rect.size.width - 2 * kBorderWidth,
                                  rect.size.height -2 * kBorderWidth);
    //以矩形ctx为依据画一个圆
    CGContextAddEllipseInRect(ctx, smallRect);
    //设置裁剪区域
    CGContextClip(ctx);
    // 裁剪图片
    UIImage *image = self.image;
    // 把图片加入smallRect的矩形区域内，超过上面设定的裁剪区域的部分将被裁剪掉
    [image drawInRect:smallRect];
    // 将上下文的内容渲染到视图的layer图层上
    CGContextStrokePath(ctx);
    
}



@end
