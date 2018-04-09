//
//  SnackDetailViewController.m
//  knowingsnack
//
//  Created by travelsky on 2017/12/18.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "SnackDetailViewController.h"
#import "Header.h"
#import "StaringVIewInSD.h"
#import "TwoButtonsView.h"
#import "CommonCommandView.h"
#import "UIImage+YYWebImage.h"
#import "UIImageView+YYWebImage.h"
#import "JHUD.h"
#import "StaringDetailViewController.h"
#import "CommentAllTableViewController.h"


@interface SnackDetailViewController ()<UIScrollViewDelegate,TwoButtonsViewDelegate>
{
    UIImageView *_mainImageView;
    UIView *_mainImageViewBackground;
    UIScrollView *_scrollview;
    StaringVIewInSD *_staringViewInSD;
    
    UILabel *_SnackName;
    
    UILabel *_titleView;
    UIView *_newTitleView;
    
    TwoButtonsView *_twoButton;
    
    
    UIView *_commandView;
    UIView *_grounpView;
    
    UILabel *lbl;
    
    UIButton *_likebtn;
}
@end

@implementation SnackDetailViewController


-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)initUI{
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT)];
    [self.view addSubview:_scrollview];
    _scrollview.contentSize = CGSizeMake(SCREEN_WEIGHT, SCREEN_HEIGHT *3.0f);
    _scrollview.delegate = self;
    _scrollview.backgroundColor = rgb(244, 249, 242);
    
    _mainImageViewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/2.0)];
    [_scrollview addSubview:_mainImageViewBackground];
    
    
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_HEIGHT/2.0 +44.0f - 150.f) * 142/172.0f, SCREEN_HEIGHT/2.0 +44.0f - 150.f)];
    _mainImageView.center =  CGPointMake(_mainImageViewBackground.frame.size.width/2.0f, _mainImageView.frame.size.height/2.0f + 45);
    [_scrollview addSubview:_mainImageView];
    
    _mainImageView.image = [UIImage imageNamed:@"demo"];
    _mainImageViewBackground.backgroundColor = [UIColor colorWithAverageColorFromImage:_mainImageView.image];
    
    
    _staringViewInSD = [[StaringVIewInSD alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    _staringViewInSD.center = CGPointMake(SCREEN_WEIGHT*4/5.0f, SCREEN_HEIGHT/2.0 + 80 );
    _staringViewInSD.starNum = 5;
    [_scrollview addSubview:_staringViewInSD];
    
    
    
    _SnackName = [[UILabel alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2.0 -5, SCREEN_WEIGHT*3/5.0f - 15.0f, 120)];
    [_scrollview addSubview:_SnackName];
    _SnackName.textAlignment = NSTextAlignmentLeft;
    _SnackName.numberOfLines = 2.0f;
    _SnackName.text = @"大波浪薯片:铁板鱿鱼味";
    _SnackName.font = [UIFont boldSystemFontOfSize:23];
    
    
    _likebtn = [[UIButton alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2.0 +100, SCREEN_WEIGHT*3/5.0f/3.f, 25)];
    [_scrollview addSubview:_likebtn];
    _likebtn.layer.cornerRadius = 5.f;
    _likebtn.layer.borderColor = FlatOrange.CGColor;
    _likebtn.layer.borderWidth = 1.f;
    
    
    [_likebtn setTitleColor:FlatOrange forState:UIControlStateNormal];
    _likebtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [_likebtn addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _newTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    _newTitleView.layer.cornerRadius = 14.0f;
    _newTitleView.backgroundColor = [UIColor whiteColor];
    
    
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 100, 24)];
    lbl.text = @"🔥757人正在热议..";
    lbl.textColor = FlatBlack;
    lbl.font = [UIFont systemFontOfSize:11.0f];
    [_newTitleView addSubview:lbl];
    
    
    _titleView =(UILabel *)self.navigationItem.titleView;
    self.navigationItem.titleView = _newTitleView;
    
    _twoButton = [[TwoButtonsView alloc] initWithFrame:CGRectMake(0, _staringViewInSD.center.y + _staringViewInSD.frame.size.height/2.0f + 20, SCREEN_WEIGHT, 60)];
    [self.view addSubview:_twoButton];
    _twoButton.delegate = self;
    _twoButton.backgroundColor = rgb(236, 241, 237);
    
    
//    _commandView = [[UIView alloc] initWithFrame:CGRectMake(0, _twoButton.frame.origin.y + 60.0f, SCREEN_WEIGHT, SCREEN_HEIGHT *3.0f - (_twoButton.frame.origin.y + 60.0f))];
//    [_scrollview addSubview:_commandView];
//
//    [self addCommands];
//    _commandView.backgroundColor = rgb(244, 249, 242);
//    
//    _grounpView = [[UIView alloc] initWithFrame:CGRectMake(0, _twoButton.frame.origin.y + 60.0f, SCREEN_WEIGHT, SCREEN_HEIGHT *3.0f - (_twoButton.frame.origin.y + 60.0f))];
//    [_scrollview addSubview:_grounpView];
//
//    [self addgroups];
//    _grounpView.backgroundColor = rgb(244, 249, 242);
//    _grounpView.hidden = YES;
}


