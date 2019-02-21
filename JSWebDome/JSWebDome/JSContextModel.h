//
//  JSContextModel.h
//  JSWebDome
//
//  Created by cximac on 2019/2/18.
//  Copyright © 2019 cximac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JSContextExport <JSExport>

- (void)logOut;

JSExportAs(login, - (void)longinWithAccount:(NSString *)account password:(NSString *)password);


- (NSDictionary *)getLoginUser;


@end

@interface JSContextModel : NSObject<JSContextExport>

@end

NS_ASSUME_NONNULL_END
