//
//  GifCloseButton.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/25.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "GifCloseButton.h"
#import "YYAnimatedImageView.h"
#import "UIImageView+YYWebImage.h"

@implementation GifCloseButton


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        YYAnimatedImageView* imageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:imageView];
        NSURL *path = [[NSBundle mainBundle] URLForResource:@"closegif" withExtension:@"gif"];
        imageView.yy_imageURL = path;
    }
    return self;
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self viewController] dismissViewControllerAnimated:YES completion:^{
        
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
