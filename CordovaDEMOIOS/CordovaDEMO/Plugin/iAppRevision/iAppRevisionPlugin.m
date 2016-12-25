//
//  iAppRevisionPlugin.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/23.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "iAppRevisionPlugin.h"
#import "CDVViewController.h"


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


@end
