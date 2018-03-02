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

}

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
