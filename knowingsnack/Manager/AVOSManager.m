//
//  AVOSManager.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/26.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "AVOSManager.h"

@implementation AVOSManager

SingleM(AVOSManager)

- (void)queryUserInfoAndArchierFromBackgroundWithEmail:(NSString *)email{
    UserInfo *userinfo = [[UserInfo alloc] init];
    
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    if ([email isEmail]) {
        [query whereKey:@"email" equalTo:email];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if(objects.count != 0)
        {
        AVObject *object = [objects objectAtIndex:0];
        userinfo.username = [object objectForKey:@"username"];
        userinfo.password = [object objectForKey:@"password"];
        userinfo.image = [[object objectForKey:@"image"] getData];
        
        userinfo.email =[object objectForKey:@"email"];
        userinfo.emailVerified = [object objectForKey:@"emailVerified"];
        
        
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:userinfo forKey:@"userinfo"];
        [archiver finishEncoding];
        
        NSString *dataPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userinfo.archive"];
        [data writeToFile:dataPath atomically:YES];
        }
        
    }];
}

@end
