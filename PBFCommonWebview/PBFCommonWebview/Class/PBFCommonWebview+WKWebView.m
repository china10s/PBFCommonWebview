//
//  PBFCommonWebview+WKWebView.m
//  PBFCommonWebview
//
//  Created by guest on 17/4/25.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#import "PBFCommonWebview+WKWebView.h"

@interface PBFCommonWebview()
@property (nonatomic, strong) NSURLRequest* currentRequest;
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

@implementation PBFCommonWebview (WKWebView)
- (void)initWebView_WKWebView:(CGRect)frame configuration:(PBFCommonWebviewConfiguration *)configuration{
    if(!self.realWebView){
        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
        if (configuration) {
            config.allowsInlineMediaPlayback = configuration.allowsInlineMediaPlayback;
        }
        self.realWebView = [[WKWebView alloc] initWithFrame:frame configuration:config];
        [(WKWebView*)self.realWebView setNavigationDelegate:self];
        [(WKWebView*)self.realWebView setUIDelegate:self];
        NSLog(@"WKWebView init");
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    BOOL resultBOOL = [self inner_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    BOOL isLoadingDisableScheme = [self isLoadingWKWebViewDisableScheme:navigationAction.request.URL];
    if(resultBOOL && !isLoadingDisableScheme){
        self.currentRequest = navigationAction.request;
        if (navigationAction.targetFrame == nil){
            [webView loadRequest:navigationAction.request];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//
//}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [self inner_webViewDidStartLoad];
}

//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
//
//}

//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
//    [self callback_webViewDidFailLoadWithError];
//}

//- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
//
//}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self inner_webViewDidFinishLoad];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self inner_webViewDidFailLoadWithError:error];
}

//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//
//}

//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)){
//
//}

#pragma mark - WKUIDelegate
//弹出提示框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [self.parentCtrl presentViewController:alertController animated:YES completion:^{}];
}

//弹出确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self.parentCtrl presentViewController:alertController animated:YES completion:^{}];
}


#pragma mark - private method
// WKWebView 是否可以跳转
- (BOOL)isLoadingWKWebViewDisableScheme:(NSURL*)url
{
    NSString *scheme = [url scheme];
    UIApplication *app = [UIApplication sharedApplication];
    // 打电话
    if ([scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            return YES;
        }
    }
    // 打开appstore
    if ([url.absoluteString containsString:@"ituns.apple.com"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            return YES;
        }
    }
    return NO;
}



@end
