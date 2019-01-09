//
//  AppDelegate+Handle.m
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/8/21.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import "AppDelegate+Handle.h"
#import <dlfcn.h>

@implementation AppDelegate (Handle)

/**
 * 获取设备唯一标识
 */
- (void)applicationGetDeviceID {
    
    NSString* idfa = nil;
    @try {
        void *addll = dlopen("/System/Library/PrivateFrameworks/AdSupport.framework/AdSupport", RTLD_LAZY);
        Class kls = NSClassFromString([NSString stringWithFormat:@"%@%@%@",@"AS",@"Identifier",@"Manager"]);
        idfa = [[[kls performSelector:NSSelectorFromString(@"sharedManager")] performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@%@",@"advertising",@"Identifier"])] performSelector:NSSelectorFromString(@"UUIDString")];
        dlclose(addll);
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
}

@end
