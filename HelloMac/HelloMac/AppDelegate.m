//
//  AppDelegate.m
//  HelloMac
//
//  Created by cximac on 2018/12/24.
//  Copyright © 2018 cximac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSComboBoxDataSource, NSComboBoxDelegate>
{
    
    NSString * _newBundleId;
    NSString *appPath;
    NSString * workingPath;
    NSString * entitlementsDirPath;
    
    NSTask *certTask;
    NSTask *unzipTask;
    NSTask *provisioningTask;
    NSMutableArray *certComboBoxItems;
}

/**
 command + option + /
 */
@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *ipaNameTextField;
@property (weak) IBOutlet NSTextField *mobileprovisionTextField;
@property (weak) IBOutlet NSTextField *plistTextField;
@property (weak) IBOutlet NSTextField *dylibTextField;
@property (weak) IBOutlet NSTextField *bundleTextField;
@property (weak) IBOutlet NSTextField *appNameTextField;
@property (weak) IBOutlet NSButton *ipaBtn;
@property (weak) IBOutlet NSButton *mobileprovisionBtn;
@property (weak) IBOutlet NSButton *plistBtn;
@property (weak) IBOutlet NSButton *signingCertificateBtn;
@property (weak) IBOutlet NSComboBox *certComtoBox;
@property (weak) IBOutlet NSButton *bundleIDCheckBtn;
@property (weak) IBOutlet NSButton *appNameCheckBtn;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    //从钥匙串获取证书
    [self getSigingCertificates];
    
    
    
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



//重签
- (IBAction)resignBtn:(id)sender {
    
    workingPath = NSTemporaryDirectory() ;

    entitlementsDirPath = [workingPath stringByAppendingString:@"-entitlements"];

    NSString *sourcePath = [_ipaNameTextField stringValue];
    if ([_certComtoBox objectValues]) {
        if ([[[sourcePath pathExtension] lowercaseString] isEqualToString:@"ipa"] || [[[sourcePath  pathExtension] lowercaseString] isEqualToString:@"xcarchive"]) {

            
            [[NSFileManager defaultManager] removeItemAtPath:workingPath error:nil];
            [[NSFileManager defaultManager] createDirectoryAtPath:workingPath withIntermediateDirectories:TRUE attributes:nil error:nil];
            [[NSFileManager defaultManager] removeItemAtPath:entitlementsDirPath error:nil];
            [[NSFileManager defaultManager] createDirectoryAtPath:entitlementsDirPath withIntermediateDirectories:TRUE attributes:nil error:nil];
            
            if ([[[sourcePath pathExtension]  lowercaseString] isEqualToString:@"ipa"]) {
                //解压
                unzipTask = [[NSTask alloc] init];
                [unzipTask setLaunchPath:@"/usr/bin/unzip"];
                [unzipTask setArguments:[NSArray arrayWithObjects:@"-q", [_ipaNameTextField stringValue], @"-d", workingPath, nil]];
                
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkUnzip:) userInfo:nil repeats:TRUE];
                
                [unzipTask launch];
            }else{
                
            }
            
        }
    }
    
}


- (void)checkUnzip:(NSTimer *)timer
{
    if ([unzipTask isRunning] == 0) {
        [timer invalidate];
        unzipTask = nil;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[workingPath stringByAppendingPathComponent:@"Payload"]]) {
            [self checkDylibFile];
            
            [self checkAllCheckBoxes];
        }else{
            NSLog(@"解压失败");
        }
    }
}



- (void)checkAllCheckBoxes
{
    if ([[_mobileprovisionBtn stringValue] isEqualToString:@""]) {
    
    }else{
        [self doProvisioning];
    }
    
}


