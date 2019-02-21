//
//  JSWKWebkitViewController.m
//  JSWebDome
//
//  Created by cximac on 2019/2/19.
//  Copyright © 2019 cximac. All rights reserved.
//

#import "JSWKWebkitViewController.h"
#import "Masonry.h"
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"

@interface JSWKWebkitViewController ()<WKNavigationDelegate, WKUIDelegate>
    @property (nonatomic, strong)WKWebView *webView;
    @property (nonatomic, strong)UIButton *buttonA;
    @property (nonatomic, strong)UIButton *buttonB;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation JSWKWebkitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"JSBridge";
    
    [self setupUI];
    [self setupJSBridge];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"jsbridge" ofType:@"html"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

}
    
- (void)setupUI {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView *origin = [[UIView alloc] init];
    origin.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:origin];
    [origin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor redColor];
    [origin addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).with.offset(8);
        make.right.equalTo(self.view).with.offset(-8);
    }];
    titleLabel.text = @"原生区域";
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.backgroundColor = [UIColor grayColor];
    [btn1 setTitle:@"按钮1" forState:UIControlStateNormal];
    [origin addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(origin).with.offset(8);
        make.left.equalTo(origin).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    self.buttonA = btn1;
    
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.backgroundColor = [UIColor grayColor];
    [btn2 setTitle:@"按钮2" forState:UIControlStateNormal];
    [origin addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn1);
        make.left.equalTo(btn1.mas_right).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    self.buttonB = btn2;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:[[WKWebViewConfiguration alloc] init]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(origin.mas_bottom).with.offset(1);
    }];
}

- (void)setupJSBridge
{
    if (self.bridge) return;
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [self.bridge registerHandler:@"getOS" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *response = @{@"error": @(0), @"message": @"", @"data": @{@"os": @"ios"}};
        responseCallback([self jsonString:response]);
    }];
    
    
    [self.bridge registerHandler:@"login" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (data == nil || ![data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = @{@"error": @(-1), @"message": @"调用参数有误"};
            responseCallback([self jsonString:response]);
            return;
        }
        
        NSString *account = data[@"account"];
        NSString *passwd = data[@"password"];
        NSDictionary *response = @{@"error": @(0), @"message": @"登录成功", @"data" : [NSString stringWithFormat:@"执行登录操作，账号为：%@、密码为：@%@", account, passwd]};
        responseCallback([self jsonString:response]);
    }];
}
    
- (void)btn1Click {
    
    [self.bridge callHandler:@"jsbridge_showMessage" data:@"点击原生button1" responseCallback:nil];
    
    }
    
- (void)btn2Click {
    
    [self.bridge callHandler:@"jsbridge_getJsMessage" data:@"点击了原生的按钮222222222" responseCallback:^(id responseData) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"显示jsbridge返回值" message:responseData delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }];
}





- (NSString *)jsonString:(NSDictionary *)data
{
    NSError *error;
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    if (error) return nil;
    
    return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
