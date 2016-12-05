//
//  WebViewRequest.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/5.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "WebViewRequest.h"
#import "CDVViewController.h"

@implementation WebViewRequest


-(void)NEWOPENWINDOWS:(CDVInvokedUrlCommand *)command
{
    CDVViewController *cdv = (CDVViewController *)self.viewController;
    [self.commandDelegate runInBackground:^{
        [cdv OnMessage:CDV_NEWOPENWINDOWS command:command];
    }];
}
@end
