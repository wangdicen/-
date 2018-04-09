
//
//  MainViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/25.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "MainViewController.h"
#import "Chameleon.h"
#import "MainNavView.h"
#import "Header.h"
#import "RigisterViewController.h"
#import "Snack.h"
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshAutoFooter.h"
#import "UIViewController+YNCategory.h"
#import "YNPageScrollViewController.h"
#import "OneCellView.h"
#import "PlusViewController.h"
#import "AppDelegate.h"
#import "UINavigationController+WXSTransition.h"

#import "BHBPopView.h"

#import "ZSSLargeViewController.h"
#import "ArticleViewController.h"
#import "WDCSearchView.h"
#import "SearchDetailViewController.h"

#import "InfomationViewController.h"
#import "IconAnimationView.h"

@interface MainViewController ()
{
    UIButton *chatBtn;
    
    NSString *_html;
    
    WDCSearchView *_searchView;
    
    MainNavView *navbar;
    
    IconAnimationView *_iav;
    
}
@property (nonatomic, strong) NSMutableArray *datasArrayM;

@property (nonatomic, weak) UIActivityIndicatorView *indicatorView ;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, assign) BOOL isFirst;



@end

//是否带刷新
#define HasHeaderRefresh 0
//是否有loading和无数据view
#define HasLoadingAndNotDataView 0

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    navbar = [[MainNavView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WEIGHT*0.80f,35)];
    UIBarButtonItem *navLeft = [[UIBarButtonItem alloc] initWithCustomView:navbar];
    [self.navigationItem setLeftBarButtonItem:navLeft];
    

    chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    chatBtn.center = CGPointMake(SCREEN_WEIGHT - self.navigationController.navigationBar.frame.size.height/2.0 - 5.0f, self.navigationController.navigationBar.frame.size.height/2.0f);
    chatBtn.backgroundColor = ClearColor;
    [chatBtn addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    [chatBtn setImage:IMAGE(@"setting_theme") forState:UIControlStateNormal];
    [chatBtn setImage:IMAGE(@"setting_theme") forState:UIControlStateSelected];

    [self.navigationController.navigationBar addSubview:chatBtn];

    
    [self.view addSubview:self.tableView];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setDataSource];
//    });
    
//    __weak typeof (MainViewController *)weakself = self;
//
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSInteger count = weakself.datasArrayM.count;
//            for (int i = 0; i < 2; i++) {
//                [weakself.datasArrayM insertObject:[NSString stringWithFormat:@" 刷新数据 %zd",count + i] atIndex:0];
//            }
//            NSLog(@"上啦加载完成");
//            [weakself.tableView.mj_header endRefreshing];
//            [weakself.tableView reloadData];
//            //调整占位图footer
//            [weakself.ynPageScrollViewController reloadPlaceHoderViewFrame];
//            [weakself.indicatorView stopAnimating];
//            weakself.label.hidden = NO;
//        });
//    }];
    
//    if (!HasHeaderRefresh) {
//        self.tableView.mj_header = nil;
//    }
    
//
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
////            NSInteger count = weakself.datasArrayM.count;
////            for (int i = 0; i < 20; i++) {
////                [weakself.datasArrayM addObject:[NSString stringWithFormat:@" 加载数据 %zd",count + i]];
////            }
//            NSLog(@"下拉加载完成");
//            [weakself.tableView.mj_footer endRefreshing];
//
//            [weakself.tableView reloadData];
//            //调整占位图footer
//            [weakself.ynPageScrollViewController reloadPlaceHoderViewFrame];
//
//            [weakself.indicatorView stopAnimating];
//            weakself.label.hidden = NO;
//        });
//    }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeToCancel:) name:@"ChatBtn_changeToCancel" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToSearchDetail:) name:@"goToSearchDetail" object:nil];
    
    
    _iav = [[IconAnimationView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 79.0f, SCREEN_WEIGHT, 30)];
    [self.view addSubview:_iav];
    
    
    
    _searchView = [[WDCSearchView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WEIGHT, SCREEN_HEIGHT - 64)];
    _searchView.alpha = 0.0;
    [self.view addSubview:_searchView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_iav animate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    chatBtn.alpha = 1.0f;
    if ([chatBtn.titleLabel.text isEqualToString:@"取消"]) {
        [navbar.searchbar becomeFirstResponder];
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChatBtn_changeToChatBtn" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChatBtn_changeToCancel" object:nil];
}

