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
#import "LikeRoDislikeView.h"

@interface ArticleViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    
    WKWebView *_webview;
    CGFloat _maxLoadCount;
    CGFloat _loadingCount;
    
    UIView *_progress;
    YYAnimatedImageView *_progressView;
    
    LikeRoDislikeView *_likeOrDislikeView;
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
        _webview.scrollView.delegate = self;
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
        
        _likeOrDislikeView = [[LikeRoDislikeView alloc] initWithFrame:CGRectMake( 0, SCREEN_HEIGHT - 40.0f, SCREEN_WEIGHT, 40.f)];
        [self.view addSubview:_likeOrDislikeView];
    }
    return self;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _likeOrDislikeView.frame = CGRectMake( 0, SCREEN_HEIGHT, SCREEN_WEIGHT, 40.f);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        _likeOrDislikeView.frame = CGRectMake( 0, SCREEN_HEIGHT - 40, SCREEN_WEIGHT, 40.f);
    }];
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
    [self performSelector:@selector(delay:) withObject:urlString afterDelay:1];
    
}

- (void)delay:(NSString *)urlString{
    NSString *CSS= @"<style type=\"text/css\">img{ width:100%;}h1{font-size:100px;color:#333333;}p{font-size:30px;color:#333333;}</style>";
    NSString * htmlString = [NSString stringWithFormat:@"<html><meta charset=\"UTF-8\"><header>%@</header><body>%@</body></html>",CSS,urlString];
    
    // 获取当前应用的根目录
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    //body是服务器返回的html格式的文章代码
    [_webview loadHTMLString:htmlString baseURL:baseURL];
}

- (void)webviewReload{
    [_webview reload];
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
