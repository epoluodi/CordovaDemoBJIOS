//
//  CordovaViewController.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/4.
//  Copyright © 2016年 杨晓光. All rights reserved.
//说明：该类作为 cordova webview  controller 的基础类。

#import "CordovaViewController.h"

@interface CordovaViewController ()

@end

@implementation CordovaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.taobao.com" ]]];
}


//重载基类中的插件处理方法。
-(void)OnMessage:(NSString *)Action command:(CDVInvokedUrlCommand *)command
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
