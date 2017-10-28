//
//  Header.h
//  wheretotravel2
//
//  Created by 汪迪岑 on 2017/10/2.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#ifndef Header_h
#define Header_h

#ifdef __OBJC__


#define SCREEN_WEIGHT  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define RGB(a,b,c,d)     [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
#define EDGE_NUM 3.0
#define IMAGE(a) [UIImage imageNamed:a]

#define MainColor [UIColor colorWithHexString:[[NSUserDefaults standardUserDefaults] objectForKey:@"Main_Color"]]


#endif

#import "Chameleon.h"
#import "NSString+IsTelNum.h"
#import "XHToast.h"
#import "UserInfo.h"
#import <AVOSCloud/AVOSCloud.h>


#import "AVOSManager.h"
#import "UserInfoManager.h"

#endif /* Header_h */
