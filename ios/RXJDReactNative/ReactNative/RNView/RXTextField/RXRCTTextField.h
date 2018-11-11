//
//  RXRCTTextField.h
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import <React/RCTView.h>
#import <React/UIView+React.h>
#import "RCTBackedTextInputViewProtocol.h"

@class RCTTextAttributes;

@interface RXRCTTextField : RCTView
@property (nonatomic, strong) RCTTextAttributes *textAttributes;
@property (nonatomic, readonly) UIView<RCTBackedTextInputViewProtocol> *backedTextInputView;
@end

