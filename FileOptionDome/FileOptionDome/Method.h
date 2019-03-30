//
//  Method.h
//  FileOptionDome
//
//  Created by cximac on 2019/3/11.
//  Copyright © 2019 cximac. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface Method : NSObject

@property (nonatomic, strong)NSMutableArray *resFilesArr;


- (void)beginToChangeFilesHash;

- (void)beginToCopy;

@end

NS_ASSUME_NONNULL_END
