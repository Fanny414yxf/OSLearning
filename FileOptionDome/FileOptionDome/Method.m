//
//  Method.m
//  FileOptionDome
//
//  Created by cximac on 2019/3/11.
//  Copyright © 2019 cximac. All rights reserved.
//

#import "Method.h"
#import "SingletonTest.h"
@implementation Method


- (void)beginToChangeFilesHash;
{
    SingletonTest *singletonTest = [SingletonTest sharedSingletonTest];
    singletonTest.name = @"fanny";
    
    
    _resFilesArr = [NSMutableArray array];
    NSString *path = @"/Users/cximac/Desktop/测试ipa/Payload/rqaichengkimjonh.app";
    [self saveToMixResFileArrWithPath:path];
    
    NSFileManager *manage = [NSFileManager defaultManager];
    long long absize = 0;
    NSInteger fileNumber=0,bundleNumber=0,abFileNumber=0;
    for (NSString *filePath in _resFilesArr) {
        fileNumber++;

        if ([filePath.pathExtension isEqualToString:@"ab"]){
        absize += [[manage attributesOfItemAtPath:filePath error:nil] fileSize];
            abFileNumber++;
        }
        
        if ([filePath.pathExtension isEqualToString:@"bundle"]){
            
            bundleNumber++;
        }
        
    }
    CGFloat d = absize/(1024.0*1024.0);
    NSLog(@"fileNumber:%lu---abFileNumber:%lu---bundleNumber:%lu  absize:%lld  d:%f ",fileNumber,abFileNumber,bundleNumber,absize,d);
}


- (void)saveToMixResFileArrWithPath:(NSString *)fromPath
{
    // 1.判断文件还是目录
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:fromPath isDirectory:&isDir];
    if (isExist) {
        // 2. 判断是不是目录
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:fromPath error:nil];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [fromPath stringByAppendingPathComponent:str];
//                if ([subPath hasSuffix:@".bundle"]) {
//                    NSLog(@"bundle");
//                }
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                [self saveToMixResFileArrWithPath:subPath];
            }
        }else{
            if ([fromPath.pathExtension isEqualToString:@"png"]){
                NSLog(@"png");
            }else if ([fromPath.pathExtension isEqualToString:@"bundle"]){
                NSLog(@"bundle");
            }else{
                 [_resFilesArr addObject:fromPath];
            }
        }
    }
    else{
        NSLog(@"你打印的是目录或者不存在");
    }
}

@end
