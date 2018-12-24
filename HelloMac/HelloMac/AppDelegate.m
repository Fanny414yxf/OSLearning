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
    NSTask *certTask;
    NSTask *unzipTask;
    NSMutableArray *certComboBoxItems;
}

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
    
    NSString * workingPath = NSTemporaryDirectory() ;

    NSString * entitlementsDirPath = [workingPath stringByAppendingString:@"-entitlements"];

    if ([_certComtoBox objectValues]) {
        if ([[[[_ipaNameTextField stringValue] pathExtension] lowercaseString] isEqualToString:@"ipa"] || [[[[_ipaNameTextField stringValue] pathExtension] lowercaseString] isEqualToString:@"xcarchive"]) {

            
            [[NSFileManager defaultManager] removeItemAtPath:workingPath error:nil];
            [[NSFileManager defaultManager] createDirectoryAtPath:workingPath withIntermediateDirectories:TRUE attributes:nil error:nil];
            [[NSFileManager defaultManager] removeItemAtPath:entitlementsDirPath error:nil];
            [[NSFileManager defaultManager] createDirectoryAtPath:entitlementsDirPath withIntermediateDirectories:TRUE attributes:nil error:nil];
            
            unzipTask = [[NSTask alloc] init];
            [unzipTask setLaunchPath:@"/usr/bin/unzip"];
            [unzipTask setArguments:[NSArray arrayWithObjects:@"-q", [_ipaNameTextField stringValue], @"-d", workingPath, nil]];
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkUnzip:) userInfo:nil repeats:TRUE];
            
            [unzipTask launch];
        }
    }
    
}




- (void)checkUnzip:(NSTimer *)timer
{
    
}

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
