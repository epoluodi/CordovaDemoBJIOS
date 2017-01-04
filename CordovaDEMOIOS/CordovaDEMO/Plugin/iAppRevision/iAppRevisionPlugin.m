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
#import "iAppRevisionPlugin.h"


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
    [self.commandDelegate runInBackground:^{
        NSDictionary * arg = [command.arguments objectAtIndex:0];//获得参数信息
//        NSDictionary *_jsondata = [NSJSONSerialization JSONObjectWithData:[((NSString *)arg) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

//        iAppRevisionService *_server = [iAppRevisionService service];
        [iAppRevisionPlugin iAppRevisionInit];
        [[iAppRevisionService service] loadSignatureWithWebService:@"http://oa.goldgrid.com:88/iWebRevisionEx/iWebServer.jsp" recordID:[arg objectForKey:@"recordID"] userName:@"admin" fieldName:@"SendOut" success:^(NSString *fieldValue) {
            
            NSArray *fieldValues = [[iAppRevisionService service]  fieldValuesWithValue:fieldValue  ];
            NSLog(@"fieldValues: %@", fieldValues);
            
        }failure:^(NSError *error) {
            
            NSString *e = [NSString stringWithCString:[[error.userInfo objectForKey:NSLocalizedDescriptionKey] cStringUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)] encoding:NSUTF8StringEncoding];
            NSLog(@"error: %@", e);
        }];
        
        
//        [_server loadSignatureWithWebService:[arg objectForKey:@"webService"] recordID:[arg objectForKey:@"recordID"] userName:[arg objectForKey:@"fieldName"] fieldName:[arg objectForKey:@"userName"] success:^(NSString *fieldValue) {
//            
//            
//            NSLog(@"查询到 %@",fieldValue);
//            
//        } failure:^(NSError *error) {
//            NSString *err = error.description;
//            NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//            NSData *_errdata = [err dataUsingEncoding:encoding];
//            
//            NSLog(@"数据 %@",[[NSString alloc] initWithData:_errdata encoding:NSUTF8StringEncoding]);
//        }];

    }];
}


@end
