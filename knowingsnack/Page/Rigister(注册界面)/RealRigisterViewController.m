//
//  RealRigisterViewController.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/26.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "RealRigisterViewController.h"
#import "Header.h"

@interface RealRigisterViewController ()
{
    UITextField *_username;
    UITextField *_keyword;
    UITextField *_nicheng;
    
    UILabel *_text;
    UIButton *_uploadbtn;
    UILabel *_text2;
    
    
    UILabel *_text_b;
    UIButton *_nextbtn_b;
    UILabel *_text_b2;
    
    NSString *_final_username;
    NSString *_final_keyword;
    NSString *_final_nicheng;
}
@end

@implementation RealRigisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addUI_A];
}



- (void)next
{
    if ([_username.text isEqualToString:@""]) {
        [XHToast showTopWithText:@"请填写手机号或邮箱" topOffset:55.0f];
        return;
    }
    if (![_username.text isTelNum] && ![_username.text isEmail]) {
        [XHToast showTopWithText:@"请正确填写手机号或邮箱" topOffset:55.0f];
        return;
    }
    if ([_keyword.text isEqualToString:@""]){
        [XHToast showTopWithText:@"请填写密码" topOffset:55.0f];
        return;
    }
    if (![_keyword.text isRightKeyWord]) {
        [XHToast showTopWithText:@"密码只能由数字和字母组成" topOffset:55.0f];
        return;
    }
    if(_keyword.text.length > 16 || _keyword.text.length < 6){
        [XHToast showTopWithText:@"密码须为6到16位" topOffset:55.0f];
        return;
    }
    if([_nicheng.text isEqualToString:@""]){
        [XHToast showTopWithText:@"请填写昵称" topOffset:55.0f];
        return;
    }
    if(_nicheng.text.length > 20)
    {
        [XHToast showTopWithText:@"昵称过长" topOffset:55.0f];
        return;
    }
    _final_keyword = _keyword.text;
    _final_username = _username.text;
    _final_nicheng = _nicheng.text;
    
    
    //!!!!!!!!!!!!!    判断是否是 [已经被验证过的] 重复手机号 或者 邮箱;
    
    if([_final_username isEmail])
    {
        [AVUser currentUser].email = _final_username;
        [AVUser requestEmailVerify:_final_username withBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(!succeeded){
                [XHToast showTopWithText:@"验证邮件发送失败" topOffset:55.0f];
            }
            else{
                //!!!!!!!!!!!!!!!!  把用户信息加入到后台.....
            }
        }];
    }
    
    
    [self removUI_A];
    [self addUI_B];
    
}

