//
//  ViewController.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/1.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "ViewController.h"
#import "CordovaViewController.h"
#import "HttpLib.h"
#import "SignView.h"
#import "iAppRevisionPlugin.h"
#import "iAppRevisionService.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //必须增加
    [iAppRevisionPlugin iAppRevisionInit];
    
    //必须增加初始化
    [iAppRevisionService service];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickweb1:(id)sender {
    
    CordovaViewController *cdv1 = [[CordovaViewController alloc] init];
//    NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"upload" ofType:@""];
//    NSString *homeurl = [NSString stringWithFormat:@"file://%@/%@", bundlepath ,@"webapp-infomation-edit.html"];
    
    NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"pms" ofType:@""];
    NSString *homeurl = [NSString stringWithFormat:@"file://%@/%@", bundlepath ,@"html/index.html"];
    
    cdv1.HomeUrl =@"http://220.194.33.92/defaultroot/clientview/dealfile/indexIos.html";
    [self presentViewController:cdv1 animated:YES completion:nil];
    
}

-(BOOL)shouldAutorotate
{
    return NO;
}




- (IBAction)clickweb2:(id)sender {

}

- (IBAction)clickdownload1:(id)sender {
    HttpLib *httplib = [[HttpLib alloc] init];
    [httplib HttpDownloadFile:@"http://www.ishangban.com/pms/IOS_WEB.zip" filename:@"ios_web.zip"];
    
}

- (IBAction)clickdownload2:(id)sender {
}
@end