- (void)like:(UIButton *)sender
{
    if (self.objectId == nil)
    {
        return;
    }
    //喜欢
    if ([sender.titleLabel.text isEqualToString:@"喜欢"]) {
        [sender setTitle:@"取消喜欢" forState:UIControlStateNormal];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *array = [userDefaults objectForKey:@"theArrayKey"];
        
        NSMutableArray *mutableCopyArray = [array mutableCopy];
        [mutableCopyArray addObject:self.objectId];
        [userDefaults setObject: mutableCopyArray forKey:@"theArrayKey"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    //取消喜欢
    else if ([sender.titleLabel.text isEqualToString:@"取消喜欢"])
    {
        [sender setTitle:@"喜欢" forState:UIControlStateNormal];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *array = [userDefaults objectForKey:@"theArrayKey"];
        
        NSMutableArray *mutableCopyArray = [array mutableCopy];
        [mutableCopyArray removeObject:self.objectId];
        [userDefaults setObject: mutableCopyArray forKey:@"theArrayKey"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _mainImageView.image = image;
}

-(void)setStars:(float)stars
{
    _stars = stars;
    _staringViewInSD.starNum = stars;
}

-(void)setName:(NSString *)name
{
    _name = name;
    _SnackName.text = name;
}

-(void)setObjectId:(NSString *)objectId
{
    _objectId = objectId;
    _staringViewInSD.objectID = objectId;
    
    [_commandView removeFromSuperview];
    [_grounpView removeFromSuperview];
    
    _commandView = [[UIView alloc] initWithFrame:CGRectMake(0, _twoButton.frame.origin.y + 60.0f, SCREEN_WEIGHT, SCREEN_HEIGHT *3.0f - (_twoButton.frame.origin.y + 60.0f))];
    [_scrollview addSubview:_commandView];
    
    [self addCommands];
    _commandView.backgroundColor = rgb(244, 249, 242);
    
    _grounpView = [[UIView alloc] initWithFrame:CGRectMake(0, _twoButton.frame.origin.y + 60.0f, SCREEN_WEIGHT, SCREEN_HEIGHT *3.0f - (_twoButton.frame.origin.y + 60.0f))];
    [_scrollview addSubview:_grounpView];
    
//    [self addgroups];
    _grounpView.backgroundColor = rgb(244, 249, 242);
    _grounpView.hidden = YES;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [userDefaults objectForKey:@"theArrayKey"];
    
    if ([array containsObject:objectId]) {
        [_likebtn setTitle:@"取消喜欢" forState:UIControlStateNormal];
    }
    else
    {
        [_likebtn setTitle:@"喜欢" forState:UIControlStateNormal];
    }
}

CGFloat COMMON_HEIGHT = 0;

- (void)addCommands
{
    float gHeight = _commandView.frame.size.height - 60;
    float oneHeight = gHeight/7.0f - 10;
    float oneWidth = SCREEN_WEIGHT - 10;
    

    
    
    AVQuery *query = [AVQuery queryWithClassName:@"snack_staring"];
    AVObject *object = [AVObject objectWithObjectId:self.objectId];
    [query whereKey:@"snackpointer" equalTo:object];
    query.limit = 1000;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        lbl.text = [NSString stringWithFormat:@"🔥%lu人正在热议..",objects.count] ;

        float aHeight = 0;
        
        if(objects.count == 0)
        {
            UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollview.contentSize.width, 250)];
            view.backgroundColor = rgb(244, 249, 242);
            [_commandView addSubview:view];
            _scrollview.contentSize = CGSizeMake(_scrollview.contentSize.width, _commandView.frame.origin.y + 250);
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            imageview.center = CGPointMake(view.center.x, 75);
            imageview.image = [UIImage imageNamed:@"nullData"];
            [view addSubview:imageview];
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, 45)];
            lbl.center = CGPointMake(view.center.x, 120);
            [view addSubview:lbl];
            lbl.numberOfLines = 2;
            lbl.text = @"暂时还没有人来评论哦!\n(点击右上\"知食评分\"框进行评论)";
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.textColor = FlatGray;
            
            [self addgroups];
            return;
        }
        
        for (int i =0; i<10; i++) {
            if (i>=objects.count) {
                break;
            }
            NSDictionary *object = objects[i];

            CommonCommandView *command = [[CommonCommandView alloc] initWithFrame:CGRectMake(5, COMMON_HEIGHT + 5, oneWidth, oneHeight)];
            [_commandView addSubview:command];
            AVUser *user = object[@"userpointer"];
            AVQuery *query2 = [AVQuery queryWithClassName:@"_User"];
            [query2 whereKey:@"objectId" equalTo:user.objectId];
            [query2 findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                if (objects != nil) {
                    NSDictionary *object2 = objects[0];
                    AVFile *file = object2[@"image"];
                    [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
                        command.image = image;
                        command.nametext = object2[@"username"];
                    }];
                }

            }];
            
            
            command.text = object[@"shortcomment"];
            command.starNum = [object[@"starnum"] floatValue] *2.0f;
            
            aHeight = command.frame.size.height;
            COMMON_HEIGHT = COMMON_HEIGHT + aHeight;
            
            NSLog(@"%f",COMMON_HEIGHT);
        }
        _scrollview.contentSize = CGSizeMake(_scrollview.contentSize.width, _commandView.frame.origin.y + COMMON_HEIGHT + 60);
        
        UIImageView *imageview = [UIImageView new];
        imageview.frame = CGRectMake(0, 0, SCREEN_WEIGHT -20, 40);
        imageview.layer.borderColor = FlatOrange.CGColor;
        imageview.layer.borderWidth = 2.0f;
        imageview.layer.cornerRadius = 8.0f;
        imageview.center = CGPointMake(SCREEN_WEIGHT/2.0f, _scrollview.contentSize.height - 30 - (_twoButton.frame.origin.y + 60.0f));
        [_commandView addSubview:imageview];
        
        UIButton *btn = [UIButton new];
        btn.frame = CGRectMake(0, 0, SCREEN_WEIGHT - 20, 40);
        btn.backgroundColor = [UIColor clearColor];
        [imageview addSubview:btn];
        [btn setTitle:@"更多评论  >>>" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [btn setTitleColor:FlatOrange forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        imageview.userInteractionEnabled = YES;
        
        [self addgroups];
    }];

}


