//
//  UILabel+Attributes.m
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/8/16.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import "UILabel+Attributes.h"

@implementation UILabel (Attributes)

/**
 * 添加下划线
 */
-(void)addUnderLineWithContent:(NSString *)content {
    NSDictionary * attributedDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSAttributedString * attributedText = [[NSAttributedString alloc] initWithString:content attributes:attributedDic];
    self.attributedText = attributedText;
}

/**
 * 设置字体不同颜色
 */
-(void)setAttributedText:(NSString *)content withChangeColor:(UIColor *)changeColor withRange:(NSRange )range {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    [attributedString addAttribute:NSForegroundColorAttributeName value:changeColor range:range];
    self.attributedText = attributedString;
}

/**
 * 设置字体不同颜色（一个字符串多个字体颜色）
 */
-(void)setMoreAttributedText:(NSString *)content withChangeColorArray:(NSArray *)changeColorArray withLocationArray:(NSArray *)locationArray withLenghtArray:(NSArray *)lenghtArray {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    for (int i = 0; i < changeColorArray.count; i++) {
        UIColor * color = changeColorArray[i];
        NSNumber * location = locationArray[i];
        NSNumber * length = lenghtArray[i];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange([location integerValue], [length integerValue])];
    }
    self.attributedText = attributedString;
}

/**
 计算文字长度
 
 @param text 文字
 @param font 字体
 @return 长度
 */
+ (CGFloat )widthForLabel:(NSString *)text fontSize:(CGFloat)font {
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
}

@end
