//
//  ViewController.m
//  CXCrashDome
//
//  Created by johnson on 2019/9/29.
//  Copyright © 2019年 johnson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self doingSomethingToCrash];
}



- (void)doingSomethingToCrash
{

//    NSArray *arr = [NSArray new];
//    NSLog(@"----%@", [arr objectAtIndex:5]);
    
    
    NSArray *arr4 = @[@"111", @"444", @"222"];
    NSLog(@"----%@", [arr4 objectAtIndex:6]);
    

    NSDictionary * dicTemp1 = [NSDictionary new];
    NSArray *aryObj = dicTemp1[nil];
    NSLog(@"aryObj[I]---%@", aryObj[1]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
