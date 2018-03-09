//
//  StaringViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "StaringViewController.h"
#import "YNPageScrollViewMenuConfigration.h"
#import "YNJianShuDemoViewController.h"

#import "SnackViewController.h"
#import "DrinkViewController.h"
#import "FangBianViewController.h"
#import "FruitViewController.h"
#import "SweetViewController.h"
#import "SpicyViewController.h"
#import "MeatViewController.h"
#import "MJRefresh.h"
#import"SnackBaseViewController.h"
#import "SearchDetailViewController.h"
#import"Header.h"


@interface StaringViewController ()<YNPageScrollViewControllerDataSource>

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation StaringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    YNJianShuDemoViewController *viewController = [self getJianShuDemoViewController];
    [viewController addSelfToParentViewController:self isAfterLoadData:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToLike) name:@"GoToLike" object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GoToLike" object:nil];
}
- (void)goToLike
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [userDefaults objectForKey:@"theArrayKey"];
    
    [self setHidesBottomBarWhenPushed:YES];
    
    SearchDetailViewController *sdvc = [[SearchDetailViewController alloc] init];
    sdvc.title = @"喜欢";
    sdvc.likesArray =  array;
    [self.navigationController pushViewController:sdvc animated:YES];
}


- (YNJianShuDemoViewController *)getJianShuDemoViewController{
    
    //配置信息
    YNPageScrollViewMenuConfigration *configration = [[YNPageScrollViewMenuConfigration alloc]init];
    configration.itemLeftAndRightMargin = 30;
    configration.lineColor = FlatBlack;
    configration.lineHeight = 2;
    configration.itemMaxScale = 0.8;
    configration.pageScrollViewMenuStyle = YNPageScrollViewMenuStyleTop;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = FlatBlack;
    configration.menuHeight = 35.f;
    //设置平分不滚动   默认会居中
    configration.aligmentModeCenter = NO;
    configration.scrollMenu = YES;
    configration.showGradientColor = NO;//取消渐变
    configration.showNavigation = YES;
    configration.showTabbar = NO;//设置显示tabbar
    
    //创建控制器
    YNJianShuDemoViewController *vc = [YNJianShuDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"零食",@"饮料&饮品",@"方便食品",@"果干&坚果",@"甜食",@"辣食",@"肉制品"] Configration:configration];

    
    //footer用来当做内容高度
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
//    footerView.backgroundColor = FlatRed;
//    vc.placeHoderView = footerView;
    
    vc.dataSource = self;
    vc.headerView = nil;
    
    return vc;
}

- (NSArray *)getViewController{
    
    SnackViewController *one = [[SnackViewController alloc]init];
    
    DrinkViewController *two = [[DrinkViewController alloc]init];
    
    FangBianViewController *three = [[FangBianViewController alloc]init];
    
    FruitViewController *four = [[FruitViewController alloc]init];
    
    SweetViewController *one1 = [[SweetViewController alloc]init];
    
    SpicyViewController *two1 = [[SpicyViewController alloc]init];
    
    MeatViewController *three1 = [[MeatViewController alloc]init];
    
//    YNTestFourViewController *four1 = [[YNTestFourViewController alloc]init];
    
    return @[one,two,three,four,one1,two1,three1];
}

#pragma mark - YNPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    SnackViewController *VC= pageScrollViewController.viewControllers[index];
    return [VC tableView];
    
};

- (BOOL)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{

    SnackViewController *VC= pageScrollViewController.viewControllers[index];
    return [[[VC tableView] mj_header] isRefreshing];
}

- (void)pageScrollViewController:(YNPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{

    SnackViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy

- (UIActivityIndicatorView *)loadingView{
    
    if (!_loadingView) {
        
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.hidesWhenStopped = YES;
        _loadingView.center = self.view.center;
        [self.view addSubview:_loadingView];
    }
    
    return _loadingView;
}
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed=NO;
}
- (void)createTabbarItems
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49 + 5)];
    [imageView setImage:[self createImageWithColor:[UIColor clearColor]]];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [self.tabBarController.tabBar insertSubview:imageView atIndex:0];
    //覆盖原生Tabbar的上横线
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    // 背景图片为透明色
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    self.tabBarController.tabBar.translucent = YES;
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
