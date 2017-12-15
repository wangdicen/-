//
//  IconAnimationView.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/15.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "IconAnimationView.h"
#import "Header.h"

#define ICON_HEIGHT 30

@implementation IconAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = frame.size.width;
//        CGFloat height = frame.size.height;
        
        for (int i = 0; i < (int) width / ICON_HEIGHT; i ++) {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i * ICON_HEIGHT, 0, ICON_HEIGHT, ICON_HEIGHT)];
            [self addSubview:imageview];
            imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"icecream-%d",i]];
        }
    }
    return self;
}



@end