- (void)doProvisioning
{
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[workingPath stringByAppendingPathComponent:@"Payload"] error:nil];
    for (NSString *file in dirContents) {
        if ([[[file pathExtension] lowercaseString] isEqualToString:@"app"]) {
            appPath = [[workingPath stringByAppendingPathComponent:@"Payload"] stringByAppendingPathComponent:file];
            if ([[NSFileManager defaultManager] fileExistsAtPath: [appPath stringByAppendingPathComponent:@"embedded.mobileprovision"]]) {
                [[NSFileManager defaultManager] removeItemAtPath:[appPath stringByAppendingPathComponent:@"embedded.mobileprovision"] error:nil];
            }
            break;
        }
    }
    
    NSString * targetPath = [appPath stringByAppendingPathComponent:@"embedded.mobileprovision"];
    provisioningTask = [[NSTask alloc] init];
    [provisioningTask setLaunchPath:@"/bin/cp"];
    [provisioningTask setArguments:[NSArray arrayWithObjects:[_mobileprovisionTextField stringValue], targetPath, nil]];
    [provisioningTask launch];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkProvisioning:) userInfo:nil repeats:TRUE];
    
}

- (void)checkProvisioning:(NSTimer *)timer
{
    if ([provisioningTask isRunning]) {
        [timer invalidate];
        provisioningTask = nil;
        
        NSArray *dircontents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[workingPath stringByAppendingPathComponent:@"Payload"] error:nil];
        
        
    }
}


#pragma mark ---- dylib
- (void)checkDylibFile
{
    if (_dylibTextField.stringValue.length == 0) {
        return;
    }else{
        //stringByAppendingPathComponent： 添加/,  workingPath/Payload
         NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[workingPath stringByAppendingPathComponent:@"Payload"] error:nil];
        NSString *infoPlistPath = nil;
        NSString *appFolderPath = nil;
        for (NSString *file in dirContents) {
            if ([[[file pathExtension] lowercaseString] isEqualToString:@"app"]) {
                appFolderPath = [[workingPath stringByAppendingPathComponent:@"Payload"] stringByAppendingPathComponent:file];
                infoPlistPath = [appFolderPath stringByAppendingPathComponent:@"info.plist"];
                break;
            }
        }
        
        NSString * frameworkfolderPath = [appFolderPath stringByAppendingPathComponent:@"Frameworks"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:frameworkfolderPath]) {
            [[NSFileManager defaultManager]  createDirectoryAtPath:frameworkfolderPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        if ([[NSFileManager defaultManager] fileExistsAtPath:_dylibTextField.stringValue]) {
            NSString *dest = [frameworkfolderPath stringByAppendingPathComponent:_dylibTextField.stringValue.lastPathComponent];
            NSError *erro = nil;
            [[NSFileManager defaultManager] copyItemAtPath:_dylibTextField.stringValue toPath:dest error:&erro];
            
            NSDictionary * infoPlistDic = [NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
            NSString *binaryName = infoPlistDic[@"CFBundleExecutable"];
            NSString *binaryPath = [appFolderPath stringByAppendingPathComponent:binaryName];
            NSString *dylibRelativePath = [@"Frameworks" stringByAppendingPathComponent:_dylibTextField.stringValue.lastPathComponent];
            
            [self injectDylibToBinaryBinaryPath:binaryPath dylibPath:dylibRelativePath];
        }
    }
}


void code(NSString *b, NSString *B)
{
    
}
- (void)injectDylibToBinaryBinaryPath:(NSString *)binry dylibPath:(NSString *)dylibPath
{
    
}




#pragma mark -----  获取证书
- (void)getSigingCertificates
{
    
    _certComtoBox.usesDataSource = YES;
    _certComtoBox.dataSource = self;
    _certComtoBox.delegate = self;
    [_certComtoBox addItemsWithObjectValues:certComboBoxItems];
    
    
    certTask = [[NSTask alloc] init];
    [certTask setLaunchPath:@"/usr/bin/security"];
    [certTask setArguments:[NSArray arrayWithObjects:@"find-identity", @"-v", @"-p", @"codesigning", nil]];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkCerts:) userInfo:nil repeats:TRUE];
    NSPipe *pipe = [NSPipe pipe];
    [certTask setStandardOutput:pipe];
    [certTask setStandardError:pipe];
    NSFileHandle *handle = [pipe fileHandleForReading];
    [certTask launch];
    
    [NSThread detachNewThreadSelector:@selector(watchGetCerts:) toTarget:self withObject:handle];
}



