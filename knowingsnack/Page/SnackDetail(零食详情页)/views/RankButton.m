//
//  RankButton.m
//  knowingsnack
//
//  Created by travelsky on 2018/2/27.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "RankButton.h"
#import "Header.h"

@implementation RankButton


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, (SCREEN_WEIGHT - 5)/5 -5, ((SCREEN_WEIGHT - 5)/5 -1)/2.f);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowColor = FlatGray.CGColor;
        self.layer.shadowRadius = 5;
        self.layer.shadowOffset = CGSizeMake(6, 6);
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
