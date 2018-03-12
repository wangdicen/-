//
//  AccountNSecurityTableViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/12.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "AccountNSecurityTableViewController.h"
#import "Header.h"

@interface AccountNSecurityTableViewController ()
{
    NSArray *_dataSource;
    UILabel *tipLabel2;
}
@end

@implementation AccountNSecurityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号与安全";
    
    _dataSource = [NSArray arrayWithObjects:@"重置密码",@"重发邮箱认证邮件", nil];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 30.f - 64, SCREEN_WEIGHT, 30.f)];
    tipLabel.backgroundColor = FlatPowderBlue;
    tipLabel.textColor = FlatBlack;
    tipLabel.text = @"请不要重复请求,节约资源.";
    tipLabel.font = [UIFont systemFontOfSize:12.f];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    AVUser *user = [AVUser currentUser];
    
    tipLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 60.f - 64.f, SCREEN_WEIGHT, 30.f)];
    tipLabel2.backgroundColor = FlatPowderBlue;
    tipLabel2.textColor = FlatBlack;
    tipLabel2.text = [NSString stringWithFormat:@"当前邮箱为:%@",user.email];
    tipLabel2.font = [UIFont systemFontOfSize:12.f];
    tipLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
        cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AVUser *user = [AVUser currentUser];
    //重制密码
    if (indexPath.row == 0) {
        if (user.email == nil) {
            [XHToast showTopWithText:@"邮箱不能为空"];
            return;
        }
        
        [AVUser requestPasswordResetForEmailInBackground:user.email block:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [XHToast showTopWithText:@"请求成功,请至邮箱查看"];
            }
            else
            {
                [XHToast showTopWithText:[error.userInfo objectForKey:@"error"]];
            }
        }];
    }
    //重发邮件
    else if(indexPath.row == 1)
    {
        if (user.email == nil) {
            [XHToast showTopWithText:@"邮箱不能为空"];
            return;
        }
        [AVUser requestEmailVerify:user.email withBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [XHToast showTopWithText:@"请求成功,请至邮箱查看"];
            }
            else
            {
                [XHToast showTopWithText:[error.userInfo objectForKey:@"error"]];
            }
        }];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