- (void)moreBtnAction:(id)sender
{
    CommentAllTableViewController *catvc = [[CommentAllTableViewController alloc] init];
    catvc.title = @"更多";
    catvc.objectId = self.objectId;
    [self.navigationController pushViewController:catvc animated:YES];  
}

- (void)addgroups
{
    float gHeight = _grounpView.frame.size.height - 60;
    float oneHeight = gHeight/7.0f - 10;
//    float oneWidth = SCREEN_WEIGHT - 10;
    int maxNum = COMMON_HEIGHT/oneHeight - 1;
    
    for (int i =0; i<maxNum; i++) {
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, i * (oneHeight +10) + 5, oneWidth, oneHeight)];
//        [_grounpView addSubview:button];
//        [button setBackgroundColor:FlatGrayDark];
//        button.layer.cornerRadius = 15.0f;
    }
    
    
    UIImageView *imageview = [UIImageView new];
    imageview.frame = CGRectMake(0, 0, SCREEN_WEIGHT -20, 40);
    imageview.layer.borderColor = FlatGreen.CGColor;
    imageview.layer.borderWidth = 2.0f;
    imageview.layer.cornerRadius = 8.0f;
    imageview.center = CGPointMake(SCREEN_WEIGHT/2.0f, _scrollview.contentSize.height - 30 - (_twoButton.frame.origin.y + 60.0f));
    [_grounpView addSubview:imageview];
    
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, SCREEN_WEIGHT - 20, 40);
    btn.backgroundColor = [UIColor clearColor];
    [imageview addSubview:btn];
    [btn setTitle:@"开发中······" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [btn setTitleColor:FlatGreen forState:UIControlStateNormal];
}

- (void)afterButton1Select
{
    _commandView.hidden = NO;
    _grounpView.hidden = YES;
}

- (void)afterButton2Select
{
    _commandView.hidden = YES;
    _grounpView.hidden = NO;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat imageH = _staringViewInSD.center.y + _staringViewInSD.frame.size.height/2.0f + 20;


    if (offsetY > imageH) {
        self.navigationItem.titleView = _titleView;
    }
    else
    {
        self.navigationItem.titleView = _newTitleView;
    }
    
    // 该判断是实现scrollView内部的子控件悬停效果
    if (offsetY >= imageH) {
        // 将红色控件添加到控制器的view中，设置Y值为0
        CGRect redF = _twoButton.frame;
        redF.origin.y = 64.0f;
        _twoButton.frame = redF;
        [_twoButton removeFromSuperview];
        [self.view addSubview:_twoButton];
    }else{
        // 将红色控件添加到scrollView中，设置Y值为图片的高度
        CGRect redF = _twoButton.frame;
        redF.origin.y = _staringViewInSD.center.y + _staringViewInSD.frame.size.height/2.0f + 20;
        _twoButton.frame = redF;
        [_twoButton removeFromSuperview];
        [_scrollview addSubview:_twoButton];
    }
    
//    // 实现下拉放大顶部图片效果
//    CGFloat scale = 1 - (offsetY / 70);
//    scale = (scale >= 1) ? scale : 1;
//    self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    COMMON_HEIGHT = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
