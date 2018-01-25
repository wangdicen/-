//
//  GroupDetailViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/22.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "Header.h"

@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainImageView];

}
-(UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/4.0f - 10)];
        _mainImageView.image = [UIImage imageNamed:@"groupimage"];
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
