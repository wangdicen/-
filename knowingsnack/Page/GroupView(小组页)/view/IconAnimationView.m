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
            imageview.tag = 1000000000 + i;
            imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"icecream-%d",i]];
        }
    }
    return self;
}


-(void)animate{
    int w = (self.frame.size.width / ICON_HEIGHT);
    int i = random()%w;
    
    UIImageView *imageview = (UIImageView *)[self viewWithTag:1000000000 + i];
    CGRect fra = imageview.frame;
    [UIView animateWithDuration:0.5
                     animations:^{
                         imageview.frame = CGRectMake(fra.origin.x, fra.origin.y -15, fra.size.width, fra.size.height);
                     }
                     completion:^(BOOL finished) {
                         CGRect fra2 = imageview.frame;
                         [UIView animateWithDuration:0.5 animations:^{
                             imageview.frame = CGRectMake(fra2.origin.x, fra2.origin.y + 15, fra2.size.width, fra2.size.height);
                         }];

                     }];
    
}



@end
