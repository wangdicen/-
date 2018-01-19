//
//  CommonCommandView.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/18.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "CommonCommandView.h"
#import "CWStarRateView.h"
#import "HeaderIconImageView.h"
#import "Header.h"

@interface CommonCommandView()
{
    HeaderIconImageView *_headIcon;
    UILabel *_name;
    CWStarRateView *_starView;
    UILabel *_agreelbl;
    UILabel *_textlbl;
    UILabel *_timelbl;
}
@end

@implementation CommonCommandView

int SPACING = 5;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headIcon = [[HeaderIconImageView alloc] initWithFrame:CGRectMake(SPACING, SPACING, 30, 30)];
        _headIcon.backgroundColor = ClearColor;
        [self addSubview:_headIcon];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(SPACING * 2 + 30, SPACING, 100, 30)];
        _name.backgroundColor = ClearColor;
        [self addSubview:_name];
        _name.font = [UIFont boldSystemFontOfSize:16.0f];
        
        _starView = [[CWStarRateView alloc] initWithFrame:CGRectMake(SPACING * 3 + 30 + 100, SPACING, 80, 25)];
        _starView.allowIncompleteStar = YES;
        _starView.userInteractionEnabled = NO;
        [_starView setScorePercent:_starNum/10.0f];
        [self addSubview:_starView];
        
        _textlbl = [[UILabel alloc] initWithFrame:CGRectMake(SPACING * 2 + 30, SPACING * 2 + 30, self.frame.size.width - (SPACING * 3 + 30), 10)];
        [self addSubview:_textlbl];
        _textlbl.font = [UIFont systemFontOfSize:14.0f];
        _textlbl.numberOfLines = 0;

        
    }
    return self;
}

-(void)setNametext:(NSString *)nametext
{
    _nametext = nametext;
    _name.text = nametext;
    
    CGSize size = [nametext sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_name.font,NSFontAttributeName,nil]];
    CGRect rect = _name.frame;
    
    if(size.width > 150)
    {
        size.width = 150;
    }
    _name.frame = CGRectMake(rect.origin.x, rect.origin.y, size.width, rect.size.height);
    
    _starView.frame = CGRectMake(rect.origin.x + size.width +SPACING, SPACING, 80, 25);
}

-(void)setText:(NSString *)text
{
    _text = text;
    _textlbl.text = text;
    
     CGSize lblSize = [_textlbl.text boundingRectWithSize:CGSizeMake(self.frame.size.width - (SPACING * 3 + 30), MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:_textlbl.font}
                                                  context:nil].size;
    CGRect textlblRect = _textlbl.frame;

    _textlbl.frame = CGRectMake(textlblRect.origin.x, textlblRect.origin.y, textlblRect.size.width, lblSize.height);
    
    CGRect selfRect = self.frame;
    self.frame = CGRectMake(selfRect.origin.x, selfRect.origin.y, selfRect.size.width, SPACING*4 + 30 + lblSize.height + _timelbl.frame.size.height);
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    _headIcon.image = image;
}


-(void)setStarNum:(CGFloat)starNum
{
    _starNum = starNum;
    [_starView setScorePercent:_starNum/10.0f];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
