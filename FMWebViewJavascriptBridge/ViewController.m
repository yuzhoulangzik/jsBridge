//
//  ViewController.m
//  ELMWebViewJavascripBridge
//
//  Created by sq on 15/9/1.
//  Copyright (c) 2015年 sq. All rights reserved.
//

#import "FMJavascriptBridge.h"
#import "FMWebViewManager.h"
#import "JavascripInterface.h"
#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) FMWebViewManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:self.webView];
  [FMJavascriptBridge enableLogging];
  _manager = [FMWebViewManager
      webViewManagerWithWebView:self.webView
                webViewDelegate:self
                         bridge:[[FMJavascriptBridge alloc]
                                    initWithResourceBundle:nil]];

  [_manager addJavascriptInterface:[[JavascripInterface alloc]
                                       initWithController:self]
                          withName:@"JavascripInterface"];

  [_manager fm_evaluateJavaScript:@"testJS()"
                completionHandler:^(id result, NSError *error) {
                  NSLog(@"js  ==== %@", result);
                }];

  [self loadExamplePage:self.webView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"webViewDidFinishLoad");
}

- (void)loadExamplePage:(UIWebView *)webView {
  NSString *htmlPath =
      [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"html"];
  NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath
                                                encoding:NSUTF8StringEncoding
                                                   error:nil];
  NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
  [webView loadHTMLString:appHtml baseURL:baseURL];
}
@end
