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

@interface RankDetailViewController()
{
    UITableView *_tableView;
}
@end

@implementation RankDetailViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
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
        }
        
    }
    return self;
}


-(void)btnclicked:(UIButton *)sender
{
    for (int i = 0; i< 5; i++) {
        UIButton *button = [self.view viewWithTag:40000000 + i];
        [button setTitleColor:FlatGray forState:UIControlStateNormal];
    }
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
