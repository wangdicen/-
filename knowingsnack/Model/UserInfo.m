//
//  UserInfo.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/26.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


//编码成可以持久化的格式,归档时调用
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //对每个属性都要进行重新编码
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.password forKey:@"password"];
    
    [aCoder encodeObject:self.image forKey:@"image"];
    
    [aCoder encodeObject:self.mobilePhoneNumber forKey:@"mobilePhoneNumber"];
    [aCoder encodeBool:self.mobilePhoneVerified forKey:@"mobilePhoneVerified"];

    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeBool:self.emailVerified forKey:@"emailVerified"];
}

//解码过程,反归档时调用
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        //解码的key要和编码时给的key一致
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        
        self.image = [aDecoder decodeObjectForKey:@"image"];
        
        self.mobilePhoneNumber = [aDecoder decodeObjectForKey:@"mobilePhoneNumber"];
        self.mobilePhoneVerified = [aDecoder decodeBoolForKey:@"mobilePhoneVerified"];
    
        self.mobilePhoneNumber = [aDecoder decodeObjectForKey:@"email"];
        self.mobilePhoneVerified = [aDecoder decodeBoolForKey:@"emailVerified"];
    }
    return self;
}

@end
