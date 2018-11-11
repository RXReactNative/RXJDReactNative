//
//  RXRCTTextFieldManager.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import <RXExtenstion/RXExRXBlockTextField/RXBlockTextField.h>
#import "RXRCTTextFieldManager.h"
#import "RCTBaseTextInputShadowView.h"
#import <React/RCTAccessibilityManager.h>

#import "RCTConvert+RXRCTComment.h"

#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTFont.h>
#import <React/RCTShadowView+Layout.h>
#import <React/RCTShadowView.h>
#import <React/RCTUIManager.h>
#import <React/RCTUIManagerUtils.h>
#import <React/RCTUIManagerObserverCoordinator.h>


@interface RXRCTTextFieldManager()
{
  NSHashTable<RCTBaseTextInputShadowView *> *_shadowViews;
}
@end

@implementation RXRCTTextFieldManager
RCT_EXPORT_MODULE()
  
- (UIView *)view {
  return [[RXBlockTextField alloc] init];
}
  
//内部 textField 的初始化  property
RCT_EXPORT_VIEW_PROPERTY(textFieldNameType, RCTTextFieldNameType)
RCT_EXPORT_VIEW_PROPERTY(value, NSString)
RCT_EXPORT_VIEW_PROPERTY(multiValue, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(placeholder, NSString)
RCT_EXPORT_VIEW_PROPERTY(placeholderColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(placeholderFont, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(clearTextOnFocus, BOOL) //如果为true，每次开始输入的时候都会清除文本框的内容
RCT_EXPORT_VIEW_PROPERTY(keyboardType, UIKeyboardType)
RCT_EXPORT_VIEW_PROPERTY(returnKeyType, UIReturnKeyType)
RCT_EXPORT_VIEW_PROPERTY(secureTextEntry, BOOL)
RCT_EXPORT_VIEW_PROPERTY(clearButtonMode, UITextFieldViewMode)
RCT_EXPORT_VIEW_PROPERTY(selectionColor, UIColor)


/*
 style support
 
 【* not (in TextInput) *】style support list:
 1、allowFontScaling
 2、isHighlighted
 */
// Color
RCT_REMAP_SHADOW_PROPERTY(color, textAttributes.foregroundColor, UIColor)
RCT_REMAP_SHADOW_PROPERTY(backgroundColor, textAttributes.backgroundColor, UIColor)
RCT_REMAP_SHADOW_PROPERTY(opacity, textAttributes.opacity, CGFloat)
// Font( used `Font` contain as follows property)
RCT_REMAP_SHADOW_PROPERTY(fontFamily, textAttributes.fontFamily, NSString)
RCT_REMAP_SHADOW_PROPERTY(fontSize, textAttributes.fontSize, CGFloat)
RCT_REMAP_SHADOW_PROPERTY(fontWeight, textAttributes.fontWeight, NSString)
RCT_REMAP_SHADOW_PROPERTY(fontStyle, textAttributes.fontStyle, NSString)
RCT_REMAP_SHADOW_PROPERTY(fontVariant, textAttributes.fontVariant, NSArray)
RCT_REMAP_SHADOW_PROPERTY(letterSpacing, textAttributes.letterSpacing, CGFloat)
// Paragraph Styles
RCT_REMAP_SHADOW_PROPERTY(lineHeight, textAttributes.lineHeight, CGFloat)
RCT_REMAP_SHADOW_PROPERTY(textAlign, textAttributes.alignment, NSTextAlignment)
RCT_REMAP_SHADOW_PROPERTY(writingDirection, textAttributes.baseWritingDirection, NSWritingDirection)
// Decoration
RCT_REMAP_SHADOW_PROPERTY(textDecorationColor, textAttributes.textDecorationColor, UIColor)
RCT_REMAP_SHADOW_PROPERTY(textDecorationStyle, textAttributes.textDecorationStyle, NSUnderlineStyle)
RCT_REMAP_SHADOW_PROPERTY(textDecorationLine, textAttributes.textDecorationLine, RCTTextDecorationLineType)
// Shadow
RCT_REMAP_SHADOW_PROPERTY(textShadowOffset, textAttributes.textShadowOffset, CGSize)
RCT_REMAP_SHADOW_PROPERTY(textShadowRadius, textAttributes.textShadowRadius, CGFloat)
RCT_REMAP_SHADOW_PROPERTY(textShadowColor, textAttributes.textShadowColor, UIColor)



//function
RCT_EXPORT_VIEW_PROPERTY(onFieldFocus, RCTDirectEventBlock)         //获取焦点
RCT_EXPORT_VIEW_PROPERTY(onFieldBlur, RCTDirectEventBlock)          //失去焦点
RCT_EXPORT_VIEW_PROPERTY(onFieldChangeText, RCTDirectEventBlock)    //文本框内容变化时
RCT_EXPORT_VIEW_PROPERTY(onFieldEndEditing, RCTDirectEventBlock)    //输入结束
RCT_EXPORT_VIEW_PROPERTY(onFieldSubmitEditing, RCTDirectEventBlock) //软键盘的确定/提交按钮被按下
  
  
- (RCTShadowView *)shadowView {
  RCTBaseTextInputShadowView *shadowView = [[RCTBaseTextInputShadowView alloc] initWithBridge:self.bridge];
  shadowView.textAttributes.fontSizeMultiplier = self.bridge.accessibilityManager.multiplier;
  [_shadowViews addObject:shadowView];
  return shadowView;
}
  
#pragma mark -  get style
  
- (void)setBridge:(RCTBridge *)bridge {
  [super setBridge:bridge];
  
  _shadowViews = [NSHashTable weakObjectsHashTable];
  
  [bridge.uiManager.observerCoordinator addObserver:self];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleDidUpdateMultiplierNotification)
                                               name:RCTAccessibilityManagerDidUpdateMultiplierNotification
                                             object:bridge.accessibilityManager];
}
  
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
  
  
  //#pragma mark - RCTUIManagerObserver
  
- (void)uiManagerWillPerformMounting:(__unused RCTUIManager *)uiManager {
  for (RCTBaseTextInputShadowView *shadowView in _shadowViews) {
    [shadowView uiManagerWillPerformMounting];
  }
}
  
  //#pragma mark - Font Size Multiplier
  
- (void)handleDidUpdateMultiplierNotification {
  CGFloat fontSizeMultiplier = self.bridge.accessibilityManager.multiplier;
  
  NSHashTable<RCTBaseTextInputShadowView *> *shadowViews = _shadowViews;
  RCTExecuteOnUIManagerQueue(^{
    for (RCTBaseTextInputShadowView *shadowView in shadowViews) {
      shadowView.textAttributes.fontSizeMultiplier = fontSizeMultiplier;
      [shadowView dirtyLayout];
    }
    
    [self.bridge.uiManager setNeedsLayout];
  });
}

@end
