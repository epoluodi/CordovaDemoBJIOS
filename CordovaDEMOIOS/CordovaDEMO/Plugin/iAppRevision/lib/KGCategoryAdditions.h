//
//  KGCategoryAdditions.h
//  iAppPDF
//
//  Created by A449 on 16/6/17.
//  Copyright © 2016年 com.kinggrid. All rights reserved.
//

/*
 * V1.2.0 2016-10-20
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>

#pragma mark - CGRect
/** 使求两个Rect的合集
 * @param rect1：rect1
 * @param rect2：rect2
 * @return : 合集Rect
 */
CG_EXTERN CGRect CGRectUnionRect(CGRect rect1, CGRect rect2);

/** 在当前Rect中裁剪size之外的区域
 * @param rect：要裁剪的rect
 * @param size：要保留的区域，size的中心为rect的中心
 * @return : 裁剪之后的rect
 */
CG_EXTERN CGRect CGRectClipUseSize(CGRect rect, CGSize size);

#pragma mark - CGSize
/** 将subSize在superSize中缩放
 * @param subSize：子Size
 * @param superSize：父Size
 * @param scale : 回调缩放倍数
 * @return : 适应后的真实Size
 */
CG_EXTERN CGSize CGSizeScaleInSize(CGSize subSize, CGSize superSize, CGFloat *scale);

#pragma mark - NSData
@interface NSData (KGCategoryAdditions)
/** 将数字转为汉语金额
 * @param money : 将数据转为十六进制字符串
 * @return : 十六进制字符串
 */
- (NSString *)convertToHexadecimalString;
@end

#pragma mark - NSString
@interface NSString (KGCategoryAdditions)

/** 将数字转为汉语金额
 * @param money : 数字金额字符串，精确到小数点后两位
 * @return : 汉字大写金额
 */
+ (NSString *)chineseAmountWithMoney:(NSString *)money;

/*** 根据最大宽度自适应字体大小
 * @param font : UIFont
 * @param minFontSize : 最小字体大小
 * @param actualFontSize : 实际返回的字体大小
 * @param width : 最大宽度
 * @param lineBreakMode : NSLineBreakMode
 * @return : 字符串的范围
 */
- (CGSize)sizeForFont:(UIFont *)font minFontSize:(CGFloat)minFontSize actualFontSize:(CGFloat *)actualFontSize forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

/*** 获取当前字体下的字符串的Size
 * @param font : 字体
 * @return : 当前字体下的字符串的Size
 */
- (CGSize)sizeForFont:(UIFont *)font;

/** 画图
 * @param textAttributes : 文字属性
 * @param inRect : 绘制区域
 * @return : 文字图片
 */
- (UIImage *)drawWithTextAttributes:(NSDictionary *)textAttributes inRect:(CGRect)inRect;

@end

#pragma mark - NSLayoutConstraint

@interface NSLayoutConstraint (KGCategoryAdditions)

/** 获取指定约束
 * @param firstItem : 第一个选项
 * @param firstAttribute : 第一个属性
 * @param relation : 关系
 * @param secondItem : 第二个选项
 * @param secondAttribute : 第二个属性
 * @param multiplier : 倍数
 * @param constant : 距离
 * @param constraints : 约束容器
 @ @return : 约束对象
 */
+ (NSLayoutConstraint *)constraintWithFirstItem:(id)firstItem firstAttribute:(NSInteger)firstAttribute relation:(NSInteger)relation secondItem:(id)secondItem secondAttribute:(NSInteger)secondAttribute multipier:(CGFloat)multiplier constant:(CGFloat)constant inConstraints:(NSArray *)constraints;

@end

#pragma mark - UIButton
typedef NS_ENUM(NSInteger, UIButtonTitlePosition) {
    UIButtonTitlePositionTop = 1,
    UIButtonTitlePositionLeft,
    UIButtonTitlePositionBottom,
    UIButtonTitlePositionRight
};

@interface UIButton (KGCategoryAdditions)

