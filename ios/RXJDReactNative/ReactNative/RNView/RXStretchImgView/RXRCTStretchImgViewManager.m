//
//  RXRCTStretchImgViewManager.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/15.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "RXRCTStretchImgViewManager.h"
#import "RXRCTStretchImgView.h"

@implementation RXRCTStretchImgViewManager

RCT_EXPORT_MODULE()
  
- (UIView *)view {
  return [[RXRCTStretchImgView alloc] init];
}


  
@end
