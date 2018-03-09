//
//  GuassULikeView.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/13.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "GuassULikeView.h"
#import "CWStarRateView.h"
#import "Chameleon.h"
#import "Header.h"
#import "SnackDetailViewController.h"

@interface GuassULikeView()
{
    UIImageView *_imageview;
    UILabel *_titlelbl;
    CWStarRateView *_starview;
    UILabel *_starnumlbl;
    UILabel *_factorylbl;
    UILabel *_aboutkindlbl;
    UILabel *_onetextlbl;
    UIButton *_morebutton;
    
    NSString *_objectID;
}
@end

@implementation GuassULikeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height = frame.size.height;
        
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, (height -30.0f) * 147.0/172.0f, height -30.0f)];
        _imageview.backgroundColor = FlatWhiteDark;
        _imageview.layer.borderWidth = 1.0f;
        _imageview.layer.borderColor = FlatWhite.CGColor;
        _imageview.layer.shadowOpacity = 0.7;
        _imageview.layer.shadowColor = FlatGray.CGColor;
        _imageview.layer.shadowRadius = 5;
        _imageview.layer.shadowOffset = CGSizeMake(6, 6);
        [self addSubview:_imageview];
        
        _titlelbl =[[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15,
                                                             15,
                                                             SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30,
                                                             (height - 30)/5.0f)];
        [self addSubview:_titlelbl];
        _titlelbl.text = @"加载中···";
        _titlelbl.font = [UIFont boldSystemFontOfSize:18.0f];
        _titlelbl.textColor = [UIColor blackColor];
        
        _starview = [[CWStarRateView alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15, 15 + CGRectGetHeight(_titlelbl.frame) + 2, 80, 25)];
        _starview.allowIncompleteStar = YES;
        _starview.userInteractionEnabled = NO;
        [self addSubview:_starview];
        
        _starnumlbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15 +85, 15 + CGRectGetHeight(_titlelbl.frame) + 2, 30, 25)];
        [self addSubview:_starnumlbl];
        _starnumlbl.textColor = FlatGray;
        _starnumlbl.text = @"10.0";
        _starnumlbl.font = [UIFont systemFontOfSize:14.0f];
        
        _factorylbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15,
                                                                15 + CGRectGetHeight(_titlelbl.frame) + CGRectGetHeight(_starview.frame) + 4,
                                                                SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30,
                                                                18)];
        [self addSubview:_factorylbl];
        _factorylbl.textColor = FlatGray;
//        _factorylbl.text = @"厂商：隔壁二大爷开的零食小卖部";
        _factorylbl.font = [UIFont systemFontOfSize:10.0f];
        

        _aboutkindlbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15,
                                                                  15 + CGRectGetHeight(_titlelbl.frame) + CGRectGetHeight(_starview.frame)+ CGRectGetHeight(_factorylbl.frame)+ 6,
                                                                  SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30,
                                                                  18)];
        [self addSubview:_aboutkindlbl];
        _aboutkindlbl.textColor = FlatGray;
//        _aboutkindlbl.text = @"抹茶/饼干/重口味/甜食";
        _aboutkindlbl.font = [UIFont systemFontOfSize:10.0f];
        
        
        _onetextlbl = [[UILabel alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15, height - 35,  SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30, 20)];
        [self addSubview:_onetextlbl];
        _onetextlbl.textColor = FlatBlackDark;
//        _onetextlbl.text = @"2000+重口味的推荐";
        _onetextlbl.font = [UIFont systemFontOfSize:12.0f];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15, height - 52,  SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30 - 5, 1)];
        line1.backgroundColor = RGB(233, 233, 233, 0.6);
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1,  SCREEN_WEIGHT, 1)];
        line2.backgroundColor = RGB(233, 233, 233, 0.6);
        [self addSubview:line2];
        
    }
    
    return self;
}

- (void)addRankNum:(int)ranknum
{
    
    
    if (ranknum == 1 ||ranknum == 2||ranknum == 3) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT/4.0 *(23.f/32.f), SCREEN_HEIGHT/4.0)];
        [self addSubview:imageview];
        [self sendSubviewToBack:imageview];
        imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"top%d",ranknum]];
        imageview.center = CGPointMake(SCREEN_WEIGHT - imageview.frame.size.width/2.0f, SCREEN_HEIGHT/8.0);
        return;
    }
    CGFloat height = self.frame.size.height;

    _titlelbl.frame = CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15,
                                                         15 + 30,
                                                         SCREEN_WEIGHT - CGRectGetWidth(_imageview.frame) - 30,
                                                         (height - 30)/5.0f);
    _starview.frame = CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15, 15 + CGRectGetHeight(_titlelbl.frame) + 2 + 30, 80, 25);
    
    _starnumlbl.frame = CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15 +85, 15 + CGRectGetHeight(_titlelbl.frame) + 2 + 30, 30, 25);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15 + CGRectGetWidth(_imageview.frame) +15 ,
                                                            15 +5,
                                                            40,
                                                            20)];
    [self addSubview:view];
    view.layer.cornerRadius = 4.0f;
    view.backgroundColor = FlatYellow;
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    [self addSubview:label];
    [label setText:[NSString stringWithFormat:@"Top%d",ranknum]];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [label setTextColor:FlatBrown];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SnackDetailViewController *sdvc = [[SnackDetailViewController alloc] init];
    [sdvc setHidesBottomBarWhenPushed:YES];
    [[self viewController].navigationController pushViewController:sdvc animated:YES];
    
    sdvc.title = _titlelbl.text;
    sdvc.name = _titlelbl.text;
    sdvc.image = _imageview.image;
    sdvc.stars = _starview.scorePercent * 5.f;
    sdvc.view.backgroundColor = FlatWhite;
    sdvc.objectId = _objectID;
    
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


-(void)fetchDataInBackground:(int)index
{
    AVQuery *query = [AVQuery queryWithClassName:@"Snack"];
    [query whereKey:@"classification" equalTo:[self typeString]];
    
    query.limit = 1000;

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
        
        if (index < objects.count) {
            AVFile *file = [objects[index] objectForKey:@"image"];
            [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                UIImage *image = [UIImage imageWithData:data];
                _imageview.image = image;
                _titlelbl.text = [objects[index] objectForKey:@"name"];
                _starview.scorePercent = [[objects[index] objectForKey:@"stars"] floatValue]/5.f;
                _starnumlbl.text = [NSString stringWithFormat:@"%.1f",[[objects[index] objectForKey:@"stars"] floatValue] * 2];
                _objectID = [objects[index] objectForKey:@"objectId"];

            }];
            
        }
    }];
}

-(NSString *)typeString
{
    switch (self.viewcontrollertype) {
        case NameSnackViewController:
            return @"snack";
            break;
        case NameDrinkViewController:
            return @"drink";
            break;
        case NameMeatViewController:
            return @"meat";
            break;
        case NameFruitViewController:
            return @"fruit";
            break;
        case NameSpicyViewController:
            return @"spicy";
            break;
        case NameSweetViewController:
            return @"sweet";
            break;
        case NameFangBianViewController:
            return @"fangbian";
            break;
        default:
            break;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
