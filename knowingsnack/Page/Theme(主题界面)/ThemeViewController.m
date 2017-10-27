//
//  ThemeViewController.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/27.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "ThemeViewController.h"
#import "Header.h"
#import "ZAColorFullChooseView.h"


@interface ThemeViewController ()<ColorChangeDelegate>

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主题";
    self.view.backgroundColor = FlatWhite;
    
    NSArray *color = @[FlatWhite,FlatRed,FlatBlue,FlatGray,FlatLime,FlatMint,FlatPink,FlatPlum,FlatSand,FlatTeal,FlatBlack,FlatBrown,FlatGreen,FlatCoffee,FlatMaroon,FlatOrange,FlatPurple,FlatYellow,FlatMagenta,FlatRedDark,FlatSkyBlue,FlatBlueDark,FlatGrayDark,FlatLimeDark,FlatMintDark,FlatNavyBlue,FlatForestGreen,FlatWatermelon,FlatPowderBlue,FlatPinkDark,FlatPlumDark,FlatSandDark,FlatTealDark,FlatBlackDark,FlatBrownDark,FlatGreenDark,FlatWatermelonDark];
    
    ZAColorFullChooseView *colorView = [[ZAColorFullChooseView alloc]initGradientWithFrame:CGRectMake(kscreenWidth*0.1, 80, kscreenWidth*0.8, kscreenWidth*0.8) colorArray:color];
    colorView.delegate = self;
    [self.view addSubview:colorView];
    
    [colorView setColor:[UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1 ]];
    
}

-(void)colorChangeWithColor:(UIColor *)color colorChooseView:(ZAColorChooseView *)colorChooseView
{

}


-(void)colorChangeStopWithColor:(UIColor *)color colorChooseView:(ZAColorChooseView *)colorChooseView
{
    
        [Chameleon setGlobalThemeUsingPrimaryColor:color withSecondaryColor:ClearColor andContentStyle:UIContentStyleContrast];
    
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
