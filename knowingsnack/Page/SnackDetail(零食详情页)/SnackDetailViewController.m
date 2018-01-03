//
//  SnackDetailViewController.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/18.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "SnackDetailViewController.h"
#import "Header.h"


@interface SnackDetailViewController ()
{
    UIImageView *_mainImageView;
    UIView *_mainImageViewBackground;
    UIScrollView *_scrollview;
}
@end

@implementation SnackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WEIGHT)];
    [self.view addSubview:_scrollview];
    
    _mainImageViewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/2.0 +44.0f)];
    [_scrollview addSubview:_mainImageViewBackground];
    
    
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_HEIGHT/2.0 +44.0f - 150.f) * 142/172.0f, SCREEN_HEIGHT/2.0 +44.0f - 150.f)];
    _mainImageView.center =  CGPointMake(_mainImageViewBackground.frame.size.width/2.0f, _mainImageView.frame.size.height/2.0f + 45);
    [_scrollview addSubview:_mainImageView];
    
    _mainImageView.image = [UIImage imageNamed:@"demo"];
    _mainImageViewBackground.backgroundColor = [UIColor colorWithAverageColorFromImage:_mainImageView.image];
    
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
