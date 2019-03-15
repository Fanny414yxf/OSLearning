//
//  SingletonTest.h
//  FileOptionDome
//
//  Created by cximac on 2019/3/15.
//  Copyright © 2019 cximac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "singleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface SingletonTest : NSObject

singleton_interface(SingletonTest)
@property(nonatomic,strong) NSString * name;

@end

NS_ASSUME_NONNULL_END
