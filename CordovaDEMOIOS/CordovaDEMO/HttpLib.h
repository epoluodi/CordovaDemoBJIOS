//
//  HttpLib.h
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/12.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^HttpPostHandle)(NSData * data);


@interface HttpLib : NSObject<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
{
    NSURLSession *session;//http 请求回话
    NSURLSessionDataTask *datatask;//数据传输回话
    NSURLSessionDownloadTask *downloadtask;//下载回话
}


//post 请求
//url 请求地址
// json 参数信息
//返回 请求得到的数据 通过nsdata 返回
-(void)HttpPostRequest:(NSString *)url JSON:(NSString *)json complete:(HttpPostHandle)completedelegate;

@end
