//
//  UINavigationBar+FixSpace.m
//  AutoFinanceProjectOC
//
//  Created by 陈晨昕 on 2018/7/26.
//  Copyright © 2018年 autofinance. All rights reserved.
//

#import "UINavigationBar+FixSpace.h"
#import "NSObject+Runtime.h"

@implementation UINavigationBar (FixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithOriginSel:@selector(layoutSubviews)
                                     swizzledSel:@selector(sx_layoutSubviews)];
    });
}

-(void)sx_layoutSubviews{
    [self sx_layoutSubviews];
    
    if (9 >= 11) {
        self.layoutMargins = UIEdgeInsetsZero;
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                subview.layoutMargins = UIEdgeInsetsZero;//可修正iOS11之后的偏移
            }
        }
    }
}

@end
