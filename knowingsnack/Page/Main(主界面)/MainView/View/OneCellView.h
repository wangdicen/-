//
//  OneCellView.h
//  knowingsnack
//
//  Created by travelsky on 2017/12/14.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneCellView : UIView

@property (nonatomic,assign) NSString *kind;
@property (nonatomic,assign) NSString *name;
@property (nonatomic,assign) NSString *title;
@property (nonatomic,assign) NSString *comment;
@property (nonatomic,retain) UIImage *headerimage;
@property (nonatomic,assign) NSString *username;
@property (nonatomic,retain) NSString *articleimageurl;

@end
