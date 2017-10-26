//
//  UserInfo.h
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/26.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSData *image;

@property (nonatomic, strong) NSString *mobilePhoneNumber;
@property (nonatomic, assign) BOOL mobilePhoneVerified;

@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) BOOL emailVerified;

@end
