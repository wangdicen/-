//
//  PlusViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "PlusViewController.h"
//#import "XLBubbleTransition.h"
#import "Header.h"


@interface PlusViewController ()

@end

@implementation PlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MainColor;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame) - 60);
    [button setImage:[UIImage imageNamed:@"Close_icn"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = button.bounds.size.width/2.0f;
    [button addTarget:self action:@selector(popMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //在ViewControllerB中添加Present和Dismiss的动画
//    self.xl_presentTranstion = [XLBubbleTransition transitionWithAnchorRect:button.frame];
//    self.xl_dismissTranstion = [XLBubbleTransition transitionWithAnchorRect:button.frame];
}

-(void)popMethod{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
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
