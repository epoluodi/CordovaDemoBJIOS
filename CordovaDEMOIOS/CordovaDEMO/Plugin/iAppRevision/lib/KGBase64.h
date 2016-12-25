//
//  KGBase64.h
//  iAppRevision
//
//  Created by A449 on 15/12/16.
//  Copyright © 2015年 com.kinggrid. All rights reserved.
//

/*
 * 更新于：2016-11-08
 */

#import <Foundation/Foundation.h>

/** base64编码
 * @param cuc_data_ptr : 要编码的数据
 * @param ul_data_length : 要编码数据的长度
 * @param ul_base64_data_length_ptr : 编码后返回的base64数据长度指针
 * @return : 编码后的base64数据
 */
unsigned char *KGBase64Encode(const unsigned char *cuc_data_ptr, unsigned long ul_data_length, unsigned long *ul_base64_data_length_ptr);

/** base64解码
 * @param cuc_base64_data_ptr : 要解码的base64数据
 * @param ul_base64_data_length : 要解码的base64数据的长度
 * @param ul_data_length_ptr : 解码后返回的数据长度
 * @return : 解码后的数据
 */
unsigned char *KGBase64Decode(const unsigned char *cuc_base64_data_ptr,unsigned long ul_base64_data_length, unsigned long *ul_data_length_ptr);

@interface KGBase64 : NSObject

/** 编码格式
 * @note 默认为kCFStringEncodingGB_18030_2000（服务器使用的编码格式，其他格式解析不了服务器的数据）
 */
@property (assign, nonatomic) NSStringEncoding stringEncoding;

/** base64自定义键，长度为65 */
@property (nonatomic, copy) NSString *base64Key;

/** KGBase64单例模式初始化
 * @return : KGBase64单例对象
 */
+ (instancetype)base64;

/** 将NSData数据加密为base64字符串
 * @param data : NSData，加密前的数据
 * @return : NSString，加密后的base64字符串
 */
- (NSString *)base64StringWithData:(NSData *)data;

/** 将字符串加密为base64字符串
 * @param string : NSString，加密前的字符串
 * @return : NSString，加密后的base64字符串
 */
- (NSString *)base64StringWithString:(NSString *)string;

/** 将字符串加密为base64数据
 * @param string : NSString，加密前的字符串
 * @return : 加密后的base64数据
 */
- (NSData *)base64DataWithString:(NSString *)string;

/** 将NSData加密为base64数据
 * @param data : NSData，加密前的数据
 * @return : 加密后的base64数据
 */
- (NSData *)base64DataWithData:(NSData *)data;

/** 将base64数据解密为NSString
 * @param base64Data : NSData，解密前的base64数据
 * @return : NSString，解密后的字符串
 */
- (NSString *)stringFromBase64Data:(NSData *)base64Data;

/** 将base64字符串解密为NSString
 * @param base64String : NSString，解密前的base64字符串
 * @return : NSString，解密后的字符串
 */
- (NSString *)stringFromBase64String:(NSString *)base64String;

/** 将base64字符串解密为NSData
 * @param base64String : NSString，解密前的base64字符串
 * @return : NSData，解密后的数据
 */
- (NSData *)dataFromBase64String:(NSString *)base64String;

/** 将base64数据解密为NSData
 * @param base64Data : NSData，解密前的base64数据
 * @return : NSData，解密后的数据
 */
- (NSData *)dataFromBase64Data:(NSData *)base64Data;

@end

extern NSString *const KGBase64DefaultBase64Key;
