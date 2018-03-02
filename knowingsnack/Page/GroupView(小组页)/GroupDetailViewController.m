//
//  GroupDetailViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/22.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "Header.h"
#import "UINavigationController+WXSTransition.h"
#import "JHUD.h"

@interface GroupDetailViewController ()
{
    JHUD *_jhud;
}
@end

@implementation GroupDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainImageView];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    [backbtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backbtn];
    [self.view bringSubviewToFront:backbtn];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    _jhud = [[JHUD alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    _jhud.backgroundColor = ClearColor;
    _jhud.messageLabel.text = @"外测版本'小组'还没来得及做~等待下次更新吧~";
    [_jhud.refreshButton setTitle:@"逛逛其他" forState:UIControlStateNormal];
    _jhud.customImage = [UIImage imageNamed:@"nullData"];
    [_jhud showAtView:self.view hudType:JHUDLoadingTypeFailure];

    
    [_jhud setJHUDReloadButtonClickedBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/4.0f - 10)];
//        _mainImageView.image = [UIImage imageNamed:@"groupimage"];
        _mainImageView.backgroundColor = [UIColor blueColor];
    }
    return _mainImageView;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
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
