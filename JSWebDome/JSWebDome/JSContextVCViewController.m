//
//  JSContextVCViewController.m
//  JSWebDome
//
//  Created by cximac on 2019/2/16.
//  Copyright © 2019 cximac. All rights reserved.
//

#import "JSContextVCViewController.h"
#import "Masonry.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSContextModel.h"


@interface JSContextVCViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)UIButton *buttonA;
@property (nonatomic, strong)UIButton *buttonB;

@property (nonatomic,strong)JSContext *jscontext;
    
    
@end

@implementation JSContextVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"JSWebView";
    
    [self setupUserInterface];
    
//     NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"intercept" ofType:@"html"]];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"jscontext" ofType:@"html"]];
    


    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
}

- (void)setupUserInterface
{
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
    [btn1 setTitle:@"按钮A" forState:UIControlStateNormal];
    [origin addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(origin).with.offset(8);
        make.left.equalTo(origin).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [btn1 addTarget:self action:@selector(btnAClick) forControlEvents:UIControlEventTouchUpInside];
    self.buttonA = btn1;
    
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.backgroundColor = [UIColor grayColor];
    [btn2 setTitle:@"按钮B" forState:UIControlStateNormal];
    [origin addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn1);
        make.left.equalTo(btn1.mas_right).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [btn2 addTarget:self action:@selector(btnBClick) forControlEvents:UIControlEventTouchUpInside];
    self.buttonB = btn2;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.webView = [[UIWebView alloc] init];
    
    self.webView.backgroundColor = [UIColor yellowColor];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(origin.mas_bottom).with.offset(1);
    }];
    
}


- (void)btnAClick {
    
    NSLog(@"button A clich");
    
    [self.jscontext evaluateScript:@"showResponse('点击了按钮1111111111111111')"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"showResponse('点击点击点击')"];
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"AAA" message:@"🙂" delegate:self cancelButtonTitle:@"HAO" otherButtonTitles:nil, nil];
//    [alert show];
    
    
    
}

- (void)btnBClick {
    
    NSLog(@"button B clich");
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"BBB" message:@"🙂" delegate:self cancelButtonTitle:@"HOA" otherButtonTitles:nil, nil];
//    [alert show];
    
    JSValue *value = self.jscontext[@"showResponse"];
    [value callWithArguments:@[@"点击了按钮222222222"]];
    
    
}



#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jscontext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jscontext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
         NSLog(@"异常信息：%@", exception);
    };
    self.jscontext[@"app"] = [[JSContextModel alloc] init];

}
    

    
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
    {
        NSString *scheme = request.URL.scheme;
        NSString *host = request.URL.host;
        
        if ([scheme isEqualToString:@"app"]) {
            if ([host isEqualToString:@"login"]) {
                NSDictionary *paramsDic = [self getUrlParams:request.URL];
                NSString *account = paramsDic[@"account"];
                NSString *password = paramsDic[@"password"];
                
                NSString *msg = [NSString stringWithFormat:@"执行登录操作，账号为：%@，密码为：%@", account, password];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"原生弹窗" message:msg delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
                
            }else if ([host isEqualToString:@"share"]){
                
                NSDictionary *paramsDic = [self getUrlParams:request.URL];
                NSString *title = [paramsDic[@"title"] stringByRemovingPercentEncoding];
                NSString *decs = [paramsDic[@"desc"] stringByRemovingPercentEncoding];
                NSString *msg = [NSString stringWithFormat:@"执行分享操作，标题L：%@， 内容：%@", title, decs];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"(｡･∀･)ﾉﾞ嗨" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
                
           }
        
            return  NO;
           
       }
        return YES;
        
    }
    
    
    - (NSDictionary *)getUrlParams:(NSURL *)url
    {
        NSString *queryString = url.query;
        NSArray *paramsArr = [queryString componentsSeparatedByString:@"&"];
        NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
        
        for (NSString *item in paramsArr) {
            NSArray *keyvalue = [item componentsSeparatedByString:@"="];
            if (keyvalue.count == 2) {
                paramsDic[keyvalue[0]] = keyvalue[1];
            }
        }
        return [NSDictionary dictionaryWithDictionary:paramsDic];
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
