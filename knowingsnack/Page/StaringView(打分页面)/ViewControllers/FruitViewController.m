//
//  FruitViewController.m
//  knowingsnack
//
//  Created by 汪迪岑 on 2017/10/30.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "FruitViewController.h"

@interface FruitViewController ()

@end

@implementation FruitViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewcontrollerName = NameFruitViewController;
    }
    return self;
}

- (void)viewDidLoad {
    
    self.viewcontrollerName = NameFruitViewController;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

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