-(void)next_B{
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"email" equalTo:_final_username];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(objects.count != 0)
        {
            AVObject *object = [objects objectAtIndex:0];
            bool isemailVerified = [[object objectForKey:@"emailVerified"] boolValue];
            if (!isemailVerified) {
                [XHToast showTopWithText:@"您还未验证,请前往邮箱验证" topOffset:100.0f];
                return;
            }
        }
    }];
    
   
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![_username isExclusiveTouch]) {
        [_username resignFirstResponder];
    }
    if (![_keyword isExclusiveTouch]) {
        [_keyword resignFirstResponder];
    }
    if (![_nicheng isExclusiveTouch]) {
        [_nicheng resignFirstResponder];
    }
}
-(void)removUI_A
{
    [_username removeFromSuperview];
    [_keyword removeFromSuperview];
    [_nicheng removeFromSuperview];;
    
    [_text removeFromSuperview];
    [_uploadbtn removeFromSuperview];
    [_text2 removeFromSuperview];;
}
-(void)addUI_A{
    
    _text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 60)];
    [self.view addSubview:_text];
    _text.font = [UIFont boldSystemFontOfSize:40];
    _text.text = @"欢迎加入知食";
    _text.textColor = FlatRed;
    _text.textAlignment = NSTextAlignmentCenter;
    _text.backgroundColor = ClearColor;
    _text.center = CGPointMake(SCREEN_WEIGHT/2.0f, SCREEN_HEIGHT * (2.0f/8.0f ));
    
    _username = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.8f, 40)];
    _username.layer.cornerRadius = 5.0f;
    _username.layer.masksToBounds = YES;
    [_username.layer setBorderWidth:1];
    [_username.layer setBorderColor:FlatBlack.CGColor];
    _username.center = CGPointMake(SCREEN_WEIGHT/2.0f, _text.center.y + 30 +40);
    _username.placeholder = @"手机号/邮箱";
    
    //为textview加入一个左视图  看起来不会太靠左
    _username.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _username.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_username];
    
    
    _keyword = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.8f, 40)];
    _keyword.layer.cornerRadius = 5.0f;
    _keyword.layer.masksToBounds = YES;
    [_keyword.layer setBorderWidth:1];
    [_keyword.layer setBorderColor:FlatBlack.CGColor];
    _keyword.center = CGPointMake(SCREEN_WEIGHT/2.0f, _username.center.y + 30 +20);
    _keyword.placeholder = @"密码(最多16位)";
    _keyword.secureTextEntry = YES;
    
    
    _keyword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _keyword.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_keyword];
    
    
    _nicheng = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.8f, 40)];
    _nicheng.layer.cornerRadius = 5.0f;
    _nicheng.layer.masksToBounds = YES;
    [_nicheng.layer setBorderWidth:1];
    [_nicheng.layer setBorderColor:FlatBlack.CGColor];
    _nicheng.center = CGPointMake(SCREEN_WEIGHT/2.0f, _keyword.center.y + 30 +20);
    _nicheng.placeholder = @"昵称";
    
    
    _nicheng.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _nicheng.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nicheng];
    
    
    _uploadbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.8f, 40)];
    _uploadbtn.layer.cornerRadius = 5.0f;
    _uploadbtn.backgroundColor = FlatRed;
    [_uploadbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_uploadbtn setTitle:@"下一步" forState:UIControlStateSelected];
    [self.view addSubview:_uploadbtn];
    _uploadbtn.center = CGPointMake(SCREEN_WEIGHT/2.0f, _nicheng.center.y + 30 +20);
    [_uploadbtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    _text2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 40)];
    [self.view addSubview:_text2];
    _text2.font = [UIFont fontWithName:@"Arial" size:12];
    _text2.text = @"点击[下一步]代表你已阅读并同意用户使用协议";
    _text2.textColor = FlatGray;
    _text2.textAlignment = NSTextAlignmentCenter;
    _text2.backgroundColor = ClearColor;
    _text2.center = CGPointMake(SCREEN_WEIGHT/2.0f, _uploadbtn.center.y + 30 +5);
}

- (void)addUI_B
{
    if ([_final_username isEmail]) {
        
        
        _text_b = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT - 80.0f, 80)];
        [self.view addSubview:_text_b];
        _text_b.font = [UIFont fontWithName:@"Arial" size:16];
        _text_b.text = [NSString stringWithFormat:@"验证邮件已发送到您的邮箱[%@]中,请在邮箱中验证后点击下一步", _final_username];
        _text_b.textColor = FlatGray;
        _text_b.textAlignment = NSTextAlignmentCenter;
        _text_b.backgroundColor = ClearColor;
        _text_b.numberOfLines = 3;
        _text_b.center = CGPointMake(SCREEN_WEIGHT/2.0f, SCREEN_HEIGHT * (2.0f/8.0f ));
        
        _nextbtn_b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.8f, 40)];
        _nextbtn_b.layer.cornerRadius = 5.0f;
        _nextbtn_b.backgroundColor = FlatRed;
        [_nextbtn_b setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextbtn_b setTitle:@"下一步" forState:UIControlStateSelected];
        [self.view addSubview:_nextbtn_b];
        _nextbtn_b.center = CGPointMake(SCREEN_WEIGHT/2.0f, _text_b.center.y + 30 +40);
        [_nextbtn_b addTarget:self action:@selector(next_B) forControlEvents:UIControlEventTouchUpInside];
        
        _text_b2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT - 80.0f, 80)];
        [self.view addSubview:_text_b2];
        _text_b2.font = [UIFont fontWithName:@"Arial" size:12];
        _text_b2.text = [NSString stringWithFormat:@"温馨提示:\n1.若弹出[验证邮件发送失败]弹框,可能是您的邮件填写错误,请按[取消]键回到上一步;\n2.每60秒只能为同一账号发送一封邮件,邮件48小时内有效,请不要重复提交."];
        _text_b2.textColor = FlatGray;
        _text_b2.textAlignment = NSTextAlignmentCenter;
        _text_b2.backgroundColor = ClearColor;
        _text_b2.numberOfLines = 5;
        _text_b2.center = CGPointMake(SCREEN_WEIGHT/2.0f, _nextbtn_b.center.y + 30 +50);
    }
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
