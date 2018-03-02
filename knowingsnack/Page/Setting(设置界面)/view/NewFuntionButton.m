//
//  NewFuntionButton.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/1.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "NewFuntionButton.h"
#import "Header.h"

@interface NewFuntionButton()
{
    UIImageView *_leftImage;
}
@end

@implementation NewFuntionButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _isBottomViewShown = NO;

        [self setBackgroundColor:FlatWhite];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:24.f];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.layer.cornerRadius = 5.0f;
        
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 7)];
        _leftImage.image = [UIImage imageNamed:@"down"];
        _leftImage.center = CGPointMake(self.frame.size.width * 0.93,
                                    self.frame.size.height * 0.5);
        [self addSubview:_leftImage];
        
        
        self.bottomView = [[UIWebView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, SCREEN_HEIGHT * (7.0/12.0))];
        self.bottomView.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.bottomView.alpha = 0.0f;
        self.bottomView.opaque = NO;
        self.layer.cornerRadius = 5.0f;

    }
    return self;
}

-(void)setIsBottomViewShown:(BOOL)isBottomViewShown
{
    _isBottomViewShown = isBottomViewShown;
    if (isBottomViewShown == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomView.alpha = 1.0f;
        }];
        _leftImage.image = [UIImage imageNamed:@"up"];

    }
    if (isBottomViewShown == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomView.alpha = 0.0f;
        }];
        _leftImage.image = [UIImage imageNamed:@"down"];
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
