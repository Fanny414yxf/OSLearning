//
//  UIAlertController+BlocksKit.m
//  SMarManagerPro
//
//  Created by 陈晨昕 on 2018/9/11.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import "UIAlertController+BlocksKit.h"

@implementation UIAlertController (BlocksKit)

+ (UIAlertController *)bk_showAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(UIAlertController *alertController, NSInteger buttonIndex))block {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //取消
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            block(alertController,0);
        }];
        [alertController addAction:cancelAction];
    }
    
    //其他按钮
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString * name, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(alertController, idx + 1);
        }];
        [alertController addAction:otherAction];
    }];
    
    return alertController;
}

+ (UIAlertController *)bk_showActionSheetViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(UIAlertController *alertController, NSInteger buttonIndex))block {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    //取消
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            block(alertController,0);
        }];
        [alertController addAction:cancelAction];
    }
    
    //其他按钮
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString * name, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(alertController, idx + 1);
        }];
        [alertController addAction:otherAction];
    }];
    
    return alertController;
}

@end
