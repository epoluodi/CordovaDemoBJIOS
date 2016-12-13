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

//文件下载
-(void)HttpDownloadFile:(NSString *)fileurl filename:(NSString *)filename
{
    //1.创建会话对象
    session = [NSURLSession sharedSession];
    NSURL *_url = [NSURL URLWithString:fileurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
    
    // 4.创建任务
    downloadtask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            // location:下载任务完成之后,文件存储的位置，这个路径默认是在tmp文件夹下!
            // 只会临时保存，因此需要将其另存
            NSLog(@"location:%@",location.path);
            
            
            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            filePath =[filePath stringByAppendingPathComponent:filename];
            NSLog(@"要保存的位置:%@",filePath);
            NSError *fileError;
           if ( [[NSFileManager defaultManager] fileExistsAtPath:filePath])
           {
               [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
           }
            [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:filePath error:&fileError];
            if (fileError == nil) {
                NSLog(@"file save success");
            } else {
                NSLog(@"file save error: %@",fileError);
            }
        } else {
            NSLog(@"download error:%@",error);
        }
    }];
    
    // 5.开启任务
    [downloadtask resume];
    
    
}
@end
