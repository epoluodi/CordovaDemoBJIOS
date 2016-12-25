//
//  WebViewRequest.h
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/5.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "CDVPlugin.h"
#import "Plugin.h"

@interface WebViewRequest : CDVPlugin


//新建窗口
-(void)newOpen:(CDVInvokedUrlCommand *)command;


@end
