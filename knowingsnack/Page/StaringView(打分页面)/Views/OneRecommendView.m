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
    avc.urlString = @"<h1>为您的长评设置一个响当当的标题吧~</h1><p>请在这里输入 <strong>任何</strong>您想要输入的测评文字.</p><p>下方可以修改颜色,增加图片或链接</p><p>注意排版,可以吸引跟多人阅读哦</p><p><strong>一些可能发生的问题:</strong></p><p><strong>1.由于技术水平限制,目前长文评论只能加载一张图片</strong></p><p><strong>2.使用过程可能有些卡顿,我们会在之后的版本尽可能改进</strong></p><h1><em>觉得不错~可以打赏一下~</em>.</h1><div><br /></div><p><i>德国方法</i></p><p style=\"text-align: right;\"><i>如果多层次</i></p><p style=\"text-align: left;\"><i>嘘拜拜吧</i></p><p style=\"text-align: justify;\"><i>vhffgg</i></p><p style=\"text-align: justify;\"><i><br /></i></p><p style=\"text-align: center;\"><i>复合肥刚刚好</i></p><img src=\"wangdicen.png\" /><p style=\"text-align: center;\"><i><u>dgdfgggggb<sup>b</sup><font size=\"2\"><sup>fgv</sup></font></u><strike></strike></i></p><p style=\"text-align: center;\"><i><font size=\"2\"><sup><u>dgg</u><strike style=\"text-decoration: underline;\">gg ggvbb</strike></sup></font></i></p><p style=\"text-align: center;\"><i><font size=\"2\"><sup><strike>dffffgたなみや</strike></sup></font></i></p><p style=\"text-align: center;\"><i><font size=\"2\"><sub>仁万やな</sub>ょにまた</font></i></p><blockquote style=\"margin: 0px 0px 0px 40px;\"><p><i><font color=\"#b3cc50\">斜めなんです</font></i></p><p><i><font color=\"#b3cc50\" style=\"background-color: rgb(89, 21, 142);\">マナ棚よ</font></i></p></blockquote><p><i><br /></i></p><p><i><br /></i></p><p></p><p></p><p></p>";
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
