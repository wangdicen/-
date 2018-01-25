//
//  FireworksView.h
//  knowingsnack
//
//  Created by travelsky on 2018/1/25.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FireworksView : UIView


@property (nonatomic, strong) UIImage *particleImage;
@property (nonatomic, assign) CGFloat particleScale;
@property (nonatomic, assign) CGFloat particleScaleRange;

- (void)animate;

@end
