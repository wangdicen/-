//
//  Snack.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/30.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "Snack.h"
#import "XHToast.h"

@implementation Snack


+ (NSString *)parseClassName
{
    return @"Snack";
}

-(void)commentSnackWithShortComment:(NSString *)shortcomment
                            starnum:(int)num{
//    AVObject *snack = [AVObject objectWithClassName:[Snack parseClassName] objectId:self.objectId];
    AVObject *snack_staring = [[AVObject alloc] initWithClassName:@"snack_staring"];
   
    [snack_staring setObject:shortcomment forKey:@"shortcomment"];
//    NSData *data = UIImagePNGRepresentation(image);
//    AVFile *file = [AVFile fileWithData:data];
//    [snack_staring setObject:file forKey:@"shortcommentimage"];
    [snack_staring setObject:[NSNumber numberWithInt:num] forKey:@"starnum"];
    [snack_staring setObject:[AVUser currentUser] forKey:@"userpointer"];
    [snack_staring setObject:self forKey:@"snackpointer"];
    
    [snack_staring saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [XHToast showTopWithText:@"评论成功"];
            [self updateSnackStarNum];
        }else
        {
            [XHToast showTopWithText:@"评论失败"];
        }
    }];
}

-(void)updateSnackStarNum
{
    AVQuery *query = [AVQuery queryWithClassName:@"snack_staring"];
    [query whereKey:@"snackpointer" equalTo:self];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        int totalstars = 0;
        for (AVObject *snack_staring in objects) {
            totalstars +=  [[snack_staring objectForKey:@"starnum"] intValue];
        }
        AVObject *snack = [AVObject objectWithClassName:[Snack parseClassName] objectId:self.objectId];
        self.stars = [NSNumber numberWithFloat:(float)totalstars/(float)objects.count];
        [snack setObject:self.stars forKey:@"stars"];
        [snack saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            
            
            
            
        }];
    }];
}




@end
