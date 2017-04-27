//
//  PBFCommonWebview+UIWebView.m
//  PBFCommonWebview
//
//  Created by guest on 17/4/25.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBFCommonWebview+UIWebView.h"

@interface PBFCommonWebview()
#pragma mark - private method
//////基类基础函数
//是否可以加载网页
- (BOOL)inner_webViewShouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(NSInteger)navigationType;
//加载网页开始
- (void)inner_webViewDidStartLoad;
//加载网页成功
- (void)inner_webViewDidFinishLoad;
//加载网页失败
- (void)inner_webViewDidFailLoadWithError:(NSError*)error;
@end

@implementation PBFCommonWebview (UIWebView)
- (void)initWebView_UIWebView:(CGRect)frame configuration:(PBFCommonWebviewConfiguration *)configuration{
    if(!self.realWebView){
        self.realWebView = [[UIWebView alloc] initWithFrame:frame];
        [(UIWebView*)self.realWebView setDelegate:self];
        NSLog(@"UIWebView init");
        if (configuration) {
            [self.realWebView setAllowsInlineMediaPlayback:configuration.allowsInlineMediaPlayback];
            [self.realWebView setKeyboardDisplayRequiresUserAction:configuration.keyboardDisplayRequiresUserAction];
        }
    }
}

//- (BOOL)canGoBack_UIWebview{
//    return [self.realWebView canGoBack];
//}
//
//- (BOOL)canGoForward_UIWebview{
//    
//}
//
//- (BOOL)isLoading_UIWebview{
//    
//}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    BOOL resultBOOL = [self inner_webViewShouldStartLoadWithRequest:request navigationType:navigationType];
    return resultBOOL;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self inner_webViewDidStartLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self inner_webViewDidFinishLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self inner_webViewDidFailLoadWithError:error];
}

@end
