//
//  NewFunctionsViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/1.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "NewFunctionsViewController.h"
#import "Header.h"
#import "NewFuntionButton.h"

@interface NewFunctionsViewController ()
{
    
}
@end

@implementation NewFunctionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新功能介绍";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    [self.view addSubview:scrollView];
    

    NewFuntionButton *btn10 = [[NewFuntionButton alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WEIGHT - 20, 50)];
    [scrollView addSubview:btn10];
    [scrollView addSubview:btn10.bottomView];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"function10.html" ofType:nil]]];
    [btn10.bottomView loadRequest:request];
    [btn10.bottomView setScalesPageToFit:YES];
    [btn10 setTitle:@"1.0 功能简介" forState:UIControlStateNormal];
    [btn10 setTitle:@"1.0 功能简介" forState:UIControlStateSelected];
    [btn10 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
