//
//  AppDelegate.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "WDCTabBarControllerConfig.h"
#import "Chameleon.h"
#import "LunchView.h"
#import "Header.h"

@interface AppDelegate ()
{
    WDCTabBarControllerConfig *_tabBarControllerConfig;
    LunchView *_launchview;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarStyle = UIStatusBarStyleLightContent;
   
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
   
    
    _tabBarControllerConfig = [[WDCTabBarControllerConfig alloc] init];
    [self.window setRootViewController:_tabBarControllerConfig.tabBarController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"changeTabbarColor" object:nil];
    
    
    _launchview = [[LunchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    [self.window addSubview:_launchview];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate date]];
    
    
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"once"]) {
        /**
         *  做你想在整个APP生命里只做一次的事
         */
        [[NSUserDefaults standardUserDefaults] setObject:FlatOrange.hexValue forKey:@"Main_Color"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IS_LOGIN"];
        [[NSUserDefaults standardUserDefaults] setInteger:3  forKey:@"ICON_ID"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"once"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
    //设置全局主题
    [Chameleon setGlobalThemeUsingPrimaryColor:MainColor  withSecondaryColor:ClearColor andContentStyle:UIContentStyleContrast];
    NSDictionary *dic = nil;
    if (CGColorEqualToColor(MainColor.CGColor , FlatWhite.CGColor)) {
        dic = [NSDictionary dictionaryWithObject:FlatBlack forKey:@"color"];
    }
    else{
        dic = [NSDictionary dictionaryWithObject:MainColor forKey:@"color"];
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTabbarColor" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changePlusBtnColor" object:nil userInfo:dic];
    
    //打开leancloud后台服务
    [AVOSCloud setApplicationId:@"IvIeHgl0vQy5Q0U32dXVxHEB-gzGzoHsz" clientKey:@"toMwLOrJhs0Pe68blBsak6La"];
    //使用leancloud进行统计
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}


int time_num = 0;
-(void)timer:(NSTimer *)sender{
    
    if (time_num == 2) {
        [sender setFireDate:[NSDate distantFuture]];
        [sender invalidate];
        sender = nil;
        [UIView animateWithDuration:0.5 animations:^{
            _launchview.alpha = 0.0f;
        }];
      
    }
    
    
    time_num ++;
}

- (void)changeColor:(NSNotification *)noti
{
    NSDictionary *data = [noti userInfo];
    UIColor *color = [data objectForKey:@"color"];
    [_tabBarControllerConfig setColorWithColor:color];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
