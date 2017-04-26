//
//  PBFCommonWebview+WKWebView.h
//  PBFCommonWebview
//
//  Created by guest on 17/4/25.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#import "PBFCommonWebview.h"
#import <WebKit/WebKit.h>

@class PBFCommonWebviewConfiguration;

@interface PBFCommonWebview (WKWebView)<WKNavigationDelegate,WKUIDelegate>
- (void)initWebView_WKWebView:(CGRect)frame configuration:(PBFCommonWebviewConfiguration *)configuration;
@end
