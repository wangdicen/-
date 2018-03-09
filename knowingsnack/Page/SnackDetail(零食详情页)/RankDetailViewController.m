//
//  RankDetailViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/2/27.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "RankDetailViewController.h"
#import "RankButton.h"
#import "Header.h"
#import "GuassULikeView.h"

@interface RankDetailViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    int _selectedBtnId;
    
    UILabel *_tipLabel;
}
@end

@implementation RankDetailViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        _selectedBtnId = 0;
        
        NSArray *array = [[NSArray alloc] initWithObjects:@"Top1-50",@"51-100",@"101-150",@"151-200",@"201-250", nil];
        for (int i = 0; i < 5; i++) {
            RankButton *btn = [[RankButton alloc] init];
            CGFloat width = btn.frame.size.width;
            btn.center = CGPointMake(5 + width/2.0 + width * i + 5*i, 64+btn.frame.size.height/2.0f + 5);
            [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            btn.tag = 40000000 + i;
            [btn addTarget:self action:@selector(btnclicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:FlatGray forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.f];
            [self.view addSubview:btn];
            
            if (i == 0) {
                [btn setTitleColor:FlatBlack forState:UIControlStateNormal];
            }
            
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y + btn.frame.size.height + 5, SCREEN_WEIGHT, SCREEN_HEIGHT - 66 - btn.frame.size.height - 10) style:UITableViewStylePlain];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _tableView.allowsSelection = NO;

            [self.view addSubview:_tableView];
            
            _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 30.f, SCREEN_WEIGHT, 30.f)];
            _tipLabel.backgroundColor = FlatPowderBlue;
            _tipLabel.textColor = FlatBlack;
            _tipLabel.text = @"首次外测,评分人数过少,排名暂无参考价值!";
            _tipLabel.font = [UIFont systemFontOfSize:12.f];
            _tipLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:_tipLabel];
        }
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT /4.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"dequeue-%d",(int)indexPath.row+ 50 * _selectedBtnId]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"dequeue-%d",(int)indexPath.row+ 50 * _selectedBtnId]];
        GuassULikeView *gulv = [[GuassULikeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT /4.0f)];
        gulv.viewcontrollertype = self.viewcontrollerName;
        [gulv addRankNum:(int)indexPath.row + 50 * _selectedBtnId + 1];
        [gulv fetchDataInBackground:(int)indexPath.row +  50 * _selectedBtnId];
        [cell addSubview:gulv];

    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        _tipLabel.alpha = 0.0f;
    }];
}
-(void)btnclicked:(UIButton *)sender
{
    for (int i = 0; i< 5; i++) {
        UIButton *button = [self.view viewWithTag:40000000 + i];
        [button setTitleColor:FlatGray forState:UIControlStateNormal];
    }
    _selectedBtnId = (int)sender.tag - 40000000;
    [_tableView reloadData];
    [sender setTitleColor:FlatBlack forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
