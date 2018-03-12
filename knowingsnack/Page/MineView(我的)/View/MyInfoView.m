//
//  MyInfoView.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/27.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "MyInfoView.h"
#import "Header.h"
#import "RigisterViewController.h"
#import "HeaderIconImageView.h"

@interface MyInfoView()
{
    UIView *backview;
    
    //未登陆
    UILabel *lbl;
    
    //登陆
    HeaderIconImageView *_icon;
    UILabel *username;
    UILabel *email;
    UIView *line;
}
@end

@implementation MyInfoView


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    if (self) {
    
        backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        [self addSubview:backview];
        backview.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"mine_bg")];
        
        
        AVUser *user = [AVUser currentUser];
        
        
        if(user == nil)
        {
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w/2.0, h/2.0)];
            [backview addSubview:lbl];
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
            _icon = nil;
            AVFile *file =  [[AVUser currentUser] objectForKey:@"image"];
            [file getThumbnail:YES width:200 height:200 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
                _icon =  [[HeaderIconImageView alloc] initWithFrame:CGRectMake(20, 20, h - 40, h - 40) andImage:image];
                [backview addSubview:_icon];
                
                
                
                username = [[UILabel alloc] initWithFrame:CGRectMake(40 + h - 40, 40, w/2.0, h/4.0f)];
                [backview addSubview:username];
                username.text = user.username;
                username.textColor = FlatWhite;
                username.font = [UIFont boldSystemFontOfSize:22];
                
                email = [[UILabel alloc] initWithFrame:CGRectMake(40 + h - 40, 40  + 27, w, h/4.0f)];
                [backview addSubview:email];
                email.text = [NSString stringWithFormat:@"邮箱:%@",user.email];
                email.textColor = FlatWhite;
                email.font = [UIFont systemFontOfSize:8];
                
                line = [[UIView alloc] initWithFrame:CGRectMake(40 + h - 40, 40  + 27 +27, w *2.0/3.0, 1)];
                [backview addSubview:line];
                line.backgroundColor = FlatWhite;
                line.alpha = 0.4;
            }];
            
        }
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeLoginView) name:@"changeLoginView"
                                                   object:nil];
    }
    
    
    return self;
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeLoginView" object:nil];
}

-(void)changeLoginView
{
    for (UIView *view in [backview subviews]) {
        [view removeFromSuperview];
    }
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    AVUser *user = [AVUser currentUser];
    
    
    if(user == nil)
    {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w/2.0, h/2.0)];
        [backview addSubview:lbl];
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
        _icon = nil;
        AVFile *file =  [[AVUser currentUser] objectForKey:@"image"];
        [file getThumbnail:YES width:200 height:200 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
            _icon =  [[HeaderIconImageView alloc] initWithFrame:CGRectMake(20, 20, h - 40, h - 40) andImage:image];
            [backview addSubview:_icon];
            
            
            
            username = [[UILabel alloc] initWithFrame:CGRectMake(40 + h - 40, 40, w/2.0, h/4.0f)];
            [backview addSubview:username];
            username.text = user.username;
            username.textColor = FlatWhite;
            username.font = [UIFont boldSystemFontOfSize:22];
            
            email = [[UILabel alloc] initWithFrame:CGRectMake(40 + h - 40, 40  + 27, w, h/4.0f)];
            [backview addSubview:email];
            email.text = [NSString stringWithFormat:@"邮箱:%@",user.email];
            email.textColor = FlatWhite;
            email.font = [UIFont systemFontOfSize:8];
            
            line = [[UIView alloc] initWithFrame:CGRectMake(40 + h - 40, 40  + 27 +27, w *2.0/3.0, 1)];
            [backview addSubview:line];
            line.backgroundColor = FlatWhite;
            line.alpha = 0.4;
        }];
        
    }
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    AVUser *user = [AVUser currentUser];
    if(user == nil)
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
