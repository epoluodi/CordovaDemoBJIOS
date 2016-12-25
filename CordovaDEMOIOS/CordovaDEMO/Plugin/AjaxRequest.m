//
//  AjaxRequest.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/12.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "AjaxRequest.h"
#import "HttpLib.h"//如果采用ASF 库 去掉该库

@implementation AjaxRequest

-(void)POST:(CDVInvokedUrlCommand *)command
{
    [self.commandDelegate runInBackground:^{
        NSDictionary * arg = [command.arguments objectAtIndex:0];
        NSString *_url =[arg objectForKey:@"url"];
        NSString *_params =[arg objectForKey:@"params"];
        
        HttpLib *httplib = [[HttpLib alloc] init];
        [httplib HttpPostRequest:_url JSON:_params complete:^(NSData *data) {
            CDVPluginResult* pluginResult = nil;
            
            if (data)//获得到数据
                pluginResult  =[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];//成功
            else
                pluginResult  =[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"请求失败"];//失败
            
            //回调给JS
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
        
 
    }];

}
@end
