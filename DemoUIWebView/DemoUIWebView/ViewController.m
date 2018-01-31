//
//  ViewController.m
//  DemoUIWebView
//
//  Created by Chris Hu on 30/01/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<
    UIWebViewDelegate
>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.webView];
    
//    [self loadGif];
//    [self loadHTML];
    [self loadURL:@"https://www.baidu.com"];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)loadHTML {
    [self.webView loadHTMLString:@"<html><body><p>this is baidu!</p></body></html>" baseURL: [NSURL URLWithString:@"https://www.baidu.com"]];
}

- (void)loadURL:(NSString *)urlString {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:urlRequest];
}

- (void)loadGif {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:[[NSURL alloc] init]];
    self.webView.userInteractionEnabled = NO;
}

// MARK: - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

@end
