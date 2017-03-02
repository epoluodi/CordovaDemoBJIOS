//
//  SignView.h
//  CordovaDEMO
//
//  Created by 杨晓光 on 2016/12/23.
//  Copyright © 2016年 杨晓光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAppRevisionView.h"

@protocol SignDelegate

//签名完成，
//signUUID 返回签名的文件的uuid
// 返回回调js 的id
-(void)signFinish:(NSString *)signUUID callbackID:(NSString *)callbackid;

//失败回调
-(void)uploadError:(NSString *)errdesc callbackID:(NSString *)callbackid;

//回调显示签批图片
-(void)CallBackPreView:(NSString *)json callbackID:(NSString *)callbackid;

//回传手写签批数据
-(void)CallBackWithPointData:(NSString *)pointdata;
@end
@interface SignView : UIView
{
    //手写板
    KGHandwritingView *handwritingView;
    KGTextView *textsignView;
    //模糊效果
    UIVisualEffectView *effectview;
    UIBlurEffect *blur;
    
    UIViewController<SignDelegate> *_viewcontroller;//当前窗口
    
    UIButton *btnUndo; //撤销
    UIButton *btnRedo; //恢复
    UIButton *btnClean; //清除
    UIButton *btnCancel; //取消
    UIButton *btnSave;  // 保存
    
    NSString *_callbackID;
    NSString *fileuuid;//签名图片uuid
    
    NSString *word,*pointData;
}

@property (copy,nonatomic)NSDictionary *serverData;//初始化数据
//初始化 传入加载窗口的viewcontroller 目前针对webviewcontroller
-(instancetype)init:(UIViewController<SignDelegate> *)viewcontroller;

//显示签名 传入回调js 的id
-(void)show:(NSString *)callbackid;
-(void)uploadData :(NSString *)callbackid;
-(void)writePointDataToText:(NSData *)pointdata;
@end
