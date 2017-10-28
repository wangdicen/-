//
//  MainViewController.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "MainViewController.h"
#import "Chameleon.h"
#import "MainNavView.h"
#import "Header.h"
#import "RigisterViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = FlatPink;
    
    MainNavView *navbar = [[MainNavView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WEIGHT*0.80f,35)];
    UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithCustomView:navbar];
    [self.navigationItem setLeftBarButtonItem:navLeft];
    

    UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    chatBtn.center = CGPointMake(SCREEN_WEIGHT - self.navigationController.navigationBar.frame.size.height/2.0 - 5.0f, self.navigationController.navigationBar.frame.size.height/2.0f);
    chatBtn.backgroundColor = ClearColor;
    [chatBtn addTarget:self action:@selector(goToRigister:) forControlEvents:UIControlEventTouchUpInside];
    [chatBtn setImage:IMAGE(@"setting_theme") forState:UIControlStateNormal];
    [chatBtn setImage:IMAGE(@"setting_theme") forState:UIControlStateSelected];

    [self.navigationController.navigationBar addSubview:chatBtn];
//    UIBarButtonItem *navRight = [[UIBarButtonItem alloc] initWithCustomView:chatBtn];
//    [self.navigationItem setRightBarButtonItem:navRight];

}

- (void)goToRigister:(UIButton *)sender
{
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"IS_LOGIN"]) {
        RigisterViewController *rvc = [[RigisterViewController alloc] init];
        [self presentViewController:rvc animated:YES completion:^{
            
        }];
//    }

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
