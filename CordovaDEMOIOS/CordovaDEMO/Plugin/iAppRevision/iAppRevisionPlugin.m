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
    [iAppRevision registerApp:@"SxD/phFsuhBWZSmMVtSjKZmm/c/3zSMrkV2Bbj5tznSkEVZmTwJv0wwMmH/+p6wLiUHbjadYueX9v51H9GgnjUhmNW1xPkB++KQqSv/VKLDsR8V6RvNmv0xyTLOrQoGzAT81iKFYb1SZ/Zera1cjGwQSq79AcI/N/6DgBIfpnlwiEiP2am/4w4+38lfUELaNFry8HbpbpTqV4sqXN1WpeJ7CHHwcDBnMVj8djMthFaapMFm/i6swvGEQ2JoygFU368sLBQG57FhM8Bkq7aPAVnSivRuSlEWh/3amWqlmf53x6aD2yiupr6ji7hzsE6/Q8+8WcsrGVLl3zOGriO8JAgfD/aknj9SAdcbqTXUmtPiVWEbHWAH22+t7LdPt+jEN7FwOixTutkXFqN7Z6YvH2Kcd2k72+1SjzDw0qWe3PQeSgCNRP4FpYjl8hG/IVrYXAg6SVLcb1PurpgdtpX/jJOW8fXpxdRHfEuWC1PB9ruQ="];
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
        NSString * arg = [command.arguments objectAtIndex:0];//获得参数信息
        NSDictionary *_jsondata = [NSJSONSerialization JSONObjectWithData:[((NSString *)arg) dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

        iAppRevisionService *_server = [iAppRevisionService service];
        [_server loadSignatureWithWebService:[_jsondata objectForKey:@"webService"] recordID:[_jsondata objectForKey:@"recordID"] userName:[_jsondata objectForKey:@"fieldName"] fieldName:[_jsondata objectForKey:@"userName"] success:^(NSString *fieldValue) {
            
            
            NSLog(@"查询到 %@",fieldValue);
            
        } failure:^(NSError *error) {
            
            
            NSString *err = error.description;
            NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSData *_errdata = [err dataUsingEncoding:encoding];
            
            NSLog(@"数据 %@",[[NSString alloc] initWithData:_errdata encoding:NSUTF8StringEncoding]);
        }];

    }];
}


@end
