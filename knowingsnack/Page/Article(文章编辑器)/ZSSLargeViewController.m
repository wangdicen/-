//
//  ZSSLargeViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/23.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "ZSSLargeViewController.h"
#import "Header.h"

@interface ZSSLargeViewController ()

@end

@implementation ZSSLargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"写长评";
    
    self.alwaysShowToolbar = YES;
    
    // HTML Content to set in the editor
    NSString *html = @"<h1>输入标题</h1>"
    "<p>请在这里输入 <strong>任何</strong>您想要输入的测评文字.</p>"
    "<p><strong>一些可能发生的问题:</strong></p>"
    "<p><strong>由于技术水平限制,文章暂时无法插入图片,默认文字只能手动删除</strong></p>"
    "<p><strong></strong></p>"
    "<p> <em>我们会在今后的版本中完善,(您可以用文本附上您喜欢的图片的链接,管理员会在后台进行处理)</em>. </p>"
    "<p>   </p>"
    "<p>   </p>"
    "<p>   </p>";
    
    // Set the HTML contents of the editor
    [self setHTML:html];
    
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
    self.navigationItem.rightBarButtonItem = rightbutton;
    
}
                                   
- (void)next{
    NSLog(@"%@",self.getHTML);
    
    AVObject *object = [[AVObject alloc] initWithClassName:@"Article"];
    [object setObject:self.getHTML forKey:@"article"];
    [object setObject:[AVUser currentUser] forKey:@"user"];
    [object saveInBackground];
    
    [XHToast showTopWithText:@"上传完成,\n管理员会在后台进行处理"];
    [self.navigationController popViewControllerAnimated:YES];

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
