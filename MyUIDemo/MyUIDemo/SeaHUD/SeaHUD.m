//
//  SeaHUD.m
//  MyUIDemo
//
//  Created by Bob on 2018/12/21.
//  Copyright © 2018年 seabrea. All rights reserved.
//

#import "SeaHUD.h"

@implementation SeaHUD

+ (void)alertTitle:(NSString *)titleStr Content:(NSString *)contentStr Confirm:(void(^)(void))confirmHandler {
    [[SeaHUD shareInstance] alertTitle:titleStr Content:contentStr CancelTitle:@"取消" CancelAction:nil ConfirmTitle:@"确定" Confirm:confirmHandler];
}

+ (void)popActionSheetList:(NSArray<NSString *> *)list CloseTitle:(NSString * _Nullable)closeTitle SelectAction:(void(^)(NSUInteger selectIndex))handler {
    [[SeaHUD shareInstance] popActionSheetList:list Title:nil Content:nil CloseTitle:closeTitle SelectAction:handler];
}


#pragma mark - singleton

static SeaHUD *instance = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SeaHUD alloc] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return instance;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return instance;
}


#pragma mark - Private Methods

- (void)alertTitle:(NSString *)titleStr Content:(NSString *)contentStr CancelTitle:(NSString *)cancelStr CancelAction:(void(^)(void))cancelHandler ConfirmTitle:(NSString *)confirmStr Confirm:(void(^)(void))confirmHandler {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:titleStr message:contentStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        confirmHandler();
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    [[self curKeyViewController] presentViewController:alertVC animated:YES completion:nil];
}

- (void)popActionSheetList:(NSArray<NSString *> *)contentlist Title:(NSString *)titleStr Content:(NSString *)contentStr CloseTitle:(NSString *)colseStr SelectAction:(void(^)(NSUInteger selectIndex))handler {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:titleStr message:contentStr preferredStyle:UIAlertControllerStyleActionSheet];
    
    if(colseStr) {
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:colseStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        [alertVC addAction:closeAction];
    }
    
    [contentlist enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *itemAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler(idx);
        }];
        [alertVC addAction:itemAction];
    }];
    
    [[self curKeyViewController] presentViewController:alertVC animated:YES completion:nil];
}

- (UIWindow *)curKeyWindow {
    
    UIWindow *window = nil;
    UIApplication *app = [UIApplication sharedApplication];
    if([app.delegate respondsToSelector:@selector(window)]) {
        window = app.delegate.window;
    }
    else {
        window = app.keyWindow;
    }
    
    return window;
}

- (UIViewController *)curKeyViewController {
    
    UIViewController* currentViewController = [self curKeyWindow].rootViewController;
    
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        }
        else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        }
        else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        }
        else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            }
            else {
                
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

@end
