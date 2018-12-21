//
//  SeaHUD.h
//  MyUIDemo
//
//  Created by Bob on 2018/12/21.
//  Copyright © 2018年 seabrea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeaHUD : NSObject

/**
 中心弹框
 
 @param titleStr       标题内容
 @param contentStr     弹框内容
 @param confirmHandler 确定按钮事件
 */
+ (void)alertTitle:(NSString *)titleStr Content:(NSString *)contentStr Confirm:(void(^)(void))confirmHandler;

/**
 底部弹框
 
 @param list       弹框内容
 @param closeTitle 关闭按钮标题，如此传nil则不显示关闭按钮
 @param handler    内容选择事件
 */
+ (void)popActionSheetList:(NSArray<NSString *> *)list CloseTitle:(NSString * _Nullable)closeTitle SelectAction:(void(^)(NSUInteger selectIndex))handler;

@end

NS_ASSUME_NONNULL_END