- (void)checkCerts:(NSTimer *)timer
{
    if ([certTask isRunning] == 0) {
        [timer invalidate];
        certTask = nil;
        
        
        //        [_certComtoBox setObjectValue:selectedItem];
        //        [_certComtoBox selectItemAtIndex:selectedIndex];
    }
}

- (void)watchGetCerts:(NSFileHandle *)fileHandle
{
    @autoreleasepool {
        NSString *securityResult = [[NSString alloc] initWithData:[fileHandle readDataToEndOfFile] encoding:NSASCIIStringEncoding];
        if (securityResult == nil || securityResult.length < 1) {
            return;
        }
        NSArray *rawResult = [securityResult componentsSeparatedByString:@"\""];
        NSMutableArray *tempGetCertsResult = [NSMutableArray arrayWithCapacity:20];
        for (int i = 0; i <= [rawResult count] - 2; i+=2) {
            
            NSLog(@"i:%d", i+1);
            if (rawResult.count - 1 < i + 1) {
                // Invalid array, don't add an object to that position
            } else {
                // Valid object
                [tempGetCertsResult addObject:[rawResult objectAtIndex:i+1]];
            }
        }
        certComboBoxItems = [NSMutableArray arrayWithArray:tempGetCertsResult];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.certComtoBox reloadData];
            NSLog(@"cercomtobox  reloadate");
        });
    }
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    NSInteger count = 0;
    if ([aComboBox isEqual:_certComtoBox]) {
        count = [certComboBoxItems count];
    }
    return count;
}
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    id item = nil;
    if ([aComboBox isEqual:_certComtoBox]) {
        item = [certComboBoxItems objectAtIndex:index];
    }
    return item;
}


#pragma mark -- clicks
- (IBAction)ipaNameBrowse:(id)sender {
    
    NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
    //设置是否解析别名
    [openPanel setResolvesAliases:NO];
    //设置是否允许选择文件
    [openPanel setCanChooseFiles:YES];
    //设置是否允许选择文件夹
    [openPanel setCanChooseDirectories:NO];
    //设置是否允许多选
    [openPanel setAllowsMultipleSelection:NO];
    //s设置是否允许选择其他文件类型
    [openPanel setAllowsOtherFileTypes:NO];
    //设置选择文件类型
    [openPanel setAllowedFileTypes:@[@"ipa", @"IPA", @"xcarchive"]];
    //    NSInteger result = [openPanel runModal];
    if ([openPanel runModal] == NSOKButton) {
        
        NSString* fileNameOpened = [[[openPanel URLs] objectAtIndex:0] path];
        [self.ipaNameTextField setStringValue:fileNameOpened];
        NSLog(@"ipa path----------%@", fileNameOpened);
    }
}

- (IBAction)mobileprovisionBrowse:(id)sender {
    NSOpenPanel *openPanel  = [[NSOpenPanel alloc] init];
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setAllowsOtherFileTypes:NO];
    [openPanel setAllowedFileTypes:@[@"mobileprovision", @"MOBILEPROVISION"]];
    if ([openPanel runModal]) {
        NSString * fileNameOpened = [[[openPanel URLs] objectAtIndex:0] path];
        [self.mobileprovisionTextField setStringValue:fileNameOpened];
    }
}
- (IBAction)plistBrowse:(id)sender {
    
    NSOpenPanel *openPanel  = [[NSOpenPanel alloc] init];
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setAllowsOtherFileTypes:NO];
    [openPanel setAllowedFileTypes:@[@"plist", @"PLIST"]];
    if ([openPanel runModal]) {
        NSString * fileNameOpened = [[[openPanel URLs] objectAtIndex:0] path];
        [self.plistTextField setStringValue:fileNameOpened];
    }
}
- (IBAction)dylibBrowse:(id)sender {
    NSOpenPanel *openPanel  = [[NSOpenPanel alloc] init];
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setAllowsOtherFileTypes:NO];
    [openPanel setAllowedFileTypes:@[@"mobileprovision", @"MOBILEPROVISION"]];
    if ([openPanel runModal]) {
        NSString * fileNameOpened = [[[openPanel URLs] objectAtIndex:0] path];
        [self.dylibTextField setStringValue:fileNameOpened];
    }
}





@end
