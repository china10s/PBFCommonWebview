//
//  ViewController.m
//  PBFCommonWebview
//
//  Created by guest on 17/4/24.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#import "ViewController.h"
#import "PBFCommonWebview.h"

@interface ViewController ()<PBFCommonWebviewDelgate>
@property (nonatomic,strong)PBFCommonWebview *webview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webview = [[PBFCommonWebview alloc] initWithFrame:CGRectMake(0, 80, 300, 400) andController:self configuration:nil];
    [self.webview setDelegateSelf:self];
    [self.view addSubview:self.webview.realWebView];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PBFCommonWebviewDelgate
//是否可以加载网页
- (BOOL)callback_webView:(PBFCommonWebview*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(NSInteger)navigationType{
    NSLog(@"callback_webViewShouldStartLoadWithRequest");
    return YES;
}

//加载网页开始
- (void)callback_webViewDidStartLoad:(PBFCommonWebview*)webView{
    NSLog(@"callback_webViewDidStartLoad");
}

//加载网页成功
- (void)callback_webViewDidFinishLoad:(PBFCommonWebview*)webView{
    NSLog(@"callback_webViewDidFinishLoad");
}

//加载网页失败
- (void)callback_webView:(PBFCommonWebview*)webView didFailLoadWithError:(NSError*)error{
    NSLog(@"callback_webViewDidFailLoadWithError:");
}


@end
