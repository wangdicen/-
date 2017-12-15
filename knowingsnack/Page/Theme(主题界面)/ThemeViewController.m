//
//  ThemeViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/27.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "ThemeViewController.h"
#import "Header.h"
#import "ZAColorFullChooseView.h"
#import "AppIconImage.h"

@interface ThemeViewController ()<ColorChangeDelegate,UIScrollViewDelegate>
{
    UIImageView *_imageView;
    UIScrollView *_scroll;
    
    UIView *_kuang;
}
@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主题";
    self.view.backgroundColor = FlatWhiteDark;
    
    NSArray *color = @[FlatWhiteDark,FlatRed,FlatBlue,FlatGray,FlatLime,FlatMint,FlatPink,FlatPlum,FlatSand,FlatTeal,FlatBlack,FlatBrown,FlatGreen,FlatCoffee,FlatMaroon,FlatOrange,FlatPurple,FlatYellow,FlatMagenta,FlatRedDark,FlatSkyBlue,FlatBlueDark,FlatGrayDark,FlatLimeDark,FlatMintDark,FlatNavyBlue,FlatForestGreen,FlatWatermelon,FlatPowderBlue,FlatPinkDark,FlatPlumDark,FlatSandDark,FlatTealDark,FlatBlackDark,FlatBrownDark,FlatGreenDark,FlatWatermelonDark];
    
    ZAColorFullChooseView *colorView = [[ZAColorFullChooseView alloc]initGradientWithFrame:CGRectMake(kscreenWidth*0.1, 80, kscreenWidth*0.8, kscreenWidth*0.8) colorArray:color];
    colorView.delegate = self;
    [self.view addSubview:colorView];
    
    [colorView setColor:[UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1 ]];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 20)];
    lbl.backgroundColor = HexColorWithAlpha(FlatWhiteDark.hexValue, 0.8);
    lbl.layer.cornerRadius = 5.0f;
    lbl.text = @"旋转轮盘设置主题颜色";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = FlatBlack;
    lbl.font = [UIFont systemFontOfSize:11];
    lbl.center = CGPointMake(SCREEN_WEIGHT/2.0, colorView.center.y +colorView.frame.size.height/2.0 + 12);
    [self.view addSubview:lbl];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT/2.0, 1)];
    line.backgroundColor = FlatGray;
    [self.view addSubview:line];
    line.center = CGPointMake(SCREEN_WEIGHT/2.0, lbl.center.y + lbl.frame.size.height/2.0 + 3);
   
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 10.3) {
        

    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 20)];
    lbl2.backgroundColor = HexColorWithAlpha(FlatWhiteDark.hexValue, 0.8);
    lbl2.layer.cornerRadius = 5.0f;
    lbl2.text = @"主屏幕图标";
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.textColor = FlatBlack;
    lbl2.font = [UIFont systemFontOfSize:11];
    lbl2.center = CGPointMake(SCREEN_WEIGHT/2.0, line.center.y +line.frame.size.height/2.0 + 12);
    [self.view addSubview:lbl2];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT/3.0, SCREEN_WEIGHT/3.0)];
    _imageView.image = IMAGE(@"Image4");
    _imageView.clipsToBounds = YES;
    [_imageView.layer setCornerRadius:15];
    [self.view addSubview:_imageView];
    _imageView.center = CGPointMake(SCREEN_WEIGHT/2.0, lbl.center.y + 10 +SCREEN_WEIGHT/6.0 +25);
    
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/8.0 + 10)];
    _scroll.center = CGPointMake(SCREEN_WEIGHT/2.0, _imageView.center.y+_imageView.frame.size.height/2.0 + 8 +_scroll.frame.size.height /2.0f);
    _scroll.contentSize = CGSizeMake((SCREEN_HEIGHT/8.0 +8.0f) * 7.0 + 8.0f, SCREEN_HEIGHT/8.0);
