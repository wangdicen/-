//
//  SnackBaseViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/30.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "SnackBaseViewController.h"
#import "UIView+YNCategory.h"
#import "UIViewController+YNCategory.h"
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshAutoFooter.h"
#import "YNPageScrollViewController.h"
#import "RecommendView.h"
#import "OneRecommendView.h"
#import "FindNLikeView.h"
#import "HotRoNewView.h"
#import "RankView.h"
#import "GuassULikeView.h"

#import "Header.h"

//是否带刷新
#define HasHeaderRefresh 0
//是否有loading和无数据view
#define HasLoadingAndNotDataView 0

@interface SnackBaseViewController ()
{
    int guessULikeCount;
    
    FindNLikeView *_fnl;
}
@property (nonatomic, strong) NSMutableArray *datasArrayM;

@property (nonatomic, weak) UIActivityIndicatorView *indicatorView ;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, assign) BOOL isFirst;
@end

@implementation SnackBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    guessULikeCount = 0;
    
    [self.view addSubview:self.tableView];
    self.isFirst = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setDataSource];
    });
    
    __weak typeof (SnackBaseViewController *)weakself = self;
    
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

//            NSInteger count = weakself.datasArrayM.count;
            for (int i = 0; i < 10; i++) {
                [weakself.datasArrayM addObject:@"guesseyoulike"];
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
}


- (void)setDataSource
{
    
    if (self.viewcontrollerName == NameSnackViewController){
        [self.datasArrayM addObject:@"recommend"];
        [self.datasArrayM addObject:@"find&like"];
        [self.datasArrayM addObject:@"hot"];
//        [self.datasArrayM addObject:@"ads"];
        [self.datasArrayM addObject:@"new"];
        [self.datasArrayM addObject:@"rank"];
    }
    else if (self.viewcontrollerName == NameDrinkViewController)
    {
        [self.datasArrayM addObject:@"recommend"];
        [self.datasArrayM addObject:@"find&like"];
        [self.datasArrayM addObject:@"hot"];
//        [self.datasArrayM addObject:@"ads"];
        [self.datasArrayM addObject:@"new"];
        [self.datasArrayM addObject:@"rank"];
    }
    else if (self.viewcontrollerName == NameFangBianViewController)
    {
        [self.datasArrayM addObject:@"recommend"];
        [self.datasArrayM addObject:@"find&like"];
        [self.datasArrayM addObject:@"hot"];
//        [self.datasArrayM addObject:@"ads"];
        [self.datasArrayM addObject:@"new"];
        [self.datasArrayM addObject:@"rank"];
    }
    else if (self.viewcontrollerName == NameFruitViewController)
    {
//        [self.datasArrayM addObject:@"recommend"];
        [self.datasArrayM addObject:@"find&like"];
        [self.datasArrayM addObject:@"hot"];
//        [self.datasArrayM addObject:@"ads"];
        [self.datasArrayM addObject:@"new"];
        [self.datasArrayM addObject:@"rank"];
    }
    else if (self.viewcontrollerName == NameSweetViewController)
    {
//        [self.datasArrayM addObject:@"recommend"];
        [self.datasArrayM addObject:@"find&like"];
        [self.datasArrayM addObject:@"hot"];
//        [self.datasArrayM addObject:@"ads"];
        [self.datasArrayM addObject:@"new"];
        [self.datasArrayM addObject:@"rank"];
    }
    else if (self.viewcontrollerName == NameSpicyViewController)
    {
//        [self.datasArrayM addObject:@"recommend"];
        [self.datasArrayM addObject:@"find&like"];
        [self.datasArrayM addObject:@"hot"];
//        [self.datasArrayM addObject:@"ads"];
        [self.datasArrayM addObject:@"new"];
        [self.datasArrayM addObject:@"rank"];
    }
    else if (self.viewcontrollerName == NameMeatViewController)
    {
//        [self.datasArrayM addObject:@"recommend"];
        [self.datasArrayM addObject:@"find&like"];
        [self.datasArrayM addObject:@"hot"];
//        [self.datasArrayM addObject:@"ads"];
        [self.datasArrayM addObject:@"new"];
        [self.datasArrayM addObject:@"rank"];
    }
    for (int i = 0; i < 10; i++) {
        [self.datasArrayM addObject:@"guesseyoulike"];
    }
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
    return 10;
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
    
        if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"recommend"])
        {
            return SCREEN_HEIGHT * 5.0f/12.0f;
        }
        if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"find&like"])
        {
            return SCREEN_HEIGHT /8.5f;
        }
        if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"hot"] || [[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"new"])
        {
            return SCREEN_HEIGHT / 3.0f +10;
        }
        if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"rank"])
        {
            return SCREEN_HEIGHT /3.0f + 50 +30;
        }
        if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"guesseyoulike"])
        {
            return SCREEN_HEIGHT /4.0f;
        }
        
        return SCREEN_HEIGHT /4.0f;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"\n section-%d,row-%d \n",(int)indexPath.section,(int)indexPath.row);
    
    static NSString *identifier = nil;
//    if (indexPath.row <= 6) {
        identifier = [NSString stringWithFormat:@"identifier-%d",(int)indexPath.row];
//    }
//    else{
//        identifier = @"identifier";
//    }
    
    NSLog(@"indexpath=------%d",(int)indexPath.row);

