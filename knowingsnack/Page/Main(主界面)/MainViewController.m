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

@interface MainViewController ()
{
    UIButton *chatBtn;
    
    NSString *_html;
    
    WDCSearchView *_searchView;
    
    MainNavView *navbar;
    
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setDataSource];
    });
    
    __weak typeof (MainViewController *)weakself = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSInteger count = weakself.datasArrayM.count;
            for (int i = 0; i < 2; i++) {
                [weakself.datasArrayM insertObject:[NSString stringWithFormat:@" 刷新数据 %zd",count + i] atIndex:0];
            }
            NSLog(@"上啦加载完成");
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView reloadData];
            //调整占位图footer
            [weakself.ynPageScrollViewController reloadPlaceHoderViewFrame];
            [weakself.indicatorView stopAnimating];
            weakself.label.hidden = NO;
        });
    }];
    
    if (!HasHeaderRefresh) {
        self.tableView.mj_header = nil;
    }
    
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSInteger count = weakself.datasArrayM.count;
            for (int i = 0; i < 20; i++) {
                [weakself.datasArrayM addObject:[NSString stringWithFormat:@" 加载数据 %zd",count + i]];
            }
            NSLog(@"下拉加载完成");
            [weakself.tableView.mj_footer endRefreshing];
            
            [weakself.tableView reloadData];
            //调整占位图footer
            [weakself.ynPageScrollViewController reloadPlaceHoderViewFrame];
            
            [weakself.indicatorView stopAnimating];
            weakself.label.hidden = NO;
        });
    }];
    
    
    
    _html = @"<h1>为您的长评设置一个响当当的标题吧~</h1><p>请在这里输入 <strong>任何</strong>您想要输入的测评文字.</p><p>下方可以修改颜色,增加图片或链接</p><p>注意排版,可以吸引跟多人阅读哦</p><p><strong>一些可能发生的问题:</strong></p><p><strong>1.由于技术水平限制,目前长文评论只能加载一张图片</strong></p><p><strong>2.使用过程可能有些卡顿,我们会在之后的版本尽可能改进</strong></p><h1><em>觉得不错~可以打赏一下~</em>.</h1><div><br /></div><p><i>德国方法</i></p><p style=\"text-align: right;\"><i>如果多层次</i></p><p style=\"text-align: left;\"><i>嘘拜拜吧</i></p><p style=\"text-align: justify;\"><i>vhffgg</i></p><p style=\"text-align: justify;\"><i><br /></i></p><p style=\"text-align: center;\"><i>复合肥刚刚好</i></p><img src=\"wangdicen.png\" /><p style=\"text-align: center;\"><i><u>dgdfgggggb<sup>b</sup><font size=\"2\"><sup>fgv</sup></font></u><strike></strike></i></p><p style=\"text-align: center;\"><i><font size=\"2\"><sup><u>dgg</u><strike style=\"text-decoration: underline;\">gg ggvbb</strike></sup></font></i></p><p style=\"text-align: center;\"><i><font size=\"2\"><sup><strike>dffffgたなみや</strike></sup></font></i></p><p style=\"text-align: center;\"><i><font size=\"2\"><sub>仁万やな</sub>ょにまた</font></i></p><blockquote style=\"margin: 0px 0px 0px 40px;\"><p><i><font color=\"#b3cc50\">斜めなんです</font></i></p><p><i><font color=\"#b3cc50\" style=\"background-color: rgb(89, 21, 142);\">マナ棚よ</font></i></p></blockquote><p><i><br /></i></p><p><i><br /></i></p><p></p><p></p><p></p>";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeToCancel:) name:@"ChatBtn_changeToCancel" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToSearchDetail:) name:@"goToSearchDetail" object:nil];
    
    _searchView = [[WDCSearchView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WEIGHT, SCREEN_HEIGHT - 64)];
    _searchView.alpha = 0.0;
    [self.view addSubview:_searchView];
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
        [self.datasArrayM addObject:@"recommend"];
        [self.datasArrayM addObject:@"find&like"];
        [self.datasArrayM addObject:@"hot"];
        [self.datasArrayM addObject:@"ads"];
        [self.datasArrayM addObject:@"new"];
        [self.datasArrayM addObject:@"rank"];
    
    if (HasLoadingAndNotDataView) {
        [self.datasArrayM removeAllObjects];
        [self.indicatorView stopAnimating];
        self.label.hidden = NO;
    }
    [self.tableView reloadData];
    [self.ynPageScrollViewController reloadPlaceHoderViewFrame];
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
    if (indexPath.row <= 6) {
        identifier = [NSString stringWithFormat:@"identifier-%d",(int)indexPath.row];
    }
    else{
        identifier = @"identifier";
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        OneCellView *onecellview = [[OneCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/4.0f)];
        [cell addSubview:onecellview];
        
        
        onecellview.kind = @"饮料&饮品";
        onecellview.name = @"天喔蜂蜜柚子茶";
        onecellview.title = [WDCHtmlEditor stringOfH1:_html];//@"健康美丽黑纱哟";
        onecellview.comment = [WDCHtmlEditor stringOfP:_html];//@"传说有一个美丽的地方。他的名字个麻辣。个麻辣呀个麻辣。打很长看看会怎么样。……有点小饿啦。如月疑云，洗净的诞生。这么长应该够了吧。";
        onecellview.username = @"酷酷的腾";
        onecellview.headerimage = [UIImage imageNamed:@"header.png"];
        
        
        NSArray *imagename = [WDCHtmlEditor arrayOfImg:_html];
        if (imagename.count >=1) {
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:[imagename objectAtIndex:0]];
            UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            onecellview.articleimage = savedImage;
        }
        else
        {
            onecellview.articleimage = [UIImage imageNamed:@"lunch"];
        }
        
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    YNTestOneViewController *vc = [[YNTestOneViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    ArticleViewController *avc = [[ArticleViewController alloc] init];
    avc.urlString = _html;
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
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"IS_LOGIN"]) {
        RigisterViewController *rvc = [[RigisterViewController alloc] init];
        [self presentViewController:rvc animated:YES completion:^{

        }];
    }

//    Snack *snack = [Snack objectWithClassName:@"Snack" objectId:@"59f68a05756571004531192d"];
//    
//    [snack commentSnackWithShortComment:@"看起来还不错" image:[UIImage imageNamed:@"nullImage"] starnum:5];

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
