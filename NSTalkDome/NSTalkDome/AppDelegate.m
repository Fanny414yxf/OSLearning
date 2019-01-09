//
//  AppDelegate.m
//  NSTalkDome
//
//  Created by cximac on 2018/12/27.
//  Copyright © 2018 cximac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong) NSTask *task;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *APPPath = [NSString stringWithFormat:@"/Applications/TextEdit.app/Contents/MacOS/TextEdit"];
    
    //‎⁨Macintosh HD⁩ ▸ ⁨应用程序⁩ ▸ ⁨网易有道词典.app⁩ ▸ ⁨Contents⁩ ▸ ⁨MacOS⁩
//    _task = [[NSTask alloc] init];
//    [_task setLaunchPath:@"/Applications/TextEdit.app/Contents/MacOS/TextEdit"];
//    [_task launch];
    
    
    
    NSString *execPath = [[NSBundle mainBundle] executablePath];
    
    NSLog(@"execPath：%@",execPath);
    
    NSTask *task = [[NSTask alloc]init];
    [task setLaunchPath:execPath];
    
    NSArray *args = @[@"para0",@"para1",@"para2"];
    task.arguments = args;
    
    [task launch];
   
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (void)doingSomeOptions
{
    
}

@end
