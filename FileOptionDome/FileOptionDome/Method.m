//
//  Method.m
//  FileOptionDome
//
//  Created by cximac on 2019/3/11.
//  Copyright © 2019 cximac. All rights reserved.
//

#import "Method.h"
#import "SingletonTest.h"

@interface Method()
{
    NSInteger bundles;
    
    NSString *_fileType;
    NSMutableArray *_resultFilesArr;
    CGFloat _mixFilesSize;
    NSMutableArray *_mixFilesArr;
}



@end

@implementation Method

//一个文件里的文件类型，各种类型文件的数量
- (void)beginToChangeFilesHash;
{
    SingletonTest *singletonTest = [SingletonTest sharedSingletonTest];
    singletonTest.name = @"fanny";
    
    
    _resFilesArr = [NSMutableArray array];
    NSString *path = @"/Users/cximac/Documents/CX/上传包体/青云传/56-神荒/*/Payload/W6vdShenhuang.app";
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
//                    bundles ++;
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


- (void)beginToCopy;
{
    _resFilesArr = [NSMutableArray array];
    _mixFilesArr = [NSMutableArray array];
    _resultFilesArr = [NSMutableArray array];
    
    NSString *fromPath = @"/Users/cximac/Desktop/test/from";
    NSString*toPath = @"/Users/cximac/Desktop/test/to";
    int num = 0;
    printf("请输入文件处理大小（单位：MB）:");
    scanf("%d",&num);
    _mixFilesSize = 1024 * num;
    
    int judge = 0;
    printf("选择拷贝的文件类型（ 1代表拷贝图片格式，2代表拷贝非图片格式，其他数字代表全部格式）:");
    scanf("%d",&judge);
    if (judge == 1) {
        _fileType = @"image";
    }
    else if (judge == 2){
        _fileType = @"image_else";
    }
    else{
        _fileType = @"all";
    }
    
    [self saveToMixResFileArrWithPath:fromPath];
    
    //获得待混淆的文件
    _mixFilesArr = [self getRandomFileByArr:_resFilesArr];
    
    [self copyFilesToPath:toPath];
}

/**从资源文件中获得随机资源数组*/
- (NSMutableArray *)getRandomFileByArr:(NSMutableArray *)resArr
{
    NSMutableArray *randomArray = [[NSMutableArray alloc] init];
    CGFloat totalFilesSize = 0.0;
    while (totalFilesSize < _mixFilesSize) {
        //随机数
        NSInteger index = arc4random() % [resArr count];
        NSString *filePath = [resArr objectAtIndex:index];
        
        //只拷贝图片
        if ([_fileType isEqualToString:@"image"]) {
            if ([filePath.pathExtension isEqualToString:@"png"] || [filePath.pathExtension isEqualToString:@"jpg"]){
                NSDictionary *tempDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
                CGFloat fileSize = [tempDict fileSize]/1024.0;   //当前文件大小
                totalFilesSize += fileSize;
                [randomArray addObject:filePath];
            }
        }
        
        //拷贝除图片资源意外的其他资源文件
        else if ([_fileType isEqualToString:@"image_else"]){
            if ([filePath.pathExtension isEqualToString:@"png"] || [filePath.pathExtension isEqualToString:@"jpg"]) {
                continue;
            }
            else{
                NSDictionary *tempDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
                CGFloat fileSize = [tempDict fileSize]/1024.0;   //当前文件大小
                totalFilesSize += fileSize;
                [randomArray addObject:filePath];
            }
        }
        
        //拷贝任意类型的文件
        else if ([_fileType isEqualToString:@"all"]){
            NSDictionary *tempDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            CGFloat fileSize = [tempDict fileSize]/1024.0;   //当前文件大小
            totalFilesSize += fileSize;
            [randomArray addObject:filePath];
        }
    }
    
    return randomArray;
}

- (void)copyFilesToPath:(NSString *)toPath
{
    int judge = 1;
    printf("是否创建文件夹（1代表创建，其他代表不创建）:");
    scanf("%d",&judge);
    if (judge == 1) {
        int newFolderFilesCount = 0;
        int folderNumber = 1;
        NSString *newFolderPath;
        for (NSString *fileOriginPath in _mixFilesArr) {
            if (newFolderFilesCount == 0) {
                newFolderPath = [NSString stringWithFormat:@"%@/pica%d",toPath,folderNumber++];
                //创建文件夹
                NSFileManager *fileManager = [[NSFileManager alloc] init];
                [fileManager createDirectoryAtPath:newFolderPath
                       withIntermediateDirectories:NO
                                        attributes:nil
                                             error:nil];
            }
            NSString *newFileToPath = [[newFolderPath stringByAppendingString:@"/"] stringByAppendingString:fileOriginPath.lastPathComponent];
            
            [self copyFileWithOriginFilePath:fileOriginPath andNewFilePath:newFileToPath andNewFolderPath:newFolderPath];
            newFolderFilesCount++;
            if (newFolderFilesCount == 10) {
                newFolderFilesCount = 0;
            }
        }
    }
    
    else{
        for (NSString *fileOriginPath in _mixFilesArr) {
            NSString *newToPath = [[toPath stringByAppendingString:@"/"] stringByAppendingString:fileOriginPath.lastPathComponent];
            [self copyFileWithOriginFilePath:fileOriginPath andNewFilePath:newToPath andNewFolderPath:toPath];
        }
    }
}


- (void)copyFileWithOriginFilePath:(NSString *)originFilePath
                    andNewFilePath:(NSString *)newFilePath
                  andNewFolderPath:(NSString *)newFolderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([originFilePath.lastPathComponent hasPrefix:@".DS"]) {
        return;
    }
    // 文件是否存在
    BOOL isExists = [manager fileExistsAtPath:originFilePath];
    if (isExists){
        BOOL result = [manager copyItemAtPath:originFilePath toPath:newFilePath error:nil];
        if (!result) {
            newFilePath = [[[newFolderPath stringByAppendingString:@"/"] stringByAppendingString:@"cnm"] stringByAppendingString:originFilePath.lastPathComponent];
            [manager copyItemAtPath:originFilePath toPath:newFilePath error:nil];
        }
        [_resultFilesArr addObject:newFilePath];
        
        newFilePath = newFilePath.stringByDeletingPathExtension;
    }
}


@end
