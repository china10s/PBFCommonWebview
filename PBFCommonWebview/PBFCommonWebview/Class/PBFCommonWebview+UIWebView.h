//
//  PBFCommonWebview+UIWebView.h
//  PBFCommonWebview
//
//  Created by guest on 17/4/25.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#import "PBFCommonWebview.h"

@class PBFCommonWebviewConfiguration;

@interface PBFCommonWebview (UIWebView)<UIWebViewDelegate>
- (void)initWebView_UIWebView:(CGRect)frame configuration:(PBFCommonWebviewConfiguration *)configuration;
@end
