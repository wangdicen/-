//
//  RigisterViewController.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "RigisterViewController.h"
#import "Header.h"
#import "UITextView+Placeholder.h"
#import <AVOSCloud/AVUser.h>
#import "RealRigisterViewController.h"

@interface RigisterViewController ()
{
    UITextField *_username;
    UITextField *_keyword;
}
@end

@implementation RigisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self addUI];
}


-(void)addUI{
    
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    [self.view addSubview:backview];
    backview.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"login_bg")];
    
    UIButton *closebtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [self.view addSubview:closebtn];
    closebtn.center = CGPointMake(12.5f +10, 12.5f+25);
    [closebtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [closebtn setImage:IMAGE(@"calendar_close_icon") forState:UIControlStateNormal];
    [closebtn setImage:IMAGE(@"calendar_close_icon") forState:UIControlStateSelected];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 60)];
    [self.view addSubview:text];
    text.font = [UIFont boldSystemFontOfSize:40];
    text.text = @"欢迎来到知食";
    text.textColor = FlatRed;
    text.textAlignment = NSTextAlignmentCenter;
    text.backgroundColor = ClearColor;
    text.center = CGPointMake(SCREEN_WEIGHT/2.0f, SCREEN_HEIGHT * (2.0f/8.0f ));
    
    _username = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.8f, 40)];
    _username.layer.cornerRadius = 5.0f;
    _username.layer.masksToBounds = YES;
    [_username.layer setBorderWidth:1];
    [_username.layer setBorderColor:FlatBlack.CGColor];
    _username.center = CGPointMake(SCREEN_WEIGHT/2.0f, text.center.y + 30 +40);
    _username.placeholder = @"邮箱";
    
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
    _keyword.placeholder = @"密码";
    _keyword.secureTextEntry = YES;

    
    _keyword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _keyword.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_keyword];
    
    UIButton *uploadbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.8f, 40)];
    uploadbtn.layer.cornerRadius = 5.0f;
    uploadbtn.backgroundColor = FlatRed;
    [uploadbtn setTitle:@"登录" forState:UIControlStateNormal];
    [uploadbtn setTitle:@"登录" forState:UIControlStateSelected];
    [self.view addSubview:uploadbtn];
    uploadbtn.center = CGPointMake(SCREEN_WEIGHT/2.0f, _keyword.center.y + 30 +20);
    [uploadbtn addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *registerbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.24f, 30)];
    registerbtn.backgroundColor = ClearColor;
    [registerbtn setTitle:@"注册知食" forState:UIControlStateNormal];
    [registerbtn setTitle:@"注册知食" forState:UIControlStateSelected];
    [self.view addSubview:registerbtn];
    [registerbtn setTitleColor:FlatRed forState:UIControlStateNormal];
    [registerbtn setTitleColor:FlatRed forState:UIControlStateSelected];
    registerbtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    registerbtn.center = CGPointMake(SCREEN_WEIGHT/2.0f - SCREEN_WEIGHT * 0.24f/2.0f - 3 , uploadbtn.center.y + 30 +20);
    [registerbtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *forgetkey = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.24f, 30)];
    forgetkey.backgroundColor = ClearColor;
    [forgetkey setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetkey setTitle:@"忘记密码" forState:UIControlStateSelected];
    [self.view addSubview:forgetkey];
    [forgetkey setTitleColor:FlatGray forState:UIControlStateNormal];
    [forgetkey setTitleColor:FlatGray forState:UIControlStateSelected];
    forgetkey.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    forgetkey.center = CGPointMake(SCREEN_WEIGHT/2.0f + SCREEN_WEIGHT * 0.24f/2.0f + 3 , uploadbtn.center.y + 30 +20);
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 20)];
    line.backgroundColor = FlatGray;
    [self.view addSubview:line];
    line.center = CGPointMake(SCREEN_WEIGHT/2.0f, uploadbtn.center.y + 30 +20);
    
}



-(void)upload{
    if ([_username.text isEqualToString:@""]) {
        [XHToast showTopWithText:@"请填写邮箱" topOffset:55.0f];
        return;
    }
    if (![_username.text isEmail]) {
        [XHToast showTopWithText:@"请正确填写邮箱" topOffset:55.0f];
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
    
    [[AVOSManager shareAVOSManager] queryUserInfoAndArchierFromBackgroundWithEmail:_username.text];
    
    
    NSString *dataPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userinfo.archive"];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    UserInfo *info = [unArchiver decodeObjectForKey:@"userinfo"];
    [unArchiver finishDecoding];
    
    
    if ([info.password isEqualToString:_keyword.text]){
        [XHToast showTopWithText:@"登录成功" topOffset:55.0f];
    }else{
        [XHToast showTopWithText:@"密码错误" topOffset:55.0f];
    }
}

- (void)registerUser{
    RealRigisterViewController *rvc = [[RealRigisterViewController alloc] init];
    [self presentViewController:rvc animated:YES completion:^{
        
    }];
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![_username isExclusiveTouch]) {
        [_username resignFirstResponder];
    }
    if (![_keyword isExclusiveTouch]) {
        [_keyword resignFirstResponder];
    }
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
