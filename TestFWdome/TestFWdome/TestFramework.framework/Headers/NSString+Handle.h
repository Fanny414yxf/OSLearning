//
//  NSString+Handle.h
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/8/21.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Handle)

/**
 * md5 32位 加密 （小写）
 */
+ (NSString *)md5:(NSString *)str;

/**
 * md5 32位 加密 （大写）
 */
+ (NSString *)MD5:(NSString *)str;

/**
 * 将字符串转data，并生成字典类型返回
 */
+ (NSDictionary *)getNSDictionaryWithString:(NSString *)value;

/**
 * 将字符串转data，并生成数组类型返回
 */
+ (NSArray *)getNSArrayWithString:(NSString *)value;

/**
 * 如果字符串不存在，则用@" "代替
 */
+ (NSString *)replaceblankStrWhenNil:(NSString *)value;

@end
