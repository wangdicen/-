//
//  HeaderIconImageView.h
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/27.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderIconImageView : UIView

@property (nonatomic,copy) UIImage *image;

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

@end
