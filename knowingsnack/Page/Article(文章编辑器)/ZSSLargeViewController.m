//
//  ZSSLargeViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/23.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "ZSSLargeViewController.h"

@interface ZSSLargeViewController ()

@end

@implementation ZSSLargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"写长评";
    
    self.alwaysShowToolbar = YES;
    
    // HTML Content to set in the editor
    NSString *html = @"<h1>为您的长评设置一个响当当的标题吧~</h1>"
    "<p>请在这里输入 <strong>任何</strong>您想要输入的测评文字.</p>"
    "<p>下方可以修改颜色,增加图片或链接,注意排版,可以吸引跟多人阅读哦</p>"
    "<p><strong>一些可能发生的问题:</strong></p>"
    "<p><strong>由于技术水平限制,嵌入的图片无法在编辑时实时显示,只有一个假的图片框,您可以在预览中查看编辑效果</strong></p>"
    "<p><strong></strong></p>"
    "<p> <em>觉得不错~可以打赏一下~</em>. </p>"
    "<p>   </p>"
    "<p>   </p>"
    "<p>   </p>";
    
    // Set the HTML contents of the editor
    [self setHTML:html];
    
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
    self.navigationItem.rightBarButtonItem = rightbutton;
    
}
                                   
- (void)next{
    NSLog(@"%@",self.getHTML);
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
