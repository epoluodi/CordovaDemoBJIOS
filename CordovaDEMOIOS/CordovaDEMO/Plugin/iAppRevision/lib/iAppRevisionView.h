//
//  iAppRevisionView.h
//  iAppRevision
//
//  Created by A449 on 15/12/9.
//  Copyright © 2015年 com.kinggrid. All rights reserved.
//

/*
 * 更新于：2016-07-06
 */

#import <UIKit/UIKit.h>
#import "KGCategoryAdditions.h"
#import "KGTypeDefines.h"

@class iAppRevision;

/** 保存签名的闭包 */
typedef void(^iAppRevisionViewSaveSignatureBlock)(UIImage *iAppRevisionViewImage, UIImage *signatureImage, CGRect signatureRect);

#pragma mark - iAppRevisionView
@interface iAppRevisionView : UIView

/** 签名类型 */
@property (assign, nonatomic) KGSignatureType signatureType;
/** 是否开启水印 */
@property (assign, nonatomic, getter=isWatermark) BOOL watermark;

//手写签名类型的设置选项
/** 手写签名的笔锋类型 */
@property (assign, nonatomic) KGHandwritingType handwritingType;
/** 手写签名的笔锋宽度（0 ~ 1] */
@property (assign, nonatomic) CGFloat handwritingWidth;
/** 手写签名的笔锋颜色 */
@property (copy, nonatomic) UIColor *handwritingColor;

//文本签批类型的设置选项
/** 文本字体 */
@property (copy, nonatomic) UIFont *textFont;
/** 文本颜色 */
@property (copy, nonatomic) UIColor *textColor;

/** 水印图片
 * @param originImage : 原图
 * @param content : 水印内容，不可为空
 * @param color: 颜色，默认黑色
 * @param position : 水印位置，默认右下角
 * @param scaleFactor : 缩放因子，(0, 1]，默认0.5
 * @return : 水印图片
 */
+ (UIImage *)watermarkImage:(UIImage *)originImage content:(NSString *)content color:(UIColor *)color position:(KGWatermarkPosition)position scaleFactor:(CGFloat)scaleFactor;

/** 水印图片
 * @param originImage : 原图
 * @param content : 水印内容，不可为空
 * @param textAttributes: 水印文字属性
 * @param position : 水印位置，默认右下角
 * @param gapPoint : 水印偏移量
 * @return : 水印图片
 */
+ (UIImage *)watermarkImage:(UIImage *)originImage content:(NSString *)content textAttributes:(NSDictionary *)textAttributes position:(KGWatermarkPosition)position gapPoint:(CGPoint)gapPoint;

/** 盖章
 * note 盖章签名类型的设置选项
 * @param image : 盖章图片
 */
- (void)stampWithImage:(UIImage *)image;

/** 设置水印内容
 * @param content : 水印内容，不可为空
 * @param color: 颜色，默认黑色
 * @param position : 水印位置，默认右下角
 * @param scaleFactor : 缩放因子，(0, 1]，默认0.5
 */
- (void)setWatermarkWithContent:(NSString *)content color:(UIColor *)color position:(KGWatermarkPosition)position scaleFactor:(CGFloat)scaleFactor;

/** 撤销操作 */
- (void)undo;

/** 恢复操作 */
- (void)redo;

/** 清屏操作 */
- (void)clean;

/** 保存签名
 * @param completion : 完成回调
 */
- (void)saveSignatureWithCompletion:(iAppRevisionViewSaveSignatureBlock)completion;
@end

#pragma mark - Class - KGHandwritingView
@interface KGHandwritingView : UIView

/** 是否开启水印 */
@property (assign, nonatomic, getter=isWatermark) BOOL watermark;
/** 手写签名的笔锋类型 */
@property (assign, nonatomic) KGHandwritingType handwritingType;
/** 手写签名的笔锋宽度（0 ~ 1] */
@property (assign, nonatomic) CGFloat handwritingWidth;
/** 手写签名的笔锋颜色 */
@property (copy, nonatomic) UIColor *handwritingColor;

/** 撤销操作 */
- (void)undo;

/** 恢复操作 */
- (void)redo;

/** 清屏操作 */
- (void)clean;

/** 设置水印内容
 * @param content : 水印内容，不可为空
 * @param color: 颜色，默认黑色
 * @param position : 水印位置，默认右下角
 * @param scaleFactor : 缩放因子，(0, 1]，默认0.5
 */
- (void)setWatermarkWithContent:(NSString *)content color:(UIColor *)color position:(KGWatermarkPosition)position scaleFactor:(CGFloat)scaleFactor;

/** 保存签名
 * @param completion : 完成回调
 */
- (void)saveHandwritingSignatureWithCompletion:(iAppRevisionViewSaveSignatureBlock)completion;

@end

#pragma mark - Class - KGTextView

@interface KGTextView : UIView

/** 显示输入辅助视图，默认：NO */
@property (assign, nonatomic, getter=isShowInputAccessoryView) BOOL showInputAccessoryView;
/** 是否开启水印 */
@property (assign, nonatomic, getter=isWatermark) BOOL watermark;
/** 文字字体 */
@property (copy, nonatomic) UIFont *textFont;
/** 文字颜色 */
@property (copy, nonatomic) UIColor *textColor;

/** 设置水印内容
 * @param content : 水印内容，不可为空
 * @param color: 颜色，默认黑色
 * @param position : 水印位置，默认右下角
 * @param scaleFactor : 缩放因子，(0, 1]，默认0.5
 */
- (void)setWatermarkWithContent:(NSString *)content color:(UIColor *)color position:(KGWatermarkPosition)position scaleFactor:(CGFloat)scaleFactor;

/** 清屏操作 */
- (void)clean;

/** 保存签名
 * @param completion : 完成回调
 */
- (void)saveTextSignatureWithCompletion:(iAppRevisionViewSaveSignatureBlock)completion;

@end

#pragma mark - Class - KGSealView
@interface KGSealView : UIView

/** 是否开启水印 */
@property (assign, nonatomic, getter=isWatermark) BOOL watermark;

/** 盖章
 * @param image : 盖章图片
 */
- (void)stampWithImage:(UIImage *)image;

/** 清屏操作 */
- (void)clean;

/** 设置水印内容
 * @param content : 水印内容，不可为空
 * @param color: 颜色，默认黑色
 * @param position : 水印位置，默认右下角
 * @param scaleFactor : 缩放因子，(0, 1]，默认0.5
 */
- (void)setWatermarkWithContent:(NSString *)content color:(UIColor *)color position:(KGWatermarkPosition)position scaleFactor:(CGFloat)scaleFactor;

/** 保存盖章
 * @param completion : 完成回调
 */
- (void)saveSealSignatureWithCompletion:(iAppRevisionViewSaveSignatureBlock)completion;
@end