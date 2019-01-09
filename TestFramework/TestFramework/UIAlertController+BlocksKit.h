//
//  UIAlertController+BlocksKit.h
//  SMarManagerPro
//
//  Created by 陈晨昕 on 2018/9/11.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (BlocksKit)

/** Creates and shows a new alert view with only a title, message, and cancel button.
 
 @param title The title of the alert view.
 @param message The message content of the alert.
 @param cancelButtonTitle The title of the cancel button. If both cancelButtonTitle and otherButtonTitles are empty or nil, defaults to a
 @param otherButtonTitles Titles of additional buttons to add to the receiver.
 @param block A block of code to be fired on the dismissal of the alert view.
 
 @return The UIAlertController.
 */
+ (UIAlertController *)bk_showAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(UIAlertController *alertController, NSInteger buttonIndex))block;

/** Creates and shows a new action sheet view with only a title, message, and cancel button.
 
 @param title The title of the alert view.
 @param message The message content of the alert.
 @param cancelButtonTitle The title of the cancel button. If both cancelButtonTitle and otherButtonTitles are empty or nil, defaults to a
 @param otherButtonTitles Titles of additional buttons to add to the receiver.
 @param block A block of code to be fired on the dismissal of the alert view.
 
 @return The UIAlertController.
 */
+ (UIAlertController *)bk_showActionSheetViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(UIAlertController *alertController, NSInteger buttonIndex))block;

@end
