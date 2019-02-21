//
//  NSDate+Handle.m
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/8/21.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import "NSDate+Handle.h"

@implementation NSDate (Handle)

/**
 * 判断本地存储的时间是否超过了需要验证的时间，如果超过返回Yes,否则返回No
 */
+(NSString *)getCheckTradeTypeWithDefaultTimeKey:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * oldDate = [formatter dateFromString:date];
    
    NSInteger second_15 = 900.0;
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:oldDate];
    
    if (timeInterval > second_15) {
        return @"Yes";
    } else {
        return @"No";
    }
}

/**
 * 将2016-11-04格式转成2016年11月04日
 */
+(NSString *)getChinaYearToDayFormatterWithDate:(NSDate *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString * reusltDate = [formatter stringFromDate:date];
    
    return reusltDate;
}

/**
 * 将2016-11-04格式转成2016年11月04日
 */
+(NSString *)getChinaYearToDayFormatterWithNormal:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将11-04 09:30格式转成11月04日 09:30
 */
+(NSString *)getChinaMonthToDayFormatterWithNormal:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将2016-11-04 00:00:00格式转成 09:30
 */
+(NSString *)getNormalHourTominuteFormatterWithNormal:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"HH:mm"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将2016-11-04 00:00:00 格式转成2016年11月04日 00:00
 */
+(NSString *)getChinaYearToDayAndHourToMinuteFormatterWithNormal:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将20161104000000000 格式转成11-04 00:00
 */
+(NSString *)getChinaMonthToDayAndHourToMinuteFormatterWithNormal:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将20161104000000000 格式转成00:00
 */
+(NSString *)getChinaHourToMinuteFormatterWithUSNormal:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"HH:mm"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将2016-11-04 格式转成11-04
 */
+(NSString *)getChinaMonthToDayFormatterWithYearToDay:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"MM-dd"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将yyyy-MM-dd HH:mm:ss 格式转成MM-dd
 */
+(NSString *)get_MM_dd_With_yyyy_MM_dd_HH_mm_ssType:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"MM-dd"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将yyyy-MM-dd HH:mm:ss 格式转成HH:mm:ss
 */
+(NSString *)get_HH_mm_ss_With_yyyy_MM_dd_HH_mm_ssType:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将Date 格式转成yyyy-MM-dd HH:mm:ss
 */
+(NSString *)get_yyyy_MM_dd_HH_mm_ss_With_NSDate_Type:(NSDate *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * oldTimeStr = [formatter stringFromDate:date];
    
    return oldTimeStr;
}

/**
 * 将yyyyMMddHHmmssSSS 格式转成yyyy-MM-dd HH:mm:ss
 */
+(NSString *)get_yyyy_MM_dd_HH_mm_ss_With_yyyyMMddHHmmssSSS_Type:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}

/**
 * 将Date 格式转成HH:mm
 */
+(NSString *)get_HH_mm_With_NSDate_Type:(NSDate *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString * oldTimeStr = [formatter stringFromDate:date];
    
    return oldTimeStr;
}

/**
 * 将Date 格式转成yyyyMMddHHmmssSSS
 */
+(NSString *)get_yyyyMMddHHmmssSSS_With_NSDate_Type:(NSDate *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString * oldTimeStr = [formatter stringFromDate:date];
    
    return oldTimeStr;
}

/**
 * 将NSDate 格式转成yyyy/MM/dd
 */
+(NSString *)get_yyyy_MM_dd_With_Date_Type:(NSDate *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * reusltDate = [formatter stringFromDate:date];
    
    return reusltDate;
}

/**
 * 将NSDate 格式转成yyyy/MM/dd HH:mm
 */
+(NSString *)get_yyyy_MM_dd_HH_mm_With_Date_Type:(NSDate *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * reusltDate = [formatter stringFromDate:date];
    
    return reusltDate;
}

/**
 * 将NSDate 格式转成HH:mm
 */
+(NSString *)get_HH_mm_With_Date_Type:(NSDate *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString * reusltDate = [formatter stringFromDate:date];
    
    return reusltDate;
}

/**
 * 将yyyy/MM/dd字符串 格式转成mm.dd
 */
+(NSString *)get_MM_DD_With_yyyy_MM_dd_Type:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * normalDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:@"MM.dd"];
    NSString * reusltDate = [formatter stringFromDate:normalDate];
    
    return reusltDate;
}


/**
 * 通过当前时间和设定时间，获取两个时间相差的小时数
 * return hh:mm 字符串
 */
+(NSString *)get_house_with_between_time:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSString * currentTimeStr = [formatter stringFromDate:[NSDate date]];
    
    NSDate * currentDate = [formatter dateFromString:currentTimeStr];
    NSDate * otherTimeDate = [formatter dateFromString:date];
    
    NSTimeInterval seconds = [currentDate timeIntervalSinceDate:otherTimeDate];
    
    // 18小时
    NSTimeInterval count = 18 * 60 * 60;
    if (seconds > count) {
        return @"00:00";
    }
    
    NSInteger time = count - seconds;
    NSInteger hours = (int)(time/3600);
    NSInteger minute = (int)(time-hours*3600)/60;
    NSString * resultStr = [NSString stringWithFormat:@"%ld:%ld",hours,minute];
    
    return resultStr;
}

/**
 * 将yyyy-MM-dd 格式转成NSDate
 */
+(NSDate *)get_Date_With_yyyy_MM_dd_Type:(NSString *)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * resultDate = [formatter dateFromString:date];
    
    return resultDate;
}

@end
