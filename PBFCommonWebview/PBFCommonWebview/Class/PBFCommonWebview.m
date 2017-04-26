//
//  PBFCommonWebview.m
//  PBFCommonWebview
//
//  Created by guest on 17/4/24.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#import "PBFCommonWebview.h"
#import "PBFCommonWebview+WKWebView.h"
#import "PBFCommonWebview+UIWebView.h"

@interface PBFCommonWebview()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSURLRequest* currentRequest;
@end

@implementation PBFCommonWebview
//初始化
- (instancetype)initWithFrame:(CGRect)frame andController:(UIViewController*)controller configuration:(PBFCommonWebviewConfiguration *)configuration{
    self = [super init];
    self.parentCtrl = controller;
    if (WEB_VIEW_CONTROLLER_USING_WEBKIT) {
        [self initWebView_WKWebView:frame configuration:configuration];
    }
    else{
        [self initWebView_UIWebView:frame configuration:configuration];
    }
    [controller.view addSubview:self.realWebView];
    return self;
}

#pragma mark - public method
//////公共函数
- (void)loadRequest:(NSURLRequest *)request{
    if ([self.realWebView respondsToSelector:@selector(loadRequest:)]) {
        [self.realWebView performSelector:@selector(loadRequest:) withObject:request];
        self.currentRequest = request;
    }
}

- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL{
    if ([self.realWebView respondsToSelector:@selector(loadHTMLString:baseURL:)]) {
        [self.realWebView performSelector:@selector(loadHTMLString:baseURL:) withObject:string withObject:baseURL];
    }
}

- (void)loadData:( NSData *  )data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL{
    if ([self.realWebView respondsToSelector:@selector(loadData:MIMEType:textEncodingName:baseURL:)]) {
        if(WEB_VIEW_CONTROLLER_USING_WEBKIT){
            [self.realWebView loadData:data MIMEType:MIMEType textEncodingName:textEncodingName baseURL:baseURL];
        }
        else{
            [self.realWebView loadData:data MIMEType:MIMEType characterEncodingName:textEncodingName baseURL:baseURL];
        }
    }
}

- (void)reload{
    if([self.realWebView respondsToSelector:@selector(reload)]){
        [self.realWebView performSelector:@selector(reload)];
    }
}

- (void)stopLoading{
    if([self.realWebView respondsToSelector:@selector(stopLoading)]){
        [self.realWebView performSelector:@selector(stopLoading)];
    }
}

- (void)goBack{
    if([self.realWebView respondsToSelector:@selector(goBack)]){
        [self.realWebView performSelector:@selector(goBack)];
    }
}

- (void)goForward{
    if([self.realWebView respondsToSelector:@selector(goForward)]){
        [self.realWebView performSelector:@selector(goForward)];
    }
}

- (BOOL)canGoBack{
    if([self.realWebView respondsToSelector:@selector(canGoBack)]){
        return [self.realWebView performSelector:@selector(canGoBack)];
    }
    return FALSE;
}

- (BOOL)canGoForward{
    if([self.realWebView respondsToSelector:@selector(canGoForward)]){
        return [self.realWebView performSelector:@selector(canGoForward)];
    }
    return FALSE;
}

- (BOOL)loading{
    if([self.realWebView respondsToSelector:@selector(isLoading)]){
        return [self.realWebView performSelector:@selector(isLoading)];
    }
    return FALSE;
}

- (void)stringByEvaluatingJavaScriptFromString:(NSString *)script completionHandler:(PBFCommonWebviewJSExecuteBlock)completionHandler{
    if(WEB_VIEW_CONTROLLER_USING_WEBKIT){
        if([self.realWebView respondsToSelector:@selector(evaluateJavaScript:completionHandler:)]){
            [self.realWebView evaluateJavaScript:script completionHandler:^(id _Nullable data, NSError * _Nullable error) {
                completionHandler(data,error);
            }];
        }
    }
    else{
        if([self.realWebView respondsToSelector:@selector(stringByEvaluatingJavaScriptFromString:)]){
            NSString *strScript = [self.realWebView stringByEvaluatingJavaScriptFromString:script];
            completionHandler(strScript,nil);
        }
    }
}

- (BOOL)scalesPageToFit{
    if(!WEB_VIEW_CONTROLLER_USING_WEBKIT){
        return [self.realWebView scalesPageToFit];
    }
    else{
        return FALSE;
    }
}

- (void)setScalesPageToFit:(BOOL)scalesPageToFit{
    if(!WEB_VIEW_CONTROLLER_USING_WEBKIT){
        [self.realWebView setScalesPageToFit:scalesPageToFit];
    }
}

- (BOOL)hidden{
    return [self.realWebView hidden];
}

- (void)setHidden:(BOOL)hidden{
    [self.realWebView setHidden:hidden];
}

- (UIScrollView*)scrollView{
    if ([self.realWebView respondsToSelector:@selector(scrollView)]) {
        return [self.realWebView scrollView];
    }
    else{
        return nil;
    }
}

- (NSURLRequest*)currentRequest
{
    if (WEB_VIEW_CONTROLLER_USING_WEBKIT) {
        return _currentRequest;
    }
    else {
        return [(UIWebView*)self.realWebView request];;
    }
}

#pragma mark - protect method
//是否可以加载网页
- (BOOL)inner_webViewShouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(NSInteger)navigationType{
    if([(NSObject*)self.delegateSelf respondsToSelector:@selector(callback_webView:shouldStartLoadWithRequest:navigationType:)]){
        return [self.delegateSelf callback_webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    else{
        return NO;
    }
}

//加载网页开始
- (void)inner_webViewDidStartLoad{
    if([(NSObject*)self.delegateSelf respondsToSelector:@selector(callback_webViewDidStartLoad:)]){
        return [self.delegateSelf callback_webViewDidStartLoad:self];
    }
}

//加载网页成功
- (void)inner_webViewDidFinishLoad{
    if([(NSObject*)self.delegateSelf respondsToSelector:@selector(callback_webViewDidFinishLoad:)]){
        return [self.delegateSelf callback_webViewDidFinishLoad:self];
    }
}

//加载网页失败
- (void)inner_webViewDidFailLoadWithError:(NSError*)error{
    if([(NSObject*)self.delegateSelf respondsToSelector:@selector(callback_webView:didFailLoadWithError:)]){
        return [self.delegateSelf callback_webView:self didFailLoadWithError:error];
    }
}

@end
