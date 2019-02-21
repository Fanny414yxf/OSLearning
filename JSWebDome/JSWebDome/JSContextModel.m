//
//  JSContextModel.m
//  JSWebDome
//
//  Created by cximac on 2019/2/18.
//  Copyright © 2019 cximac. All rights reserved.
//

#import "JSContextModel.h"
#import <UIKit/UIKit.h>

@implementation JSContextModel

- (void)logOut
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"原生弹窗" message:@"执行【登出】操作" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }];
}


- (void)longinWithAccount:(NSString *)account password:(NSString *)password
{
    NSString *msg = [NSString stringWithFormat:@"账号：%@   密码：%@",account, password];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"msg" message:@"登录" delegate:nil cancelButtonTitle:msg otherButtonTitles:@"好", nil];
    [alert show];
}


- (NSDictionary *)getLoginUser
{
    return @{
             @"user_id": @(666),
             @"username": @"你就说6不6",
             @"sex": @"未知",
             @"isStudent": @(NO)
             };
}


@end
