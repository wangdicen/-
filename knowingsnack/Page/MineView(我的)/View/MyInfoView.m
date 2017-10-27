//
//  MyInfoView.m
//  knowingsnack
//
//  Created by 谢豪杰 on 2017/10/27.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "MyInfoView.h"
#import "Header.h"
#import "RigisterViewController.h"
#import "HeaderIconImageView.h"

@implementation MyInfoView


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    NSString *dataPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userinfo.archive"];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    UserInfo *info = [unArchiver decodeObjectForKey:@"userinfo"];
    [unArchiver finishDecoding];
    
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    if (self) {
    
        UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        [self addSubview:backview];
        backview.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"mine_bg")];
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"IS_LOGIN"])
        {
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w/2.0, h/2.0)];
            [self addSubview:lbl];
            lbl.backgroundColor = ClearColor;
            lbl.text = @"注册/登录";
            lbl.textColor = FlatWhite;
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.font = [UIFont boldSystemFontOfSize:23];
            [lbl.layer setBorderWidth:3];
            [lbl.layer setBorderColor:FlatWhite.CGColor];
            lbl.center = CGPointMake(w/2.0, h/2.0);
        }
        else{
            
            HeaderIconImageView *icon = [[HeaderIconImageView alloc] initWithFrame:CGRectMake(20, 20, h - 40, h - 40) andImage:IMAGE(@"header")];
            [self addSubview:icon];
        
            UILabel *username = [[UILabel alloc] initWithFrame:CGRectMake(40 + h - 40, 40, w/4.0, h/4.0f)];
            [self addSubview:username];
            username.text = info.username;
            username.textColor = FlatWhite;
            username.font = [UIFont boldSystemFontOfSize:22];
        
            UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(40 + h - 40, 40  + 27, w, h/4.0f)];
            [self addSubview:email];
            email.text = [NSString stringWithFormat:@"邮箱:%@(未激活)",info.email];
            email.textColor = FlatWhite;
            email.font = [UIFont systemFontOfSize:8];
        
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(40 + h - 40, 40  + 27 +27, w *2.0/3.0, 1)];
            [self addSubview:line];
            line.backgroundColor = FlatWhite;
             line.alpha = 0.4;
        
              UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 40  + 27 +22, w, h/4.0f)];
              [self addSubview:lbl];
              lbl.text = @"个人主页 >";
              lbl.textAlignment = NSTextAlignmentRight;
              lbl.textColor = FlatWhite;
              lbl.font = [UIFont boldSystemFontOfSize:11];
        }
    }
    
    
    return self;
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"IS_LOGIN"])
    {
        RigisterViewController *rvc = [[RigisterViewController alloc] init];
        [[self viewController] presentViewController:rvc animated:YES completion:nil];
    }
    else{
        //个人主页
    }
}

//获得view所在的controller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
