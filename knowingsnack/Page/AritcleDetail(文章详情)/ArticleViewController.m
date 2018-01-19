//
//  ArticleViewController.m
//  knowingsnack
//
//  Created by travelsky on 2018/1/19.
//  Copyright © 2018年 汪迪岑. All rights reserved.
//

#import "ArticleViewController.h"
#import "Header.h"

#import "UIImageView+YYWebImage.h"
#import "YYAnimatedImageView.h"
#import <WebKit/WebKit.h>
@interface ArticleViewController ()<UIWebViewDelegate>
{
    
    WKWebView *_webview;
    CGFloat _maxLoadCount;
    CGFloat _loadingCount;
    
    UIView *_progress;
    YYAnimatedImageView *_progressView;
}
@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


-(instancetype)init
{
    self = [super init];
    if (self) {
        _webview = [WKWebView new];
        _webview.frame = self.view.frame;
        [self.view addSubview:_webview];
        
        _progress = [UIView new];
        _progress.frame = CGRectMake(0, 64, SCREEN_WEIGHT, SCREEN_HEIGHT);
        [self.view addSubview:_progress];
        _progress.backgroundColor = rgba(255, 255, 255, 0.2);
        
        
        _progressView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(SCREEN_WEIGHT/2.0 - 125.0, SCREEN_HEIGHT/2.0 - 75.0f, 250/1.20f, 150/1.2f)];
         NSURL *path = [[NSBundle mainBundle] URLForResource:@"timg" withExtension:@"gif"];
        _progressView.yy_imageURL = path;
        [_progress addSubview:_progressView];
        
        [_webview addObserver:self
                       forKeyPath:@"loading"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
    if ([keyPath isEqualToString:@"loading"]) {
        _progress.hidden = NO;
    }
    
    if (!_webview.loading) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             _progress.hidden = YES;
                         } completion:nil];
    }
}

-(void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
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
