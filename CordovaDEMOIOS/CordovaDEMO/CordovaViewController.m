//
//  CordovaViewController.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/4.
//  Copyright © 2016年 杨晓光. All rights reserved.
//说明：该类作为 cordova webview  controller 的基础类。

#import "CordovaViewController.h"
#import "Plugin.h"
@interface CordovaViewController ()

@end

@implementation CordovaViewController
@synthesize HomeUrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HomeUrl]]];
    
    //临时代码，集成后删除
    UIButton *btnreturn = [[UIButton alloc] init];
    btnreturn.frame = CGRectMake( [ UIScreen mainScreen ].bounds.size.width-90,  [ UIScreen mainScreen ].bounds.size.height -90, 80, 80);
    btnreturn.layer.cornerRadius=40;
    btnreturn.layer.masksToBounds=YES;
    [btnreturn setTitle:@"返回" forState:UIControlStateNormal];
    [btnreturn setBackgroundColor:[UIColor orangeColor]];
    [btnreturn addTarget:self action:@selector(ClickReturn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnreturn];
    
}


//关闭当前viewcontroll
-(void)ClickReturn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//重载基类中的插件处理方法。
-(void)OnMessage:(NSString *)Action command:(CDVInvokedUrlCommand *)command
{
    NSLog(@"插件指令 %@",Action);
    
    NSDictionary *arg;
    if ([Action isEqualToString:CDV_NEWOPENWINDOWS])
    {
        arg = [command.arguments objectAtIndex:0];//获得参数信息

        //TODO 由于插件回调是在线程中执行，对所有 UI线程操作需要回到  ui线程
        dispatch_async(dispatch_get_main_queue(), ^{
            CordovaViewController *cdv1 = [[CordovaViewController alloc] init];
            NSString *bundlepath = [[NSBundle mainBundle] bundlePath];
            NSString *homeurl = [NSString stringWithFormat:@"file://%@/%@", bundlepath ,[arg objectForKey:@"url"]];
            cdv1.HomeUrl =homeurl;
            [self presentViewController:cdv1 animated:YES completion:nil];
        });
        

    }
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
