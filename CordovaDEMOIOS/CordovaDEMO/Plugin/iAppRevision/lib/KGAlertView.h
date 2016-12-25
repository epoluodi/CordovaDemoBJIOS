//
//  KGAlertView.h
//  iAppRevision
//
//  Created by A449 on 15/12/3.
//  Copyright © 2015年 com.kinggrid. All rights reserved.
//

/*
 * 更新于：2016-07-07
 */
#import <UIKit/UIKit.h>

typedef void (^KGAlertViewVoidVoidCompletionBlock)(void);
typedef void(^KGAlertViewClickButtonBlock)(NSInteger buttonIndex);

typedef NS_ENUM(NSInteger, KGAlertViewTransitionStyle) {
    
    KGAlertViewTransitionStyleGradual = 0,    //渐变
    KGAlertViewTransitionStyleBounce,         //弹跳
    KGAlertViewTransitionStyleMoveIn,         //覆盖
};

#pragma mark - Class - KGAlertView
/* 不可以直接使用KGAlertView，必须使用其子类 */
@interface KGAlertView : UIView

/** 过度风格 */
@property (assign, nonatomic) KGAlertViewTransitionStyle transitionStyle;
/** 标题 */
@property (copy, nonatomic) NSString *title;
/** 标题字体 */
@property (strong, nonatomic) UIFont *titleFont;
/** 消息 */
@property (copy, nonatomic) NSString *message;
/** 消息字体 */
@property (strong, nonatomic) UIFont *messageFont;
/** 消息文本对齐方式，默认中间对齐 */
@property (nonatomic, assign) NSTextAlignment messageAlignment;
/** 激活触摸背景 */
@property (nonatomic, assign, getter=isActivateTouchBackground) BOOL activateTouchBackground;

/** 展示 */
- (void)show;

/** 移除 */
- (void)dismiss;

/** 移除视图 */
- (void)dismissWithCompletion:(void(^)(void))completion;

/** 触摸背景消失 */
- (void)dismissWithTouchBackground:(void(^)(void))completion;
@end

@interface KGAlertPopupView : KGAlertView

/** 取消按钮的索引
 * @note : 索引为0，如果没有取消按钮则为-1 */
@property (assign, nonatomic, readonly) NSInteger cancelButtonIndex;
/** 按钮数量 */
@property (assign, nonatomic, readonly) NSInteger numberOfButtons;
/** 按钮字体颜色 */
@property (nonatomic, strong) UIColor *buttonTextColor;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/** 添加取消按钮
 * @param title : 按钮标题
 * @return : 按钮索引
 */
- (NSInteger)addButtonWithTitle:(NSString *)title;

/** 添加取消按钮
 * @param buttonIndex : 按钮索引
 * @return : 按钮标题
 */
- (NSString *)buttonTitleWithIndex:(NSInteger)buttonIndex;

/** 点击按钮的操作
 * @param clickedButton : 点击按钮的回到操作
 */
- (void)dismissWithClickedButtonAtIndex:(KGAlertViewClickButtonBlock)clickedButtonBlock;

/** 点击按钮的操作
 * @note 如果没有取消按钮，可以使用此方法移除弹出框
 * @param clickedCancelButtonBlock : 点击取消按钮操作的回调操作
 */
- (void)dismissWithClickedCancelButton:(void(^)(void))clickedCancelButtonBlock;

@end

#pragma mark - Class - KGAlertProgressView
/* 进度提醒模式 */
typedef NS_ENUM(NSInteger, KGAlertProgressViewMode) {
    
    KGAlertProgressViewModeIndicator = 0,    //指示器
    KGAlertProgressViewModeText,             //纯文本
};
@interface KGAlertProgressView : KGAlertView
/** 模式 */
@property (nonatomic, assign) KGAlertProgressViewMode mode;

/** 初始化
 * @param mode : 进度提醒模式
 * @return : 实例对象
 */
- (instancetype)initWithMode:(KGAlertProgressViewMode)mode;

/** 延迟消失 */
- (void)dismissAfterDelay:(NSTimeInterval)interval completion:(void (^)(void))completion;
@end

#pragma mark - Class - KGAlertPopoverView
@interface KGAlertPopoverView : KGAlertView

/** 最大尺寸
 * @note 同时设定maxSize、boundsEdgeInsets时，maxSize优先
 */
@property (assign, nonatomic) CGSize maxSize;
/** 适应尺寸 */
@property (assign, nonatomic, getter = isFitSize) BOOL fitSize;
/** 距边界的距离
 * @note 同时设定maxSize、boundsEdgeInsets时，maxSize优先
 */
@property (assign, nonatomic) UIEdgeInsets boundsEdgeInsets;
/** 内容最小高度，默认：0 */
@property (nonatomic, assign) CGFloat contentMinHeight;
/** 内容视图 */
@property (nonatomic, strong, readonly) UIView *contentView;

/** 初始化
 * @param contentView : 内容视图
 * @return : 实例
 */
- (instancetype)initWithContentView:(UIView *)contentView;

@end
