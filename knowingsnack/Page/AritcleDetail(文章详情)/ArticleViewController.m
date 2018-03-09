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
#import "SnackDetailViewController.h"

@interface ArticleViewController ()<UIScrollViewDelegate,WKScriptMessageHandler>
{
    
    WKWebView *_webview;
    CGFloat _maxLoadCount;
    CGFloat _loadingCount;
    
    UIView *_progress;
    YYAnimatedImageView *_progressView;
    
    LikeRoDislikeView *_likeOrDislikeView;
}

@property (strong, nonatomic) WKUserContentController *userContent;

@end

@implementation ArticleViewController

- (void)dealloc
{
    [self.userContent removeScriptMessageHandlerForName:@"ocMethod"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        self.userContent = [[WKUserContentController alloc] init];
        [self.userContent addScriptMessageHandler:self  name:@"ocMethod"];
        config.userContentController = self.userContent;
        
        _webview = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];;
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
        
        _likeOrDislikeView = [[LikeRoDislikeView alloc] initWithFrame:CGRectMake( 0, SCREEN_HEIGHT - 50.0f, SCREEN_WEIGHT, 50.f)];
        [self.view addSubview:_likeOrDislikeView];

    }
    return self;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _likeOrDislikeView.frame = CGRectMake( 0, SCREEN_HEIGHT, SCREEN_WEIGHT, 50.f);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        _likeOrDislikeView.frame = CGRectMake( 0, SCREEN_HEIGHT - 50, SCREEN_WEIGHT, 50.f);
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
    NSString *CSS= @"<style type=\"text/css\">img{width:80%;margin: 2% 10%;}p{font-size:40px;margin: 15px 35px;}p.center{text-align: center;}h1{font-size:80px;color:#333333;margin: 10px 30px;}div{width: 100%;}#circle{margin: 5px 30px;width: 80px;height: 80px;border-radius: 50%;}#author{position: relative;right: -90px;top: -90px;font-size: 1.9em;color: black;}#time{position: relative;right: -90px;top: -90px;font-size: 0.8m;color: gray;}#box{ width: 100%;height: 50%;}#yellowbtn{background-color: #FFC107;width: 28%;height: 10%;border-radius: 28px;position: relative;right:-38%;top: 40%;}#count{text-align: center;color: white;}</style>";
    NSString * htmlString = [NSString stringWithFormat:@"<html><meta charset=\"UTF-8\"><header>%@<script type=\"text/javascript\">function dismiss(){window.webkit.messageHandlers.ocMethod.postMessage(arguments[0]);}</script></header><body>%@<div id=\"box\"><div onclick=\"javascript:location.href='HTTPS://QR.ALIPAY.COM/FKX04179TH0G7WRABUIG25'\" id=\"yellowbtn\"><p id=\"count\">打赏</p></div></div></body></html>",CSS,urlString];
    
    // 获取当前应用的根目录
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    //body是服务器返回的html格式的文章代码
    [_webview loadHTMLString:htmlString baseURL:baseURL];
}


-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSString *messageName = message.name;
    if ([@"ocMethod" isEqualToString:messageName])
    {
        id messageBody = message.body;
        NSLog(@"%@",messageBody);
        //点击html按钮,让当前webView页面dismiss掉
    
        AVQuery *query = [AVQuery queryWithClassName:@"Snack"];
        [query whereKey:@"objectId" equalTo:messageBody];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            
            AVObject *object = objects[0];
            
            SnackDetailViewController *sdvc = [[SnackDetailViewController alloc] init];
            sdvc.title = object[@"name"];
            sdvc.name = object[@"name"];
            AVFile *file = object[@"image"];
            
            [file getThumbnail:YES width:400 height:400 withBlock:^(UIImage *image, NSError *error) {
                sdvc.image = image;
                sdvc.stars = [object[@"stars"] floatValue];
                sdvc.objectId = messageBody;
                sdvc.view.backgroundColor = FlatWhite;
                [self.navigationController pushViewController:sdvc animated:YES];
                
            }];
        }];
        
    }
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
