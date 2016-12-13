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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
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
    
    cdv1.HomeUrl =homeurl;
    [self presentViewController:cdv1 animated:YES completion:nil];
    
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
