//
//  WDCTabBarController.m
//  Exercise
//
//  Created by 汪迪岑 on 2017/10/23.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "WDCTabBarController.h"
#import "WDCTabBar.h"
#import <objc/runtime.h>
#import "UIImage+ChangeImageColor.h"
#import "BHBPopView.h"
#import "ZSSLargeViewController.h"
#import "UIApplication+Visible.h"
#import "RecommendViewController.h"
#import "ChangePicViewController.h"

NSUInteger WDCTabbarItemsCount = 0;


@interface UIViewController (WDCTabBarControllerItemInternal)


- (void)wdc_setTabBarController:(WDCTabBarController *)tabBarController;

@end



@interface WDCTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation WDCTabBarController
@synthesize viewControllers = _viewControllers;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTabBar];
    self.delegate = self;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addButtonClicked) name:@"AddButtonClicked" object:nil];
}


- (void)addButtonClicked
{
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"写长评" Icon:@"images.bundle/fruiticons_buttons_watermelon"];
    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"推荐零食" Icon:@"images.bundle/fruiticons_buttons_strawberry"];
    BHBItem * item2 = [[BHBItem alloc]initWithTitle:@"更换图片" Icon:@"images.bundle/fruiticons_buttons_pineapple"];
    
    [BHBPopView showToView:self.view.window withItems:@[item0,item1,item2] andSelectBlock:^(BHBItem *item) {
        if ([item isKindOfClass:[BHBGroup class]]) {
            NSLog(@"选中%@分组",item.title);
            
        }else{
            NSLog(@"选中%@项",item.title);
            if ([item.title isEqualToString:@"写长评"]) {
                ZSSLargeViewController *viewController = [[ZSSLargeViewController alloc] init];

                viewController.hidesBottomBarWhenPushed = YES;
                
                UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
                [nav pushViewController:viewController animated:YES];
            }
            else if ([item.title isEqualToString:@"推荐零食"]) {
                RecommendViewController *viewController = [[RecommendViewController alloc] init];
                
                viewController.hidesBottomBarWhenPushed = YES;
                
                UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
                [nav pushViewController:viewController animated:YES];
            }
            else if ([item.title isEqualToString:@"更换图片"]) {
                ChangePicViewController *viewController = [[ChangePicViewController alloc] init];
                
                viewController.hidesBottomBarWhenPushed = YES;
                
                UINavigationController *nav = [[UIApplication sharedApplication] visibleNavigationController];
                [nav pushViewController:viewController animated:YES];
            }
        }
    }];
}

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar {
    [self setValue:[[WDCTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in _viewControllers) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        _viewControllers = [viewControllers copy];
        if (_tabBarItemsAttributes) {
            if (_tabBarItemsAttributes.count != _viewControllers.count) {
                [NSException raise:@"BTTabBarController" format:@"The count of CYLTabBarControllers is not equal to the count of tabBarItemsAttributes.【中文】设置_tabBarItemsAttributes属性时，请确保元素个数与控制器的个数相同，并在方法`-setViewControllers:`之前设置"];
            }
        }
        WDCTabbarItemsCount = [viewControllers count];
        NSUInteger idx = 0;
        for (UIViewController *viewController in viewControllers) {
            [self addOneChildViewController:viewController
                                  WithTitle:_tabBarItemsAttributes[idx][WDCTabBarItemTitle]
                            normalImageName:_tabBarItemsAttributes[idx][WDCTabBarItemImage]
                          selectedImageName:_tabBarItemsAttributes[idx][WDCTabBarItemSelectedImage]
                                        tag:idx];
            [viewController wdc_setTabBarController:self];
            idx++;
        }
    } else {
        for (UIViewController *viewController in _viewControllers) {
            [viewController wdc_setTabBarController:nil];
        }
        _viewControllers = nil;
    }
}


- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName
                              tag:(NSInteger)tag
{
    
    viewController.tabBarItem.title         = title;
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image         = normalImage;
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    viewController.tabBarItem.tag = tag;
    
    [self addChildViewController:viewController];
    
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



#pragma mark - UIViewController+WDCTabBarControllerItem

@implementation UIViewController (WDCTabBarControllerItemInternal)

- (void)wdc_setTabBarController:(WDCTabBarController *)tabBarController {
    objc_setAssociatedObject(self, @selector(wdc_tabBarController), tabBarController, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIViewController (CYLTabBarController)

- (WDCTabBarController *)cyl_tabBarController {
    WDCTabBarController *tabBarController = objc_getAssociatedObject(self, @selector(cyl_tabBarController));
    
    if (!tabBarController && self.parentViewController) {
        tabBarController = [self.parentViewController cyl_tabBarController];
    }
    
    return tabBarController;
}

@end
