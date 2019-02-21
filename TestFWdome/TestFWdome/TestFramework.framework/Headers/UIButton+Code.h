//
//  UIButton+Code.h
//  SMarManagerPro
//
//  Created by 陈晨昕 on 2018/8/16.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Code)

/**
 * 获取验证码计时器
 */
-(void)getVerfyCodeWithEndTitle:(NSString *)endTitle withBlock:(void(^)(void))endBlock;

@end
