//
//  iAppRevisionPlugin.h
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/23.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "CDVPlugin.h"
#import "iAppRevision.h"
#import "Plugin.h"

@interface iAppRevisionPlugin : CDVPlugin


+(void)iAppRevisionInit;//初始化SDK

-(void)showSign:(CDVInvokedUrlCommand *)command;//显示签名手写板

-(void)loadSign:(CDVInvokedUrlCommand *)command;

@end
