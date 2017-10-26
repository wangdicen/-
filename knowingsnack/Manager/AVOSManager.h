//
//  AVOSManager.h
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/26.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "MyUtil.h"

@interface AVOSManager : NSObject

SingleH(AVOSManager)

- (void)archiverUserInfoWithUserPhoneNum:(NSString *)phonenum;

@end
