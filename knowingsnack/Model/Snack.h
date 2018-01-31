//
//  Snack.h
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/30.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Snack : AVObject<AVSubclassing>

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSNumber *stars;


-(void)commentSnackWithShortComment:(NSString *_Nullable)shortcomment
                            starnum:(int)num;
-(void)updateSnackStarNum;

@end
