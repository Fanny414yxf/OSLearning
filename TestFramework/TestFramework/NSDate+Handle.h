//
//  NSDate+Handle.h
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/8/21.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Handle)

/**
 * 将2016-11-04格式转成2016年11月04日
 */
+(NSString *)getChinaYearToDayFormatterWithDate:(NSDate *)date;

/**
 * 将2016-11-04格式转成2016年11月04日
 */
+(NSString *)getChinaYearToDayFormatterWithNormal:(NSString *)date;

/**
 * 将11-04 09:30格式转成11月04日 09:30
 */
+(NSString *)getChinaMonthToDayFormatterWithNormal:(NSString *)date;

/**
 * 将2016-11-04 00:00:00格式转成 09:30
 */
+(NSString *)getNormalHourTominuteFormatterWithNormal:(NSString *)date;

/**
 * 将2016-11-04 00:00:00 格式转成2016年11月04日 00:00
 */
+(NSString *)getChinaYearToDayAndHourToMinuteFormatterWithNormal:(NSString *)date;

/**
 * 将20161104000000000 格式转成11-04 00:00
 */
+(NSString *)getChinaMonthToDayAndHourToMinuteFormatterWithNormal:(NSString *)date;

/**
 * 将20161104000000000 格式转成00:00
 */
+(NSString *)getChinaHourToMinuteFormatterWithUSNormal:(NSString *)date;

/**
 * 将2016-11-04 格式转成11-04
 */
+(NSString *)getChinaMonthToDayFormatterWithYearToDay:(NSString *)date;


// -=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=

/**
 * 判断本地存储的时间是否超过了需要验证的时间，如果超过返回Yes,否则返回No
 */
+(NSString *)getCheckTradeTypeWithDefaultTimeKey:(NSString *)date;

/**
 * 将yyyy-MM-dd HH:mm:ss 格式转成MM-dd
 */
+(NSString *)get_MM_dd_With_yyyy_MM_dd_HH_mm_ssType:(NSString *)date;

/**
 * 将yyyy-MM-dd HH:mm:ss 格式转成HH:mm:ss
 */
+(NSString *)get_HH_mm_ss_With_yyyy_MM_dd_HH_mm_ssType:(NSString *)date;

/**
 * 将Date 格式转成yyyy-MM-dd HH:mm:ss
 */
+(NSString *)get_yyyy_MM_dd_HH_mm_ss_With_NSDate_Type:(NSDate *)date;

/**
 * 将yyyyMMddHHmmssSSS 格式转成yyyy-MM-dd HH:mm:ss
 */
+(NSString *)get_yyyy_MM_dd_HH_mm_ss_With_yyyyMMddHHmmssSSS_Type:(NSString *)date;

/**
 * 将Date 格式转成HH:mm
 */
+(NSString *)get_HH_mm_With_NSDate_Type:(NSDate *)date;

/**
 * 将Date 格式转成yyyyMMddHHmmssSSS
 */
+(NSString *)get_yyyyMMddHHmmssSSS_With_NSDate_Type:(NSDate *)date;

/**
 * 将NSDate 格式转成yyyy/MM/dd
 */
+(NSString *)get_yyyy_MM_dd_With_Date_Type:(NSDate *)date;


/**
 * 将NSDate 格式转成yyyy/MM/dd HH:mm
 */
+(NSString *)get_yyyy_MM_dd_HH_mm_With_Date_Type:(NSDate *)date;

/**
 * 将NSDate 格式转成HH:mm
 */
+(NSString *)get_HH_mm_With_Date_Type:(NSDate *)date;

/**
 * 将yyyy/MM/dd字符串 格式转成mm.dd
 */
+(NSString *)get_MM_DD_With_yyyy_MM_dd_Type:(NSString *)date;

/**
 * 通过当前时间和设定时间，获取两个时间相差的小时数
 * return hh:mm 字符串
 */
+(NSString *)get_house_with_between_time:(NSString *)date;

/**
 * 将yyyy-MM-dd 格式转成NSDate
 */
+(NSDate *)get_Date_With_yyyy_MM_dd_Type:(NSString *)date;

@end
