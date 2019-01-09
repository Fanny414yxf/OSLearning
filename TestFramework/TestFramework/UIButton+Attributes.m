//
//  UIButton+Attributes.m
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/8/15.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import "UIButton+Attributes.h"

@implementation UIButton (Attributes)

/**
 * 设置边框
 * @param color 颜色
 * @param width 边框大小
 */
-(void)setBorderWithColor:(UIColor *)color withWidth:(CGFloat )width {
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
}

@end
