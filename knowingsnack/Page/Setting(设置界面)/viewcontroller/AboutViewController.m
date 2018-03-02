//
//  AboutViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/1.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "AboutViewController.h"
#import "Header.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于";
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT/4.f, SCREEN_WEIGHT/4.f)];
    imageview.image = IMAGE(@"Image4");
    imageview.layer.cornerRadius = 22.f;
    imageview.layer.masksToBounds = YES;
    [self.view addSubview:imageview];
    imageview.center = CGPointMake(SCREEN_WEIGHT/2.0f, SCREEN_HEIGHT/5.0f);
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lbl1.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.view addSubview:lbl1];
    lbl1.center = CGPointMake(SCREEN_WEIGHT/2.0f, imageview.center.y + 100);
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.textColor = FlatGray;
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 90)];
    lbl2.lineBreakMode = NSLineBreakByClipping;
    lbl2.numberOfLines = 5;
    lbl2.text = @"个人开发者作品; \n\n 新浪微博 @今天的我竟也是如此英俊 \n\n 简书 @大布溜";
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.textColor = FlatGray;
    lbl2.font = [UIFont fontWithName:@"Arial" size:14.f];
    lbl2.center = CGPointMake(SCREEN_WEIGHT/2.f, lbl1.center.y + 55);
    [self.view addSubview:lbl2];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    btn.backgroundColor = FlatYellowDark;
    btn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:btn];
    btn.center = CGPointMake(SCREEN_WEIGHT/2.f, SCREEN_HEIGHT - 100);
    [btn setTitle:@"打赏" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    btn.layer.cornerRadius = 5.0f;
    
    [btn addTarget:self action:@selector(dashang) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)dashang
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"HTTPS://QR.ALIPAY.COM/FKX04179TH0G7WRABUIG25"]];
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