//    if (indexPath.row >= self.datasArrayM.count) {
//        for (int i = 0; i < 10; i++) {
//            [self.datasArrayM addObject:@"guesseyoulike"];
//        }
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

            if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"recommend"])
            {
                RecommendView *rv = [[RecommendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT *5.0/12.0f)];
                [cell addSubview:rv];
                switch (self.viewcontrollerName) {
                    case NameSnackViewController:
                        rv.type = NameSnackViewController;
                        break;
                    case NameDrinkViewController:
                        rv.type = NameDrinkViewController;
                        break;
                    case NameMeatViewController:
                        rv.type = NameMeatViewController;
                        break;
                    case NameFruitViewController:
                        rv.type = NameFruitViewController;
                        break;
                    case NameSpicyViewController:
                        rv.type = NameSpicyViewController;
                        break;
                    case NameSweetViewController:
                        rv.type = NameSweetViewController;
                        break;
                    case NameFangBianViewController:
                        rv.type = NameFangBianViewController;
                        break;
                    default:
                        break;
                }
                        
                [rv fetchDataInBackground];
            }
            if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"find&like"])
            {
                _fnl = [[FindNLikeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT /8.5f)];
                [cell addSubview:_fnl];
                switch (self.viewcontrollerName) {
                    case NameSnackViewController:
                        _fnl.type = NameSnackViewController;
                        break;
                    case NameDrinkViewController:
                        _fnl.type = NameDrinkViewController;
                        break;
                    case NameMeatViewController:
                        _fnl.type = NameMeatViewController;
                        break;
                    case NameFruitViewController:
                        _fnl.type = NameFruitViewController;
                        break;
                    case NameSpicyViewController:
                        _fnl.type = NameSpicyViewController;
                        break;
                    case NameSweetViewController:
                        _fnl.type = NameSweetViewController;
                        break;
                    case NameFangBianViewController:
                        _fnl.type = NameFangBianViewController;
                        break;
                    default:
                        break;
                }
                        
            }
            if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"hot"] || [[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"new"])
            {
                HotRoNewView *hrn = [[HotRoNewView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT/3.0f)];
                [cell addSubview:hrn];
                
                switch (self.viewcontrollerName) {
                    case NameSnackViewController:
                        hrn.viewcontrollertype = NameSnackViewController;
                        break;
                    case NameDrinkViewController:
                        hrn.viewcontrollertype = NameDrinkViewController;
                        break;
                    case NameMeatViewController:
                        hrn.viewcontrollertype = NameMeatViewController;
                        break;
                    case NameFruitViewController:
                        hrn.viewcontrollertype = NameFruitViewController;
                        break;
                    case NameSpicyViewController:
                        hrn.viewcontrollertype = NameSpicyViewController;
                        break;
                    case NameSweetViewController:
                        hrn.viewcontrollertype = NameSweetViewController;
                        break;
                    case NameFangBianViewController:
                        hrn.viewcontrollertype = NameFangBianViewController;
                        break;
                    default:
                        break;
                }
                
                if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"hot"]){
                    hrn.type = Hot;
                }else{
                    hrn.type = New;
                }
                
                [hrn fetchDataInBackground];
            }
            if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"ads"])
            {
                UIImageView *adsimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ads_placeholder"]];
                [cell addSubview:adsimage];
                adsimage.frame = CGRectMake(20, 5, SCREEN_WEIGHT - 40,110 - 10);
            }
            if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"rank"])
            {
                RankView *rv = [[RankView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT /3.0f +50) viewControllerType:self.viewcontrollerName];
                [cell addSubview:rv];
                switch (self.viewcontrollerName) {
                    case NameSnackViewController:
                        rv.viewcontrollertype = NameSnackViewController;
                        break;
                    case NameDrinkViewController:
                        rv.viewcontrollertype = NameDrinkViewController;
                        break;
                    case NameMeatViewController:
                        rv.viewcontrollertype = NameMeatViewController;
                        break;
                    case NameFruitViewController:
                        rv.viewcontrollertype = NameFruitViewController;
                        break;
                    case NameSpicyViewController:
                        rv.viewcontrollertype = NameSpicyViewController;
                        break;
                    case NameSweetViewController:
                        rv.viewcontrollertype = NameSweetViewController;
                        break;
                    case NameFangBianViewController:
                        rv.viewcontrollertype = NameFangBianViewController;
                        break;
                    default:
                        break;
                }
                
            }
        if([[self.datasArrayM objectAtIndex:indexPath.row] isEqualToString:@"guesseyoulike"])
        {
            GuassULikeView *gulv = [[GuassULikeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT /4.0f)];
//            [gulv fetchDataInBackground:guessULikeCount];
            guessULikeCount ++;
            [cell addSubview:gulv];
            switch (self.viewcontrollerName) {
                case NameSnackViewController:
                    gulv.viewcontrollertype = NameSnackViewController;
                    [gulv fetchDataInBackground:guessULikeCount];
                    break;
                case NameDrinkViewController:
                    gulv.viewcontrollertype = NameDrinkViewController;
                    [gulv fetchDataInBackground:guessULikeCount];
                    break;
                case NameMeatViewController:
                    gulv.viewcontrollertype = NameMeatViewController;
                    [gulv fetchDataInBackground:guessULikeCount];
                    break;
                case NameFruitViewController:
                    gulv.viewcontrollertype = NameFruitViewController;
                    [gulv fetchDataInBackground:guessULikeCount];
                    break;
                case NameSpicyViewController:
                    gulv.viewcontrollertype = NameSpicyViewController;
                    [gulv fetchDataInBackground:guessULikeCount];
                    break;
                case NameSweetViewController:
                    gulv.viewcontrollertype = NameSweetViewController;
                    [gulv fetchDataInBackground:guessULikeCount];
                    break;
                case NameFangBianViewController:
                    gulv.viewcontrollertype = NameFangBianViewController;
                    [gulv fetchDataInBackground:guessULikeCount];
                    break;
                default:
                    break;     
            }
        }
    }

   
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    return cell;
    
}

//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    YNTestOneViewController *vc = [[YNTestOneViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_fnl refreshText];
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
