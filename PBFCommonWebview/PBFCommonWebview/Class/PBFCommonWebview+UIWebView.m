//
//  PBFCommonWebview+UIWebView.m
//  PBFCommonWebview
//
//  Created by guest on 17/4/25.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBFCommonWebview+UIWebView.h"


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
