//
//  UIButton+Code.m
//  SMarManagerPro
//
//  Created by 陈晨昕 on 2018/8/16.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import "UIButton+Code.h"

@implementation UIButton (Code)

/**
 * 获取验证码计时器
 */
-(void)getVerfyCodeWithEndTitle:(NSString *)endTitle withBlock:(void(^)(void))endBlock {
    
    self.enabled = NO;
    
    
    __block int timeCount = 30;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeCount <= 0) {//倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                [self setTitle:endTitle forState:UIControlStateNormal];
                
                //结束回调
                endBlock();
            });
        } else {
            
            NSString *btnTitle = [NSString stringWithFormat:@"%ds",timeCount];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 如有需要可在这边刷新视图
                [self setTitle:btnTitle forState:UIControlStateNormal];
            });
            
            timeCount--;
        }
    });
    dispatch_resume(timer);
}

@end