- (void)changeToCancel:(NSNotification *)noti
{
    [chatBtn setImage:nil forState:UIControlStateNormal];
    [chatBtn setImage:nil forState:UIControlStateSelected];
    [chatBtn setTitle:@"取消" forState:UIControlStateNormal];
    [chatBtn setTitle:@"取消" forState:UIControlStateSelected];
    [chatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    chatBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
    [UIView animateWithDuration:0.5 animations:^{
        _searchView.alpha = 1.0;
    }];

}

-(void)chatAction
{
    if ([chatBtn.titleLabel.text isEqualToString:@"取消"]) {
        [UIView animateWithDuration:0.5 animations:^{
            _searchView.alpha = 0.0;
        }];
        [chatBtn setImage:IMAGE(@"setting_theme") forState:UIControlStateNormal];
        [chatBtn setImage:IMAGE(@"setting_theme") forState:UIControlStateSelected];
        [chatBtn setTitle:@"" forState:UIControlStateNormal];
        [chatBtn setTitle:@"" forState:UIControlStateSelected];
        chatBtn.titleLabel.text = @"";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hidesKeyboard" object:nil];
    }
    else
    {
        [self goToRigister:chatBtn];
    }
}

- (void)goToSearchDetail:(NSNotification *)noti
{
    [UIView animateWithDuration:0.5 animations:^{
        _searchView.alpha = 0.0;
    }];
    [chatBtn setImage:IMAGE(@"setting_theme") forState:UIControlStateNormal];
    [chatBtn setImage:IMAGE(@"setting_theme") forState:UIControlStateSelected];
    [chatBtn setTitle:@"" forState:UIControlStateNormal];
    [chatBtn setTitle:@"" forState:UIControlStateSelected];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hidesKeyboard" object:nil];
    
    SearchDetailViewController *sdvc = [[SearchDetailViewController alloc] init];
    sdvc.title = [noti.userInfo objectForKey:@"text"];
    sdvc.searchText = [noti.userInfo objectForKey:@"text"];
    sdvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sdvc animated:YES];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    chatBtn.alpha = 1.0f;
//}


- (void)viewWillDisappear:(BOOL)animated
{
    chatBtn.alpha = 0.0f;
}

- (void)setDataSource
{
    
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"Recommand_Daily"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //倒序
        self.datasArrayM = (NSMutableArray *)[[objects reverseObjectEnumerator] allObjects];
        if (HasLoadingAndNotDataView) {
            [self.datasArrayM removeAllObjects];
            [self.indicatorView stopAnimating];
            self.label.hidden = NO;
        }
        [self.tableView reloadData];
        [self.ynPageScrollViewController reloadPlaceHoderViewFrame];
    }];
    

}



- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    
    if (!HasLoadingAndNotDataView) return;
    
    //必须要在此上添加 站位图  最好用懒加载
    //添加菊花/无数据      在获取数据前后进行判断显示与隐藏
    if (self.isFirst) {self.isFirst = NO;return;}
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    indicatorView.center = self.ynPageScrollViewController.placeHoderView.center;
    indicatorView.backgroundColor = [UIColor purpleColor];
    indicatorView.hidden = NO;
    indicatorView.hidesWhenStopped = YES;
    [indicatorView startAnimating];
    [self.tableView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 30)];
    label.text = @"暂时还没有数据呢·";
    label.hidden = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.center = self.ynPageScrollViewController.placeHoderView.center;
    self.label = label;
    [self.tableView addSubview:label];
    
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

//footer-section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasArrayM.count;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT /4.0f;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = nil;
//    if (indexPath.row <= 6) {
        identifier = [NSString stringWithFormat:@"identifier-%d",(int)indexPath.row];
//    }
//    else{
//        identifier = @"identifier";
//    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        OneCellView *onecellview = [[OneCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/4.0f)];
        [cell addSubview:onecellview];
        
    
        
        NSString *kindstring = [[self.datasArrayM objectAtIndex:indexPath.row] objectForKey:@"type"];
        if ([kindstring isEqualToString:@"snack"]) {
            onecellview.kind = @"零食";
        }
        if ([kindstring isEqualToString:@"drink"]) {
            onecellview.kind = @"饮料&饮品";
        }
        if ([kindstring isEqualToString:@"meat"]) {
            onecellview.kind = @"肉制品";
        }
        if ([kindstring isEqualToString:@"fruit"]) {
            onecellview.kind = @"果干&坚果";
        }
        if ([kindstring isEqualToString:@"spicy"]) {
            onecellview.kind = @"辣食物";
        }
        if ([kindstring isEqualToString:@"sweet"]) {
            onecellview.kind = @"甜食";
        }
        if ([kindstring isEqualToString:@"fangbian"]) {
            onecellview.kind = @"方便食品";
        }
        onecellview.name = [[self.datasArrayM objectAtIndex:indexPath.row] objectForKey:@"title"];
        
        NSMutableString *html = [[self.datasArrayM objectAtIndex:indexPath.row] objectForKey:@"article"];
        onecellview.title = [WDCHtmlEditor stringOfH1:html];//@"健康美丽黑纱哟";
        onecellview.comment = [WDCHtmlEditor stringOfP:html];//@"传说有一个美丽的地方。他的名字个麻辣。个麻辣呀个麻辣。打很长看看会怎么样。……有点小饿啦。如月疑云，洗净的诞生。这么长应该够了吧。";
        onecellview.username = @"可爱的知食小编";
        onecellview.headerimage = [UIImage imageNamed:@"lunch"];
        
        
        AVFile *file = [[self.datasArrayM objectAtIndex:indexPath.row] objectForKey:@"image"];
        onecellview.articleimageurl = file.url;
        

    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    YNTestOneViewController *vc = [[YNTestOneViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    ArticleViewController *avc = [[ArticleViewController alloc] init];
    avc.urlString = [[self.datasArrayM objectAtIndex:indexPath.row] objectForKey:@"article"];
    [avc setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:avc animated:YES];
    
}

#pragma mark - lazy

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
    
};


- (NSMutableArray *)datasArrayM{
    
    if (!_datasArrayM) {
        _datasArrayM = @[].mutableCopy;
    }
    return _datasArrayM;
    
    
};

- (void)goToRigister:(UIButton *)sender
{
    InfomationViewController *ivc = [[InfomationViewController alloc] init];
    [ivc setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:ivc animated:YES];
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
