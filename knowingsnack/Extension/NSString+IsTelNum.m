//
//  NSString+IsTelNum.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/26.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "NSString+IsTelNum.h"

@implementation NSString (IsTelNum)

- (BOOL)isTelNum
{
    if (self.length <= 0) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}


- (BOOL)isRightKeyWord
{
    if (self.length <= 0) {
        return NO;
    }
    NSString *keyword = @"^[A-Za-z0-9]+$";
    NSPredicate *text = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",keyword];
    return [text evaluateWithObject:self];
    
}

- (BOOL)isEmail
{
    if (self.length <= 0) {
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
