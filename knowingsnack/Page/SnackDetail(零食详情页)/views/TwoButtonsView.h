//
//  TwoButtonsView.h
//  knowingsnack
//
//  Created by travelsky on 2018/1/17.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TwoButtonsViewDelegate<NSObject>

@optional
-(void)afterButton1Select;
-(void)afterButton2Select;

@end


@interface TwoButtonsView : UIView

@property (nonatomic,weak) id<TwoButtonsViewDelegate> delegate;

@property (assign,nonatomic) BOOL isButton1Selected;

@end