/** 调整UIButton的title与image的位置
 * @param titlePosition : title相对image的位置
 */
- (void)setTitlePosition:(UIButtonTitlePosition)titlePosition forState:(UIControlState)state;

/** 获取指定状态下的标题位置
 * @param state : 状态
 * @return : 标题位置
 */
- (UIButtonTitlePosition)titlePositionForState:(UIControlState)state;

@end

#pragma mark - UIColor
@interface UIColor (KGCategoryAdditions)

/** 将十六进制颜色的字符串转为UIColor
 * @param hexadecimal : 十六进制颜色的字符串
 * @param alpha : 渲染度
 * @return : UIColor
 */
+ (UIColor *)colorWithHexadecimal:(NSString *)hexadecimal alpha:(CGFloat)alpha;

/** 将十六进制颜色的字符串转为UIColor
 * @param hexadecimal : 十六进制颜色的字符串
 * @return : UIColor
 */
+ (UIColor *)colorWithHexadecimal:(NSString *)hexadecimal;

@end

#pragma mark - UIImage
@interface UIImage (KGCategoryAdditions)

/*** 获取视图给定范围内的图片
 * view：要生产图片的视图
 * frame：图片的大小位置
 * return：生成的图片
 */
+ (UIImage *)imageFromView:(UIView *)view atFrame:(CGRect)frame;

/** 将颜色转为图片
 * @param color : UIColor
 * @return：图片
 */
+ (UIImage *)imageWithColor: (UIColor *)color;

/** 合成两张图片
 * @param image 第一张图片
 * @param rect : 第一张图片的区域
 * @param otherImage : 第二张图片
 * @param otherRect : 第二张图片的位置
 * @param inRect : 合成图片的大小
 * @return : 合成后的图片
 */
+ (UIImage *)compoundImage:(UIImage *)image rect:(CGRect)rect otherImage:(UIImage *)otherImage otherRect:(CGRect)otherRect inRect:(CGRect)inRect;

/*** 在给定范围内添加其他图片到当前图片中
 * image：要添加的图片
 * frame：要添加的位置
 * return：添加图片后合成的新图片
 */
- (UIImage *)addImage:(UIImage *)image atFrame:(CGRect)frame;

/*** 旋转图片
 * angle：旋转的角度（弧度值）
 * return：旋转后的图片
 */
- (UIImage *)rotateWithAngle:(CGFloat)angle;

/*** 缩放图片到给定大小
 * size：缩放到给定的大小
 * retrun：缩放后的图片
 */
- (UIImage *)scaleToSize:(CGSize)size;

/*** 等比例缩放图片至固定大小
 * size：缩放到给定的大小
 * return：等比例缩放后的图片
 */
- (UIImage *)scalebyEqualToSize:(CGSize)size;

/*** 按比例缩放图片
 * factor：缩放因子
 * return：缩放后的图片
 */
- (UIImage *)scaleByFactor:(CGFloat)factor;

/*** 裁剪给定区域内的图片
 * rect：裁剪区域
 * return：裁剪区域内的图片
 */
- (UIImage *)croppingAtRect:(CGRect)croppingRect;

/** 在图片上添加文字
 * @param content : 文字
 * @param frame : 位置
 * @param rotation : 旋转角度
 * @return : 新的图片
 */
- (UIImage *)addContent:(NSString *)content textAttributes:(NSDictionary *)textAttributes atFrame:(CGRect)frame rotation:(CGFloat)rotation;

- (UIImage *)addBackgroundColor:(UIColor *)color;
@end

#pragma mark - UINavationController

@interface UINavigationController (KGCategoryAdditions)

/** 重写系统方法 */
- (BOOL)shouldAutorotate;

/** 重写系统方法 */
- (NSUInteger)supportedInterfaceOrientations;

/** 重写系统方法 */
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;

@end

#pragma mark - UIViewController

@interface UIViewController (KGCategoryAdditions)

/** 获取当前最上层的视图控制器
 * @return : 当前最上层视图控制器
 */
+ (UIViewController *)currentTopViewController;
@end
