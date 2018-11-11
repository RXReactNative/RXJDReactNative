//
//  RXRCTRefreshControl.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//


#import "RXRCTRefreshControl.h"

@interface RXRCTRefreshControl()
@property(nonatomic, weak) UIScrollView * scrollView;
  
@property(nonatomic, assign) BOOL refreshing;
@property(nonatomic, assign) CGFloat contentOffsetY;
  
// RN CallBack
@property (nonatomic, copy) RCTDirectEventBlock onBeginRefresh;
@property (nonatomic, copy) RCTDirectEventBlock onEndRefresh;
@end

@implementation RXRCTRefreshControl
  
- (instancetype)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}
  
RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)
  
- (void)layoutSubviews {
  [super layoutSubviews];
}
  
- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  //this = RCTScrollContentView
  
  //this = RCTCustomself.scrollView
  newSuperview = newSuperview.superview;
  
  if (newSuperview) {
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
      self.scrollView = (UIScrollView *)newSuperview;
      //不可对 scrollView 添加代理、监听，RN已经全全在写了，否会影响RN (iPhone5 崩溃)
    }
  }
}
  
- (void)setRefreshing:(BOOL)refreshing {
  _refreshing = refreshing;
}
  
- (void)setContentOffsetY:(CGFloat)contentOffsetY {
  _contentOffsetY = contentOffsetY;
}
  
@end
