//
//  OneCellView.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/14.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "OneCellView.h"

#import "Header.h"
#import "Chameleon.h"

#import "YYAnimatedImageView.h"
#import "UIImageView+YYWebImage.h"

@interface OneCellView(){
    UILabel *_kindnnamelbl;
    UILabel *_titlelbl;
    UILabel *_commentlbl;
    UIImageView *_headerimageview;
    UILabel *_usernamelbl;
    YYAnimatedImageView *_articleimageview;
}
@end

@implementation OneCellView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height = frame.size.height;
        CGFloat width = frame.size.width;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 1, 10)];
        [self addSubview:line];
        line.backgroundColor = rgba(180, 180, 180, 1);
        
        _kindnnamelbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 10)];
        _kindnnamelbl.text = [NSString stringWithFormat:@"来自%@: %@",self.kind,self.name];
        _kindnnamelbl.font = [UIFont systemFontOfSize:10.f];
        _kindnnamelbl.textColor = FlatBlack;
        [self addSubview:_kindnnamelbl];
        
        _titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, width - height/2.0f - 30, height/4.0)];
        [self addSubview:_titlelbl];
        _titlelbl.text = self.title;
        _titlelbl.font = [UIFont boldSystemFontOfSize:16.f];
        _titlelbl.textColor = [UIColor blackColor];
        _titlelbl.lineBreakMode = NSLineBreakByCharWrapping;
        _titlelbl.numberOfLines = 2;
        
        _commentlbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 30 + height/4.0, width - height/2.0f - 30, height/3.0)];
        [self addSubview:_commentlbl];
        _commentlbl.textColor = FlatGray;
        _commentlbl.lineBreakMode = NSLineBreakByCharWrapping;
        _commentlbl.numberOfLines = 2;
        _commentlbl.font = [UIFont systemFontOfSize:13.f];
        
        _headerimageview = [[UIImageView alloc] initWithFrame:CGRectMake(10 ,
                                                                     height - 10 - 12 - 10,
                                                                    12,
                                                                     12)];
        [self addSubview:_headerimageview];
        _headerimageview.image = self.headerimage;
        _headerimageview.backgroundColor = FlatGrayDark;
        
        _usernamelbl = [[UILabel alloc] initWithFrame:CGRectMake(27, height - 10 - 12 -10, 100, 12)];
        [self addSubview:_usernamelbl];
        _usernamelbl.text = self.comment;
        _usernamelbl.textColor = FlatGrayDark;
        _usernamelbl.font = [UIFont systemFontOfSize:8.f];
        
        _articleimageview = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(width - 10 -height/2.0, 30, height/2.0, height/2.0)];
        [self addSubview:_articleimageview];
//        _articleimageview.backgroundColor = FlatGrayDark;
        
        UIView *breakarea = [[UIView alloc] initWithFrame:CGRectMake(0, height -10, width, 10)];
        [self addSubview:breakarea];
        breakarea.backgroundColor = rgba(233, 233, 233, 0.5);
        
    }
    return self;
}



- (void)setName:(NSString *)name
{
    _name = name;
    _kindnnamelbl.text = [NSString stringWithFormat:@"来自%@: %@",self.kind, name];
}

-(void)setKind:(NSString *)kind
{
    _kind = kind;
    _kindnnamelbl.text = [NSString stringWithFormat:@"来自%@: %@",kind, self.name];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titlelbl.text = title;
}

-(void)setComment:(NSString *)comment
{
    _comment = comment;
    _commentlbl.text = comment;
    _commentlbl.lineBreakMode = NSLineBreakByCharWrapping;
    _commentlbl.numberOfLines = 2;
}

-(void)setHeaderimage:(UIImage *)headerimage
{
    _headerimage = headerimage;
    _headerimageview.image = headerimage;
}

-(void)setUsername:(NSString *)username
{
    _username = username;
    _usernamelbl.text = username;
}

-(void)setArticleimageurl:(NSString *)articleimageurl
{
    _articleimageurl = articleimageurl;
    _articleimageview.yy_imageURL = articleimageurl;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
