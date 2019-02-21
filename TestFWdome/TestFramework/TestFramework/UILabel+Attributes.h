//
//  UILabel+Attributes.h
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/8/16.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Attributes)

/**
 * 添加下划线
 */
-(void)addUnderLineWithContent:(NSString *)content;

/**
 * 设置字体不同颜色
 */
-(void)setAttributedText:(NSString *)content withChangeColor:(UIColor *)changeColor withRange:(NSRange )range;


/**
 * 设置字体不同颜色（一个字符串多个字体颜色）
 */
-(void)setMoreAttributedText:(NSString *)content withChangeColorArray:(NSArray *)changeColorArray withLocationArray:(NSArray *)locationArray withLenghtArray:(NSArray *)lenghtArray;

/**
 计算文字长度
 
 @param text 文字
 @param font 字体
 @return 长度
 */
+ (CGFloat )widthForLabel:(NSString *)text fontSize:(CGFloat)font;

@end
