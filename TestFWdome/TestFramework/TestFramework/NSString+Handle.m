//
//  NSString+Handle.m
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/8/21.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import "NSString+Handle.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Handle)

/**
 * md5 32位 加密 （小写）
 */
+ (NSString *)md5:(NSString *)str
{
    return [[self MD5:str]lowercaseString];
}
+ (NSString *)isActerfanny
{
    return @"fannnyxxx is 小狮子";
}

/**
 * md5 32位 加密 （大写）
 */
+(NSString *)MD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],result[4], result[5], result[6], result[7],
             result[8],result[9], result[10], result[11],result[12], result[13], result[14], result[15]]uppercaseString];
    
}

/**
 * 将字符串转data，并生成字典类型返回
 */
+ (NSDictionary *)getNSDictionaryWithString:(NSString *)value {
    
    NSData * data = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

/**
 * 将字符串转data，并生成数组类型返回
 */
+ (NSArray *)getNSArrayWithString:(NSString *)value {
    
    NSData * data = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return array;
}

/**
 * 如果字符串不存在，则用@" "代替
 */
+ (NSString *)replaceblankStrWhenNil:(NSString *)value {
    return value ? value : @" ";
}

@end
