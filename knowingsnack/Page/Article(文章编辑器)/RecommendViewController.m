//
//  RecommendViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/2.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "RecommendViewController.h"
#import "WDCAddImageImageView.h"
#import "Header.h"
#import "UITextView+Placeholder.h"
@interface RecommendViewController ()
{
    UIButton *_leftBtn;
    WDCAddImageImageView *_imageview;
    
    UITextField *_textfield;
    UITextView *_textView;
}
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"推荐零食";
    
    _imageview = [[WDCAddImageImageView alloc] initWithFrame:CGRectMake(0, 66, SCREEN_WEIGHT, SCREEN_HEIGHT/6.f)];
    [self.view addSubview:_imageview];
    [_imageview.textlabel setText:@"+添加图片 (必填)"];
    
    _textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, _imageview.frame.origin.y + _imageview.frame.size.height, SCREEN_WEIGHT, 40)];
    _textfield.font = [UIFont boldSystemFontOfSize:20.f];
    [self.view addSubview:_textfield];
    _textfield.placeholder = @"请输入零食名称";
    CGRect frame = [_textfield frame];
    frame.size.width = 10.0f;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    _textfield.leftViewMode = UITextFieldViewModeAlways;
    _textfield.leftView = leftview;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, _textfield.frame.origin.y + _textfield.frame.size.height, SCREEN_WEIGHT, 150)];
    _textView.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:_textView];
    _textView.placeholder = @"     输入推荐理由\n     (若知食未收录您喜欢的零食,可以在这里反馈给我们,管理员会在后台添加)";
    
    
    _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [self.navigationController.navigationBar addSubview:_leftBtn];
    
    _leftBtn.center = CGPointMake(SCREEN_WEIGHT - 30, 22.f);
    [_leftBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:FlatGray forState:UIControlStateNormal];
    _leftBtn.backgroundColor = FlatWhite;
    _leftBtn.layer.cornerRadius = 5.f;
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    
    [_leftBtn addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)complete:(UIButton *)sender
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        _leftBtn.alpha = 0.0;
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        _leftBtn.alpha = 1.0;
    }];
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//    [_leftBtn removeFromSuperview];
//    _leftBtn = nil;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
