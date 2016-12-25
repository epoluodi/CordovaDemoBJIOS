//
//  iAppRevision.h
//  iAppRevision
//
//  Created by A449 on 15/1/9.
//  Copyright (c) 2015年 com.kinggrid. All rights reserved.
//

/*
 * 更新于：2016-11-07
 */

#import <Foundation/Foundation.h>

@class KGAuthorization;

@interface iAppRevision : NSObject

/** 授权是否成功 */
@property (readonly, assign, nonatomic) BOOL isAuthorized;

/** 设置打印模式，默认：NO */
@property (assign, nonatomic, getter=isDebugMode) BOOL debugMode;

/** iAppRevision单例初始化 
 * @return : iAppRevision对象
 */
+ (instancetype)sharedInstance;

/** 注册App
 * @param key : 授权码
 */
+ (void)registerApp:(NSString *)key;

/** 获取授权信息 
 * @return : 授权信息词典
 */
- (NSDictionary *)authorizedInfo;

@end
