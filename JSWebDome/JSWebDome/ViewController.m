//
//  ViewController.m
//  JSWebDome
//
//  Created by cximac on 2019/2/13.
//  Copyright © 2019 cximac. All rights reserved.
//

#import "ViewController.h"
#import "JSContextVCViewController.h"
#import "JSWKWebkitViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *vcarray;
}
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"fanny";
    self.navigationItem.backBarButtonItem.title = @"返回";
    
    JSContextVCViewController *jscontextvc = [[JSContextVCViewController alloc] init];
    vcarray = [[NSMutableArray alloc] init];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *identfer =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identfer];
    }
    cell.textLabel.textColor = [UIColor orangeColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"JSWebView";
    }else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"JSBridge";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSContextVCViewController *jscontextVC;
    JSWKWebkitViewController *jsbridgeVC;
    if (indexPath.row == 0) {
        jscontextVC = [[JSContextVCViewController alloc] init];
        [self.navigationController pushViewController:jscontextVC animated:YES];
    }else if (indexPath.row == 1){
        jsbridgeVC = [[JSWKWebkitViewController alloc] init];
        [self.navigationController pushViewController:jsbridgeVC animated:YES];
    }
    
    
}

@end
