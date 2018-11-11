//
//  RNRootPage.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/20.
//  Copyright © 2018 srxboys. All rights reserved.
//

#import "RNRootPage.h"
#import <React/RCTBundleURLProvider.h>

@interface RNRootPage ()

@end

@implementation RNRootPage

+ (UIViewController *)createNativeView:(NSDictionary *)launchOptions {
  // 在真机的情况下
  // 设置加载服务器 (you mac network `ip` + mac chrome input:`http://192.20.12.128:8081/debugger-ui/`)
  //    [[RCTBundleURLProvider sharedSettings] setJsLocation:@"172.20.12.128"];
  
  NSURL *jsCodeLocation = nil;
  
  /*
    1 本地    http://localhost:8081/debugger-ui/
             `Allow Arbitrary Loads` ==>  YES
   
   */
  jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios&dev=true"];
  
  //    jsCodeLocation = [NSURL URLWithString:@"http://192.20.12.128:8081/index.ios.bundle?platform=ios"]; //ip
  
  //2 离线包
//      jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForFallbackResource:nil fallbackExtension:nil];
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"RXJD"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  
  UIViewController * c = [[UIViewController alloc] init];
  c.view = rootView;
  return c;
}

@end

