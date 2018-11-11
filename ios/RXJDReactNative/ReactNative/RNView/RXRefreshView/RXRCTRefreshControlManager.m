//
//  RXRCTRefreshControlManager.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "RXRCTRefreshControlManager.h"
#import "RXRCTRefreshControl.h"

@implementation RXRCTRefreshControlManager

RCT_EXPORT_MODULE()
  
- (UIView *)view
{
  return [[RXRCTRefreshControl alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(refreshing, BOOL)
RCT_EXPORT_VIEW_PROPERTY(contentOffsetY, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(onBeginRefresh, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onEndRefresh, RCTDirectEventBlock)
  

@end
