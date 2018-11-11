//
//  RNRootPage.h
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/20.
//  Copyright © 2018 srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNRootPage : NSObject
+ (UIViewController *)createNativeView:(NSDictionary *)launchOptions;
@end

NS_ASSUME_NONNULL_END
