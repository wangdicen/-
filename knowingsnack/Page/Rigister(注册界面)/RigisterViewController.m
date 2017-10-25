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

@interface RigisterViewController ()

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
    
    UITextView *username = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT * 0.8f, 40)];
    username.layer.cornerRadius = 5.0f;
    username.layer.masksToBounds = YES;
    [username.layer setBorderWidth:1];
    [username.layer setBorderColor:FlatBlack.CGColor];
    username.center = CGPointMake(SCREEN_WEIGHT/2.0f, text.center.y + 30 +40);
    username.placeholder = @"手机号/邮箱";
    
    //通过kvc来设置placeholder的字体和颜色
    username.placeholderLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:username];
    
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
