//
//  WDCHtmlEditor.h
//  knowingsnack
//
//  Created by travelsky on 2018/1/24.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDCHtmlEditor : NSObject

+(NSArray *)arrayOfImg:(NSString *)html;

+(NSString *)stringOfH1:(NSString *)html;

+(NSString *)stringOfP:(NSString *)html;


@end
