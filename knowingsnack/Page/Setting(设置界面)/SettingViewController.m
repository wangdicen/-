//
//  SettingViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/27.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "SettingViewController.h"
#import "Header.h"
#import "AboutViewController.h"
#import "NewFunctionsViewController.h"
#import "AccountNSecurityTableViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSArray *_array;
    UILabel *_lbl;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WEIGHT, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _array = [NSArray arrayWithObjects:@"账号与安全",@"清理缓存",@"给应用评分",@"新功能介绍",@"关于",@"退出登陆",nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 3) {
            cell.textLabel.text =[_array objectAtIndex:indexPath.section + indexPath.row + 2];
        }
        else
        {
            cell.textLabel.text =[_array objectAtIndex:indexPath.section + indexPath.row];
        }
        
        if ([cell.textLabel.text isEqualToString:@"退出登陆"]) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if ([cell.textLabel.text isEqualToString:@"清理缓存"]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            _lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
            _lbl.text = [self getCacheSize];
            [cell.contentView addSubview:_lbl];
            _lbl.backgroundColor = ClearColor;
            _lbl.center = CGPointMake(SCREEN_WEIGHT - 15, 22);
            _lbl.font = [UIFont fontWithName:@"Arial" size:14.f];
            _lbl.textColor = FlatGray;
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //账号与安全
    if (indexPath.section == 0) {
        [self setHidesBottomBarWhenPushed:YES];
        AccountNSecurityTableViewController *anstvc = [[AccountNSecurityTableViewController alloc] init];
        [self.navigationController pushViewController:anstvc animated:YES];
    }
    //清理缓存
    if (indexPath.section == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定清除缓存的数据和图片?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }
    if (indexPath.section == 2) {
        //给应用评分
        if (indexPath.row == 0) {
            
        }
        //新功能介绍
        else if(indexPath.row == 1){
            [self setHidesBottomBarWhenPushed:YES];
            NewFunctionsViewController *nfvc = [[NewFunctionsViewController alloc] init];
            [self.navigationController pushViewController:nfvc animated:YES];
        }
        //关于
        else if(indexPath.row == 2){
            [self setHidesBottomBarWhenPushed:YES];
            AboutViewController *avc = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:avc animated:YES];
        }
    }
    //退出登陆
    if (indexPath.section == 3) {
        if ([AVUser currentUser] == nil) {
            [XHToast showTopWithText:@"您还没登陆呢!"];
        }
        else
        {
            [AVUser logOut];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLoginView" object:nil];
            [XHToast showTopWithText:@"退登成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
       
       
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self cleanCache];
        _lbl.text = [self getCacheSize];
    }
}

- (void)cleanCache

{
    //清理缓存
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *paths = nil;
    
    paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSMutableString *cachepath = [paths objectAtIndex:0];
    
    NSError *error = nil;
    
    NSArray *fileList = [manager contentsOfDirectoryAtPath:cachepath error:&error];
    
    for (NSString *file in fileList) {
        
        NSString *path = [cachepath stringByAppendingPathComponent:file];
        
        if ([manager isDeletableFileAtPath:path]) {
            
            [manager removeItemAtPath:path error:nil];
            
        }
        
    }
    
    
    
}

- (NSString *)getCacheSize{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    NSArray *paths = nil;
    
    paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSMutableString *cachepath = [paths objectAtIndex:0];
    
    
    
    NSError *error = nil;
    
    //文件夹下所有的目录和文件大小
    
    float cacheSize = 0.0f;
    
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:cachepath error:&error];
    
    BOOL isDir = NO;
    
    
    
    //在上面那段程序中获得的fileList中列出文件夹名
    
    for (NSString *file in fileList) {
        
        NSString *path = [cachepath stringByAppendingPathComponent:file];
        
        [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
        
        //获取文件属性
        
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];//[[NSFileManager defaultManager] fileAttributesAtPath: path traverseLink: YES];
        
        //获取文件的创建日期
        
        NSDate *modificationDate = (NSDate*)[fileAttributes objectForKey: NSFileModificationDate];
        
        
        
        int timeSepearte = (int)[[NSDate date] timeIntervalSince1970]-(int)[modificationDate timeIntervalSince1970];
        
        if (timeSepearte>(3*86400)) {
            
            if ([fileManager isDeletableFileAtPath:path]) {
                
                [fileManager removeItemAtPath:path error:nil];
                
            }
            
        }else{
            
            if (isDir) {
                
                cacheSize = cacheSize + [self fileSizeForDir:path];
                
            }
            
        }
        
        isDir = NO;
        
    }
    
    NSString *cacheSizeString = @"";
    
    if (cacheSize >1024*1024) {
        
        float cacheSize_M = cacheSize/(1024*1024);
        
        cacheSizeString = [NSString stringWithFormat:@"%.1f M",cacheSize_M];
        
    }else if (cacheSize>1024&&cacheSize<1024*1024) {
        
        float cacheSize_KB = cacheSize/(1024);
        
        cacheSizeString = [NSString stringWithFormat:@"%.1f KB",cacheSize_KB];
        
    }else{
        
        float cacheSize_BYT = cacheSize/(1024);
        
        cacheSizeString = [NSString stringWithFormat:@"%.1f B",cacheSize_BYT];
        
    }
    
    
    
    return cacheSizeString;
    
}

-(float)fileSizeForDir:(NSString*)path//计算文件夹下文件的总大小

{
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    float size =0;
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    for(int i = 0; i<[array count]; i++)
        
    {
        
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        
        
        BOOL isDir;
        
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
            
        {
            
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            
            size+= fileAttributeDic.fileSize;
            
        }
        
        else
            
        {
            
            [self fileSizeForDir:fullPath];
            
        }
        
    }
    
    return size;
    
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
