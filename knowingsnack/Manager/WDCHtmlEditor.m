//
//  WDCHtmlEditor.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/24.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "WDCHtmlEditor.h"

@implementation WDCHtmlEditor

+(NSArray *)arrayOfImg:(NSString *)html{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
}

+(NSString *)stringOfH1:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<h1>" intoString:nil];
        [scanner scanUpToString:@"</h1>" intoString:&text];
        html = [text stringByReplacingOccurrencesOfString:@"<h1>" withString:@""];
        return html;
    }
    return html;
}

+(NSString *)stringOfP:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    NSString *h1 = [self stringOfH1:html];
    if (h1 != nil) {
        html = [html stringByReplacingOccurrencesOfString:h1 withString:@""];
    }
    html =  [html stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}

@end
