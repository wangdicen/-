//
//  GroupViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "GroupViewController.h"
#import "PulsingHaloLayer.h"
#import "Header.h"
#import "IconAnimationView.h"

@interface GroupViewController ()
{
    PulsingHaloLayer *_halo;
    
    UIScrollView *_scrollview;
}
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    _scrollview.contentSize = CGSizeMake(SCREEN_WEIGHT, SCREEN_HEIGHT/4.0f * 10);
    [self.view addSubview:_scrollview];
    
    
    for (int i = 0; i < 10; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, SCREEN_HEIGHT/4.0f * i +5, SCREEN_WEIGHT - 10, SCREEN_HEIGHT/4.0f - 10)];
        [_scrollview addSubview:button];
        [button setBackgroundColor:FlatGrayDark];
        button.layer.cornerRadius = 15.0f;
        
    }
    
    

    // Do any additional setup after loading the view.
    PulsingHaloLayer *layer = [PulsingHaloLayer layer];
    _halo = layer;
    _halo.haloLayerNumber = 5;
    _halo.radius = 0.4 * 200;
    _halo.animationDuration = 0.5 * 10;
    [_halo setBackgroundColor:RandomFlatColor.CGColor];
    

    
    UIButton *shiwordbtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT -70, SCREEN_HEIGHT -160, 40, 40)];
    shiwordbtn.backgroundColor = ClearColor;
    [shiwordbtn setImage:[UIImage imageNamed:@"食"] forState:UIControlStateNormal];
    [shiwordbtn setImage:[UIImage imageNamed:@"食"] forState:UIControlStateHighlighted];
    [self.view addSubview:shiwordbtn];
    
    shiwordbtn.layer.shadowOpacity = 0.7;
    shiwordbtn.layer.shadowColor = FlatGray.CGColor;
    shiwordbtn.layer.shadowRadius = 5;
    shiwordbtn.layer.shadowOffset = CGSizeMake(6, 6);
    
    _halo.position = shiwordbtn.center;
    
    
    [self.view.layer insertSublayer:_halo below:shiwordbtn.layer];
    
    [_halo start];
    
    
    
    IconAnimationView *iav = [[IconAnimationView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 79.0f, SCREEN_WEIGHT, 30)];
    [self.view addSubview:iav];
    
    
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
