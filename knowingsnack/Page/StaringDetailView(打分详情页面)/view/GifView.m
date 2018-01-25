//
//  GifView.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/25.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "GifView.h"
#import "YYAnimatedImageView.h"
#import "UIImageView+YYWebImage.h"

@interface GifView()
{
    YYAnimatedImageView* _imageView;
}
@end


@implementation GifView



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width *(179.0f/234.0f))];
        [self addSubview:_imageView];
        NSURL *path = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"gif"];
        _imageView.yy_imageURL = path;
        
        
        NSTimer *timer= [NSTimer scheduledTimerWithTimeInterval:3.5f target:self selector:@selector(myLog:) userInfo:nil repeats:YES];
        [timer fire];
    }
    return self;
}

int i = 1;
-(void)myLog:(NSTimer *)sender
{
    int num;
    if (i%8 == 0) {
        num = 8;
    }
    else
    {
        num = i%8;
    }
    NSURL *path = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%d",num] withExtension:@"gif"];
    _imageView.yy_imageURL = path;

    i ++;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
