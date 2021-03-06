//
//  PBFCommonWebview.h
//  PBFCommonWebview
//
//  Created by guest on 17/4/24.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBFCommonWebviewHeader.h"

@class PBFCommonWebviewConfiguration,PBFCommonWebview;

NS_ASSUME_NONNULL_BEGIN

@protocol PBFCommonWebviewDelgate
//是否可以加载网页
- (BOOL)callback_webView:(PBFCommonWebview*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(NSInteger)navigationType;
//加载网页开始
- (void)callback_webViewDidStartLoad:(PBFCommonWebview*)webView ;
//加载网页成功
- (void)callback_webViewDidFinishLoad:(PBFCommonWebview*)webView;
//加载网页失败
- (void)callback_webView:(PBFCommonWebview*)webView didFailLoadWithError:(NSError*)error;
@end

@interface PBFCommonWebview : NSObject
//初始化
- (instancetype)initWithFrame:(CGRect)frame andController:(nullable UIViewController*)controller configuration:(nullable PBFCommonWebviewConfiguration *)configuration;

@property (nonatomic,strong)id realWebView;
@property (nonatomic,weak)UIViewController *parentCtrl;
@property (nonatomic,weak)id<PBFCommonWebviewDelgate> delegateSelf;
//@property (nonatomic,copy,readonly) NSString *webTitle;

#pragma mark - public method
//////公共函数
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)loadData:( NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(nullable NSURL *)baseURL;

- (void)reload;
- (void)stopLoading;

- (void)goBack;
- (void)goForward;

@property (nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property (nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly,copy) NSURLRequest* currentRequest;
@property (nonatomic, readonly,copy) NSString* webTitle;


- (void)stringByEvaluatingJavaScriptFromString:(NSString *)script completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

@property (nonatomic) BOOL hidden;
@property (nonatomic) BOOL scalesPageToFit;

@property (nonatomic, readonly, strong) UIScrollView *scrollView;

NS_ASSUME_NONNULL_END
@end
