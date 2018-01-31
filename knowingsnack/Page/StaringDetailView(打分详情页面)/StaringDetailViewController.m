//
//  StaringDetailViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/25.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "StaringDetailViewController.h"
#import "GifCloseButton.h"
#import "Header.h"
#import "GifView.h"
#import "CWStarRateView.h"
#import "FireworksView.h"
#import "Snack.h"

@interface StaringDetailViewController ()<UITextViewDelegate,CWStarRateViewDelegate>
{
    FireworksView *_fireworksView;
    CGPoint _starTouchPostion;
    UITextView *_textview;
    CWStarRateView *_starview;
}
@end

@implementation StaringDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgb(177, 211, 230);
    
    GifCloseButton *closebtn = [[GifCloseButton alloc] initWithFrame:CGRectMake(10, 30, 50, 33)];
    [self.view addSubview:closebtn];
    
    UIButton *okbtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT - 60, 30, 50, 33)];
    [self.view addSubview:okbtn];
    okbtn.backgroundColor = FlatOrange;
    [okbtn setTitleColor:FlatWhite forState:UIControlStateNormal];
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    okbtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    okbtn.layer.cornerRadius = 5.0f;
    [okbtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    
    GifView *gifview = [[GifView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_WEIGHT * (179.0f/234.0f) + 30, SCREEN_WEIGHT, SCREEN_WEIGHT * (179.0f/234.0f))];
    [self.view addSubview:gifview];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35 + 30 + 3, SCREEN_WEIGHT, 1)];
    [self.view addSubview:line];
    line.backgroundColor = FlatGray;
    line.alpha = 0.3;
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 35 + 30 + 10+ 13, SCREEN_WEIGHT, 10)];
    lbl1.backgroundColor =  ClearColor;
    lbl1.text = @"点击星星评分";
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.font = [UIFont systemFontOfSize:12.0f];
    lbl1.textColor = FlatBlack;
    lbl1.layer.shadowColor = FlatGray.CGColor;
    lbl1.layer.shadowOpacity = 1.f;
    lbl1.layer.shadowOffset = CGSizeMake(0,0);
    [self.view addSubview:lbl1];
    
    _starview = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 35 + 30 + 10 + 10 + 13 +8, SCREEN_WEIGHT/2.0f, 40) numberOfStars:5];
    _starview.layer.shadowColor = FlatGray.CGColor;
    _starview.layer.shadowOpacity = 1.f;
    _starview.layer.shadowOffset = CGSizeMake(0,0);
    _starview.center = CGPointMake(SCREEN_WEIGHT/2.0f, _starview.center.y);
    _starview.delegate = self;
    _starview.hasAnimation = NO;
    _starview.allowIncompleteStar = NO;
    _starview.userInteractionEnabled = YES;
    _starview.scorePercent = 0;
    [self.view addSubview:_starview];
    
    _starview.clipsToBounds = NO;
    
    _fireworksView = [[FireworksView alloc] init];
    _fireworksView.particleImage = [UIImage imageNamed:@"particle.png"];
    [_starview insertSubview:_fireworksView atIndex:0];
    
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(30, 35 + 30 + 10 + 10 + 13 +8 + 40 +30, self.view.frame.size.width - 60, self.view.frame.size.height/4.6f)];
    _textview.layer.cornerRadius = 10.0f;
    _textview.layer.borderWidth = 1.0f;
    _textview.delegate = self;
    _textview.layer.borderColor = FlatGray.CGColor;
    _textview.backgroundColor = FlatWhite;
    _textview.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);

    [self.view addSubview:_textview];
    
    [self setPlaceHolderByKVCWithString:@"写几句评价吧..." forTextView:_textview] ;
        /**
     *  监听textView的文本改变
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeText:) name:UITextViewTextDidChangeNotification object:_textview];
    
}


- (void)next
{
    Snack *snack = [Snack objectWithClassName:@"Snack" objectId:self.objectID];

    NSLog(@"%@",self.objectID);
    
    [snack commentSnackWithShortComment:_textview.text starnum:_starview.scorePercent*5];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return [textView resignFirstResponder];
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    _fireworksView.frame = CGRectMake(0, 0, 30, 30);
    _fireworksView.center = _starTouchPostion;
    [_fireworksView animate];
}

- (void)touchPosition:(CGPoint)position
{
    _starTouchPostion = position;
}

- (void)textViewDidChangeText:(NSNotification *)notification

{
    /**
     *  最大输入长度,中英文字符都按一个字符计算
     */;
    int kMaxLength;

    kMaxLength = 200;

    
    UITextView *textView = (UITextView *)notification.object;
    NSString *toBeString = textView.text;
    
    if (kMaxLength - (int)toBeString.length < 0) {
        
    }
    else{
//        _numLabel.text = [NSString stringWithFormat:@"还可以输入%d个字",kMaxLength - (int)toBeString.length];
    }
    // 获取键盘输入模式
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
    // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮选择部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，表明输入结束,则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                // 截取子串
                textView.text = [toBeString substringToIndex:kMaxLength];
            }
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
            NSLog(@"11111111111111========      %@",position);
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            // 截取子串
            textView.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

-(void)setPlaceHolderByKVCWithString:(NSString *)placeholder forTextView:(UITextView *)textView
{
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    
    // same font
    textView.font = [UIFont systemFontOfSize:16.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:16.f];
    
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
