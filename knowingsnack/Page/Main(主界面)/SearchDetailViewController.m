//
//  SearchDetailViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/2/28.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "Header.h"
#import "MyCollectionViewCell.h"

@interface SearchDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectview;
    NSMutableArray *_datasource;
}
@end

@implementation SearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.itemSize =CGSizeMake(SCREEN_WEIGHT / 2 - 15, (SCREEN_WEIGHT / 2 - 15) * 1.19);
    
    
    _collectview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WEIGHT, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    _collectview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectview];
    
//    for (int i = 0 ; i<250; i++) {
//        [_collectview registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
//    }
    
    
    _collectview.delegate = self;
    _collectview.dataSource = self;
    
    _datasource = [NSMutableArray new];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datasource.count;
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    AVQuery *query = [AVQuery queryWithClassName:@"Snack"];
    [query whereKey:@"name" containsString:searchText];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [_datasource addObjectsFromArray:objects];
        [_collectview reloadData];
    }];
    
}

- (void)setLikesArray:(NSArray *)likesArray
{
    _likesArray = likesArray;
    
    AVQuery *query = [AVQuery queryWithClassName:@"Snack"];
    [query whereKey:@"objectId" containedIn:likesArray];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [_datasource addObjectsFromArray:objects];
        [_collectview reloadData];
    }];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_collectview registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"cell-%d",(int)indexPath.row]];
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"cell-%d",(int)indexPath.row] forIndexPath:indexPath];
    NSDictionary *object = [_datasource objectAtIndex:indexPath.row];
    AVFile *file = object[@"image"];
    [file getThumbnail:YES width:300 height:357 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
                cell.topImage.image = image;
                cell.botlabel.text = object[@"name"];
                cell.starview.scorePercent = [object[@"stars"] floatValue] / 5.0f;
                cell.starNum.text= [NSString stringWithFormat:@"%.1f",[object[@"stars"] floatValue] *2.0f];
                cell.objectID = object[@"objectId"];
    }];

    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed=YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed=YES;
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
