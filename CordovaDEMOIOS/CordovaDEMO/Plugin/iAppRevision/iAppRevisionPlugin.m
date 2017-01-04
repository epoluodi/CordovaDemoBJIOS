//
//  iAppRevisionPlugin.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/23.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "iAppRevisionPlugin.h"
#import "CDVViewController.h"
#import "iAppRevisionService.h"



@implementation iAppRevisionPlugin


+(void)iAppRevisionInit
{
    //授权
    [iAppRevision registerApp:@"SxD/phFsuhBWZSmMVtSjKZmm/c/3zSMrkV2Bbj5tznSkEVZmTwJv0wwMmH/+p6wLiUHbjadYueX9v51H9GgnjUhmNW1xPkB++KQqSv/VKLDsR8V6RvNmv0xyTLOrQoGzAT81iKFYb1SZ/Zera1cjGwQSq79AcI/N/6DgBIfpnlwiEiP2am/4w4+38lfUELaNFry8HbpbpTqV4sqXN1WpeJ7CHHwcDBnMVj8djMthFaapMFm/i6swvGEQ2JoygFU3CQHU1ScyOebPLnpsDlQDzLvKeTdxzwi2Wk0Yn+WSxoXx6aD2yiupr6ji7hzsE6/QqGcC+eseQV1yrWJ/1FwxLCjX+xEgRoNggvmgA8zkJXOVWEbHWAH22+t7LdPt+jENwSCMsAYnhGWJ0gXIIaLjG32poSbszHQQyNDZrHtqZuuSgCNRP4FpYjl8hG/IVrYXo/POmAlKHHVOdR0F5DQjr+W8fXpxdRHfEuWC1PB9ruQ="];
    [iAppRevision sharedInstance].debugMode = YES;
}

-(void)showSign:(CDVInvokedUrlCommand *)command
{
    NSLog(@"显示签名");
    CDVViewController *cdv = (CDVViewController *)self.viewController;
    [self.commandDelegate runInBackground:^{
        [cdv OnMessage:CDV_SHOWSIGNVIEW command:command];
    }];
}

-(void)loadSign:(CDVInvokedUrlCommand *)command
{
   __block CDVPluginResult* pluginResult = nil;
    __weak __typeof(self) weakself= self;
    __block  NSDictionary *result;
    [self.commandDelegate runInBackground:^{
        NSDictionary * arg = [command.arguments objectAtIndex:0];//获得参数信息
        NSDictionary *_jsondata = [NSJSONSerialization JSONObjectWithData:[((NSString *)arg) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        arg = _jsondata;
        
        [iAppRevisionPlugin iAppRevisionInit];
        [[iAppRevisionService service] loadSignatureWithWebService:[arg objectForKey:@"webService"] recordID:[arg objectForKey:@"recordID"] userName:[arg objectForKey:@"userName"] fieldName:[arg objectForKey:@"fieldName"] success:^(NSString *fieldValue) {
            
            NSArray *fieldValues = [[iAppRevisionService service]  fieldValuesWithValue:fieldValue  ];
            NSLog(@"fieldValues: %@", fieldValues);
            
            if (!fieldValues || fieldValues.count==0)
            {
                result = @{@"state":@"1",@"desc":@"获取签批数据失败"};
                pluginResult  =[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];//成功
                [ weakself.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                return ;
            }
            NSMutableArray *files=[[NSMutableArray alloc] init];
            
            for (int i=1; i<fieldValues.count; i++) {
                NSDictionary *_d =fieldValues[i];
                //读取图片文件
                NSString *imgbase64 = [_d objectForKey: [arg objectForKey:@"userName"]];
                NSData *imgdata =[[iAppRevisionService service] imageDataWithBase64String:imgbase64];
                
                NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString *cachePath = [cacPath objectAtIndex:0];
                
                NSString *uuid = [[NSUUID UUID] UUIDString];
                NSString *filepath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuid]];
              
                NSLog(@"保存地址 %@",filepath);
                [imgdata writeToFile:filepath atomically:YES];
                
                [files addObject:filepath];
                
            }
            
            
           //回调
            result = @{@"state":@"0",@"desc":@"",@"data":files};
            pluginResult  =[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];//成功
            [ weakself.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            
        }failure:^(NSError *error) {
            
            NSString *e = [NSString stringWithCString:[[error.userInfo objectForKey:NSLocalizedDescriptionKey] cStringUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)] encoding:NSUTF8StringEncoding];
            NSLog(@"error: %@", e);
            
            //回调
            result = @{@"state":@"1",@"desc":e.description};
            pluginResult  =[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];//成功
            [ weakself.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];

    }];
}


@end
