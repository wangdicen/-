//
//  AVOSManager.h
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/26.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "MyUtil.h"

@interface AVOSManager : NSObject

SingleH(AVOSManager)

- (void)queryUserInfoAndArchierFromBackgroundWithEmail:(NSString *)email;

-(UserInfo *)getUserInfo;

@end
