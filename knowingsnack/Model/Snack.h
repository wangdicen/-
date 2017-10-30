//
//  Snack.h
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/30.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Snack : AVObject<AVSubclassing>

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSString *firm;
@property (nonatomic, copy, nullable) NSNumber *stars;
@property (nonatomic, copy, nullable) NSData *image;

-(void)commentSnackWithShortComment:(NSString *_Nullable)shortcomment
                              image:(UIImage *_Nonnull)image
                            starnum:(int)num;
-(void)updateSnackStarNum;

@end
