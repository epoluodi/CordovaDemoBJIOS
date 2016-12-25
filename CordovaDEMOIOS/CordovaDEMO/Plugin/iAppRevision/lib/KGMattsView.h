//
//  KGMattsView.h
//  iAppRevision
//
//  Created by A449 on 15/11/24.
//  Copyright © 2015年 com.kinggrid. All rights reserved.
//

/*
 * 更新于：2016-11-05
 */

#import <UIKit/UIKit.h>

@class iAppRevision;
@class KGBrushSettingView;
@class KGAlertView;

/** 移除视图的风格 */
typedef NS_ENUM(NSInteger, KGMattsViewDismissStyle) {
    
    KGMattsViewDismissStyleCancel = 0,
    KGMattsViewDismissStyleSave
};

typedef void(^KGMattsViewDismissStyleBlock)(KGMattsViewDismissStyle dismissStyle, UIImage *mattsImage);


@interface KGMattsView : UIView

/** 图片字体尺寸 */
@property (assign, nonatomic) CGSize wordSize; //默认，{80, 80}

/** 初始化
 * @param size : 视图尺寸
 * @return : 视图实例
 */
- (instancetype)initWithSize:(CGSize)size;

/** 展示视图 */
- (void)show;

/** 移除视图
 * @param dismissStyleBlock : 移除类型回调
 */
- (void)dismissWithStyle:(KGMattsViewDismissStyleBlock)dismissStyleBlock;

@end