//    [_scroll setContentOffset:CGPointMake(_scroll.contentSize.width/2.0 - SCREEN_WEIGHT/2.0 -8.0, 0)];
    _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;

    [self.view addSubview:_scroll];
        
        NSArray *array = @[@"鸿运当头",@"美好生活",@"蜂蜜柚子",@"知食知味",@"唯爱饮品",@"吃货无敌",@"极简之美"];
    
    for (int i = 0; i < 7;i ++) {
        NSString *imagename = [NSString stringWithFormat:@"Image%d",i+1];
        AppIconImage *image = [[AppIconImage alloc] initWithFrame:CGRectMake(8.0 *i + i *SCREEN_HEIGHT/8.0, 0.0, SCREEN_HEIGHT/8.0, SCREEN_HEIGHT/8.0)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT/8.0, 10)];
        label.center = CGPointMake(image.center.x, image.center.y + SCREEN_HEIGHT/16 +3);
        [_scroll addSubview:label];
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = FlatGrayDark;
        
        image.tag = 10000+i;
        image.isSelected = NO;
        if (i == [[NSUserDefaults standardUserDefaults] integerForKey:@"ICON_ID"]) {
            image.isSelected = YES;
            _imageView.image = IMAGE(imagename);
            if (i >3) {
                [_scroll setContentOffset:CGPointMake(_scroll.contentSize.width*3.0/7.0, 0)];
            }
        }
        [_scroll addSubview:image];
        image.image = IMAGE(imagename);
        image.clipsToBounds = YES;
        [image.layer setCornerRadius:45];
        
    }
      
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconchange:) name:@"iconchange" object:nil];
        
    }
}

-(void)iconchange:(NSNotification *)noti
{
    int index = [[noti.userInfo objectForKey:@"tag"] intValue] - 10000;
    
    for (UIView *image in _scroll.subviews) {
        if([image isKindOfClass:[AppIconImage class]])
        {
            AppIconImage *temp = (AppIconImage *)image;
            if (image.tag == index + 10000) {
                temp.isSelected = YES;
            }
            else
            {
                temp.isSelected = NO;
            }
        }
    }
    NSString *imagename = [NSString stringWithFormat:@"Image%d",index+1];
    _imageView.image = IMAGE(imagename);
    
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:imagename completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                NSLog(@"成功更换为%@",imagename);
                [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ICON_ID"];
            }else{
                NSLog(@"error:%@",error);
            }
        }];
    } else {
        // Fallback on earlier versions
    }
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"iconchange"];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
-(void)colorChangeWithColor:(UIColor *)color colorChooseView:(ZAColorChooseView *)colorChooseView
{

}


-(void)colorChangeStopWithColor:(UIColor *)color colorChooseView:(ZAColorChooseView *)colorChooseView
{
    
        [Chameleon setGlobalThemeUsingPrimaryColor:color withSecondaryColor:ClearColor andContentStyle:UIContentStyleContrast];
        [[NSUserDefaults standardUserDefaults] setObject:color.hexValue forKey:@"Main_Color"];

        
        if ([ContrastColor(color, YES) isEqual:FlatWhite]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        } else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    
      UIColor *contentColor;
      contentColor = ContrastColor(color, NO);
    
    
    [self.navigationController.navigationBar setBarTintColor:color];
    [self.navigationController.navigationBar setTintColor:contentColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:contentColor}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    

//    [self.tabBarController.tabBar setBarTintColor:FlatWhite];
//    [self.tabBarController.tabBar setTintColor:color];
    
    NSDictionary *dic = nil;
  if (CGColorEqualToColor(color.CGColor , FlatWhite.CGColor)) {
    dic = [NSDictionary dictionaryWithObject:FlatBlack forKey:@"color"];
  }
  else{
    dic = [NSDictionary dictionaryWithObject:color forKey:@"color"];

  }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTabbarColor" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changePlusBtnColor" object:nil userInfo:dic];

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
