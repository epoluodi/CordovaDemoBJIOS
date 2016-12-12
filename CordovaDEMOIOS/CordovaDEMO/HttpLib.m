//
//  HttpLib.m
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/12.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import "HttpLib.h"

@implementation HttpLib


-(void)HttpPostRequest:(NSString *)url JSON:(NSString *)json complete:(HttpPostHandle)completedelegate
{

    //1.创建会话对象
    session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *_url = [NSURL URLWithString:url];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
//    [request setValue:@"" forHTTPHeaderField:@""];//设置头信息
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    NSString *strjson = [NSString stringWithFormat:@"params=%@",json];
    request.HTTPBody = [strjson dataUsingEncoding:NSUTF8StringEncoding];
    datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //8.解析数据
        completedelegate(data);
        
    }];
    
    //7.执行任务
    [datatask resume];
    
}
@end
