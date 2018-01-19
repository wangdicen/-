//
//  OneRecommendView.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/31.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "OneRecommendView.h"
#import "Header.h"
#import "TopLeftLabel.h"
#import "ArticleViewController.h"

@interface OneRecommendView()
{
    UIImageView *_imageview;
    UILabel *_titleLabel;
    TopLeftLabel *_textLabel;
}
@end

@implementation OneRecommendView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = FlatWhite;
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowColor = FlatGray.CGColor;
        self.layer.shadowRadius = 5;
        self.layer.shadowOffset = CGSizeMake(6, 6);
        
        _imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageview];
        
        _textLabel = [[TopLeftLabel alloc] initWithFrame:CGRectMake(0, frame.size.height*(7.0/12.0), frame.size.width, frame.size.height *5.0/12.0)];
        [self addSubview:_textLabel];
        _textLabel.numberOfLines = 2;
        _textLabel.lineBreakMode = NSLineBreakByClipping;
        _textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentNatural;
        if (_image!= nil) {
            _textLabel.backgroundColor = [UIColor colorWithPatternImage:_image];
        }
        else{
            _textLabel.backgroundColor = FlatWhite;
        }
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, frame.size.height*(7.0/12.0) - 18, 100, 15)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.layer.cornerRadius = 5.0f;
        _titleLabel.clipsToBounds = YES;
        _titleLabel.textColor = FlatBlack;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        [self addSubview:_titleLabel];
        
    }
    
    return self;
}


-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
    
    NSDictionary *attr=@{NSFontAttributeName:_titleLabel.font};
    CGSize strSize=CGSizeMake(200, MAXFLOAT);
    CGSize labelSize = [_titleLabel.text boundingRectWithSize:strSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attr
                                                     context:nil].size;
    
    _titleLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMinY(_titleLabel.frame), labelSize.width + 5.0f, 15);
}
-(void)setText:(NSString *)text
{
    _text = text;
    _textLabel.text = text;
    
    if (_image!= nil) {
        _textLabel.backgroundColor = [UIColor colorWithAverageColorFromImage:_image];
    }
    else{
        _textLabel.backgroundColor = FlatWhite;
    }
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    _imageview.image = image;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ArticleViewController *avc = [[ArticleViewController alloc] init];
    avc.urlString = @"https://www.zybuluo.com/styx/note/1024731";
    [avc setHidesBottomBarWhenPushed:YES];

    [[self viewController].navigationController pushViewController:avc animated:YES];
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
