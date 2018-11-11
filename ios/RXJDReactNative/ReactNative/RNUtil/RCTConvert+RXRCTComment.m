//
//  RCTConvert+RXRCTComment.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "RCTConvert+RXRCTComment.h"

@implementation RCTConvert (RXRCTComment)
RCT_ENUM_CONVERTER(RCTTextFieldNameType, (@{
@"default" : @(RCTTextFieldDefault),
@"currency": @(RCTTextFieldCurrency),
@"phoneNum": @(RCTTextFieldPhoneNum),
@"bankCard": @(RCTTextFieldBankCard),
}), RCTTextFieldDefault, integerValue)
  

@end
