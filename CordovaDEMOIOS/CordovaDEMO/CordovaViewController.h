//
//  CordovaViewController.h
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/4.
//  Copyright © 2016年 杨晓光. All rights reserved.
//说明：该类作为 cordova webview  controller 的基础类。

#import "CDVViewController.h"
#import "CDVPlugin.h"
#import "SignView.h"

@interface CordovaViewController : CDVViewController<SignDelegate>

@property (copy,nonatomic)NSString *HomeUrl;

@end
