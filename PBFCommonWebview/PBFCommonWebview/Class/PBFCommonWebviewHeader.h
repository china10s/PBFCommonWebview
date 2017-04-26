//
//  PBFCommonWebviewHeader.h
//  PBFCommonWebview
//
//  Created by guest on 17/4/24.
//  Copyright © 2017年 PACFB. All rights reserved.
//

#ifndef PBFCommonWebviewHeader_h
#define PBFCommonWebviewHeader_h

#import "PBFCommonWebview.h"
#import "PBFCommonWebviewConfiguration.h"

//是否使用WKWebView
#ifndef WEB_VIEW_CONTROLLER_USING_WEBKIT
    #define WEB_VIEW_CONTROLLER_USING_WEBKIT \
        ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.9999)
#endif

#endif /* PBFCommonWebviewHeader_h */
