//
//  RCTConvert+RXRCTComment.h
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//


#import <React/RCTConvert.h>

NS_ASSUME_NONNULL_BEGIN

//输入框 样式
typedef NS_ENUM(NSInteger, RCTTextFieldNameType) {
  RCTTextFieldDefault = 0,
  RCTTextFieldCurrency,
  RCTTextFieldPhoneNum,
  RCTTextFieldBankCard,
};
  
  
@interface RCTConvert (RXRCTComment)
+ (RCTTextFieldNameType)RCTTextFieldNameType:(id)json;
@end

NS_ASSUME_NONNULL_END
