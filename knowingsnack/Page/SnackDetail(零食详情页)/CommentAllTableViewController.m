//
//  CommentAllTableViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/3/14.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "CommentAllTableViewController.h"
#import "CommonCommandView.h"
#import "Header.h"

@interface CommentAllTableViewController ()
{
    NSMutableArray *_datasource;
    NSMutableArray *_cellheightarray;
    
    BOOL isfrist;
}
@end

@implementation CommentAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datasource = [NSMutableArray new];
    _cellheightarray = [NSMutableArray new];
    isfrist = YES;
}

- (void)setObjectId:(NSString *)objectId
{
    _objectId = objectId;
    AVQuery *query = [AVQuery queryWithClassName:@"snack_staring"];
    AVObject *obj = [AVObject objectWithClassName:@"Snack" objectId:objectId];
    [query whereKey:@"snackpointer" equalTo:obj];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        _datasource = [NSMutableArray arrayWithArray:objects];
        
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonCommandView *command = [[CommonCommandView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WEIGHT - 10, 50)];
    AVUser *user = [_datasource[indexPath.row] objectForKey:@"userpointer"];
    AVQuery *query2 = [AVQuery queryWithClassName:@"_User"];
    [query2 whereKey:@"objectId" equalTo:user.objectId];
    NSArray *objects = [query2 findObjects];
    if (objects != nil) {
        command.text = [_datasource[indexPath.row] objectForKey:@"shortcomment"];
        return command.frame.size.height;
    }
    else{
        return 66;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"reuseIdentifier-%d",(int)indexPath.row]];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"reuseIdentifier-%d",(int)indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CommonCommandView *command = [[CommonCommandView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WEIGHT - 10, 50)];
        [cell.contentView addSubview:command];
        AVUser *user = [_datasource[indexPath.row] objectForKey:@"userpointer"];
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
                
                command.text = [_datasource[indexPath.row] objectForKey:@"shortcomment"];
                command.starNum =  [[_datasource[indexPath.row] objectForKey:@"starnum"] floatValue] *2.0f;
            }
            
        }];
        
    }
    
    return cell;
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
