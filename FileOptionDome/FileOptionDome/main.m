//
//  main.m
//  FileOptionDome
//
//  Created by cximac on 2019/3/11.
//  Copyright © 2019 cximac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Method.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        
        Method *method = [[Method alloc] init];
        [method beginToChangeFilesHash];
//        [method beginToCopy];
        
    }
    return 0;
}
