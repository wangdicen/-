//
//  InfomationViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/2.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "InfomationViewController.h"
#import "Header.h"
#import "NewFuntionButton.h"

@interface InfomationViewController ()

@end

@implementation InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    [self.view addSubview:scrollView];
    
    
    NewFuntionButton *btn1 = [[NewFuntionButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WEIGHT - 20, 50)];
    [scrollView addSubview:btn1];

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"info1.html" ofType:nil]]];
    [btn1.bottomView loadRequest:request];
    [btn1.bottomView setScalesPageToFit:YES];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16.f];
    btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn1 setTitle:@"获取不到数据怎么办?" forState:UIControlStateNormal];
    [btn1 setTitle:@"获取不到数据怎么办?" forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NewFuntionButton *btn2 = [[NewFuntionButton alloc] initWithFrame:CGRectMake(10, 10 + 60, SCREEN_WEIGHT - 20, 50)];
    [scrollView addSubview:btn2];
    NSURLRequest* request2 = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"info2.html" ofType:nil]]];
    [btn2.bottomView loadRequest:request2];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16.f];
    btn2.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn2.bottomView setScalesPageToFit:YES];
    [btn2 setTitle:@"上传文章相关注意事件" forState:UIControlStateNormal];
    [btn2 setTitle:@"上传文章相关注意事件" forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NewFuntionButton *btn3 = [[NewFuntionButton alloc] initWithFrame:CGRectMake(10, 10 + 60 + 60, SCREEN_WEIGHT - 20, 50)];
    [scrollView addSubview:btn3];
    NSURLRequest* request3 = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"info3.html" ofType:nil]]];
    [btn3.bottomView loadRequest:request3];
    btn3.titleLabel.font = [UIFont systemFontOfSize:16.f];
    btn3.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn3.bottomView setScalesPageToFit:YES];
    [btn3 setTitle:@"为什么不好的零食反而排很高!!" forState:UIControlStateNormal];
    [btn3 setTitle:@"为什么不好的零食反而排很高!!" forState:UIControlStateSelected];
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [scrollView addSubview:btn1.bottomView];
    [scrollView addSubview:btn2.bottomView];
    [scrollView addSubview:btn3.bottomView];

}

- (void)btnAction:(NewFuntionButton *)sender
{
    if (sender.isBottomViewShown == YES) {
        sender.isBottomViewShown = NO;
    }
    else
    {
        sender.isBottomViewShown = YES;
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
