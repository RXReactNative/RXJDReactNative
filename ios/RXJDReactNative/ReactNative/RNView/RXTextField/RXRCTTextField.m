//
//  RXRCTTextField.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "RXRCTTextField.h"
#import <RXExtenstion/RXExRXBlockTextField/RXBlockTextField.h>
#import <RXExtenstion/RXExRXBlockTextField/RXBankCardFormatTextField.h>
#import <RXExtenstion/RXExRXBlockTextField/RXCurrencyFormatTextField.h>
#import <RXExtenstion/RXExRXBlockTextField/RXPhoneNumberFormatTextField.h>


#import "RCTTextAttributes.h"

#import "RCTConvert+RXRCTComment.h"
#import <objc/message.h>

@interface RXRCTTextField()
@property (nonatomic, strong) RXBlockTextField * textInpuField;
@property(nonatomic, strong) RXBlockTextFieldHandler* handler;

//--------------------------------------------------------------
@property (nonatomic, assign) RCTTextFieldNameType textFieldNameType;
@property (nonatomic, assign) UIEdgeInsets reactPaddingInsets;
@property (nonatomic, assign) UIEdgeInsets reactBorderInsets;
@property (nonatomic, copy) NSAttributedString *attributedText;

@property (nonatomic, copy) NSString * value;
@property (nonatomic, strong) NSDictionary * multiValue;
@property (nonatomic, copy) NSString * placeholder;
@property (nonatomic, strong) UIColor * placeholderColor;
@property (nonatomic, assign) CGFloat placeholderFont;
@property (nonatomic, assign) BOOL clearTextOnFocus;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UIReturnKeyType returnKeyType;
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;
@property (nonatomic, strong) UIColor *selectionColor;

@property (nonatomic, copy) RCTDirectEventBlock onFieldFocus;
@property (nonatomic, copy) RCTDirectEventBlock onFieldBlur;
@property (nonatomic, copy) RCTDirectEventBlock onFieldChangeText;
@property (nonatomic, copy) RCTDirectEventBlock onFieldEndEditing;
@property (nonatomic, copy) RCTDirectEventBlock onFieldSubmitEditing;
@end

@implementation RXRCTTextField

- (void)layoutSubviews {
  [super layoutSubviews];
  if(_textInpuField) {
    _textInpuField.frame = self.bounds;
    _textInpuField.userInteractionEnabled = NO;
  }
}
  
- (instancetype)init {
  self = [super init];
  if (self) {
    _textInpuField = [[RXBlockTextField alloc] initWithFrame:CGRectZero];
    _handler = _textInpuField.handler;
    [self addSubview:_textInpuField];
  }
  return self;
}
  
#pragma mark - support RCTTextAttributes -> (style[color / fontSize ....])
- (NSAttributedString *)attributedText {
  return self.backedTextInputView.attributedText;
}
  
- (void)setAttributedText:(NSAttributedString *)attributedText {
  
}
  
- (void)setTextAttributes:(RCTTextAttributes *)textAttributes {
  _textAttributes = textAttributes;
  [self enforceTextAttributesIfNeeded];
}
  
- (void)enforceTextAttributesIfNeeded {
  id<RCTBackedTextInputViewProtocol> backedTextInputView = self.backedTextInputView;
  if (backedTextInputView.attributedText.string.length != 0) {
    return;
  }
  
  [self setFieldOfTextAttributes];
}
  
- (void)setReactPaddingInsets:(UIEdgeInsets)reactPaddingInsets {
  _reactPaddingInsets = reactPaddingInsets;
  // We apply `paddingInsets` as `backedTextInputView`'s `textContainerInset`.
  self.backedTextInputView.textContainerInset = reactPaddingInsets;
  
  [self setFieldOFReactPaddingInsets];
  [self setNeedsLayout];
}
  
- (void)setReactBorderInsets:(UIEdgeInsets)reactBorderInsets {
  _reactBorderInsets = reactBorderInsets;
  // We apply `borderInsets` as `backedTextInputView` layout offset.
  self.backedTextInputView.frame = UIEdgeInsetsInsetRect(self.bounds, reactBorderInsets);
  [self setFieldOFReactBorderInsets];
  [self setNeedsLayout];
}
  
  
  
  
#pragma mark - propertys
  
RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)
  
- (void)setTextFieldNameType:(RCTTextFieldNameType)textFieldNameType {
  _textFieldNameType = textFieldNameType;
  
  Class nameClass = [RXBlockTextField class];;
  if(textFieldNameType == RCTTextFieldCurrency) {
    nameClass = [RXCurrencyFormatTextField class];
  }
  else if(textFieldNameType == RCTTextFieldPhoneNum) {
    nameClass = [RXPhoneNumberFormatTextField class];
  }
  else if(textFieldNameType == RCTTextFieldBankCard) {
    nameClass = [RXBankCardFormatTextField class];
  }
  
  if(_textInpuField) {
    if(![_textInpuField isMemberOfClass:nameClass]) {
      [self removeTextField];
      _textInpuField = [[nameClass alloc] initWithFrame:self.bounds];
      _textInpuField.userInteractionEnabled = NO;
      _handler = _textInpuField.handler;
      [self addSubview:_textInpuField];
      
      if(textFieldNameType == RCTTextFieldCurrency) {
        _handler = ((RXCurrencyFormatTextField *)_textInpuField).currencyHandler;
        ((RXCurrencyFormatTextField *)_textInpuField).placeholderFont = [UIFont systemFontOfSize:16]; //不设置不显示
      }
      else if(textFieldNameType == RCTTextFieldPhoneNum) {
        _handler = ((RXPhoneNumberFormatTextField *)_textInpuField).phoneNumberHandler;
      }
      else if(textFieldNameType == RCTTextFieldBankCard) {
        _handler = ((RXBankCardFormatTextField *)_textInpuField).bankCardHandler;
      }
    }
  }
  [self configTextField];
  
  __weak typeof(self)weakSelf = self;
  __block typeof(_value)weak_value = _value; //如果_textInpuField 变Class, 会重新复制给_textInpuField
  _handler.textFieldShouldBeginEditingBlock = ^BOOL(UITextField *textField) {
    if(weakSelf.onFieldFocus){
      weakSelf.onFieldFocus(nil);
    }
    SEL React_onfocus_sel = NSSelectorFromString(@"setReactIsFocusNeeded:");
    if([textField respondsToSelector:React_onfocus_sel]) {
      [textField setValue:@(YES) forKey:@"reactIsFocusNeeded"];
    }
    return YES;
  };
  
  _handler.textFieldShouldChangeCharactersInRangeReplacementStringBlock = ^BOOL(UITextField *textField, NSRange range, NSString *string) {
    
    NSString * text = @"";
    if(string.length == 0) {
      if(textField.text.length > 1) {
        text = [textField.text substringToIndex:textField.text.length - 1];
      }
    }
    else{
      if(textField.text) {
        if(textField.text.length > 0) {
          text = textField.text;
        }
      }
      if(string.length) {
        if(string.length > 0) {  text = [text stringByAppendingString:string];  }
      }
    }
    weak_value = text;
    if(weakSelf.onFieldChangeText){
      weakSelf.onFieldChangeText(@{@"text":text});
    }
    return YES;
  };
  
  _handler.textFieldShouldEndEditingBlock = ^BOOL(UITextField *textField) {
    if(weakSelf.onFieldEndEditing){
      NSString * text = @"";
      if(textField.text) {
        if(textField.text.length > 0) {  text = textField.text; }
      }
      weakSelf.onFieldEndEditing(@{@"text":text});
    }
    [weakSelf textInputDidEnd];
    return YES;
  };
  
  _handler.textFieldShouldReturnBlock = ^BOOL(UITextField *textField) {
    if(weakSelf.onFieldSubmitEditing){
      weakSelf.onFieldSubmitEditing(nil);
    }
    [weakSelf textInputDidEnd];
    return YES;
  };
  
#if DEBUG
  if(_handler.textFieldShouldReturnBlock) {
    NSLog(@"ok (test) =%@", _handler);
  }
#endif
  
}
  
#pragma mark - need resume setter property as follows
- (void)setFieldOfTextAttributes {
  if(!_textAttributes) return;
  _textInpuField.font = _textAttributes.effectiveFont;//contain fontFamily、fontSize、fontWeight...
  _textInpuField.textColor = _textAttributes.effectiveForegroundColor;
  _textInpuField.textAlignment = _textAttributes.alignment;
  _textInpuField.layer.shadowColor = _textAttributes.textShadowColor.CGColor;
  _textInpuField.layer.shadowOffset = _textAttributes.textShadowOffset;
  _textInpuField.layer.shadowRadius = _textAttributes.textShadowRadius;
}
  
- (void)setFieldOFReactPaddingInsets {
  _textInpuField.contentInsets = _reactPaddingInsets;
}
  
- (void)setFieldOFReactBorderInsets {
  _textInpuField.frame = UIEdgeInsetsInsetRect(self.bounds, _reactBorderInsets);
}
  
- (void)setValue:(NSString *)value {
  if(!value) value = @"";
  _value = value;
  _textInpuField.text = value;
}
  
- (void)setMultiValue:(NSDictionary *)multiValue {
  if(!multiValue) return;
  BOOL enable = [multiValue[@"enable"] boolValue];
  if(enable) {
    id obj = multiValue[@"value"];
    NSString * value = nil;
    if([obj isKindOfClass:[NSString class]]) {
      value = obj;
    }
    if(value) {
      [self setValue:value];
    }
  }
}
  
- (void)setPlaceholder:(NSString *)placeholder {
  _placeholder = placeholder;
  if(placeholder) {
    _textInpuField.placeholder = placeholder;
    [_textInpuField setNeedsDisplay];
  }
}
  
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
  _placeholderColor = placeholderColor;
  if(placeholderColor) {
    _textInpuField.placeholderColor = placeholderColor;
  }
}
  
- (void)setPlaceholderFont:(CGFloat)placeholderFont {
  _placeholderFont = placeholderFont;
  if(placeholderFont == 0) return;
  if(self.textFieldNameType == RCTTextFieldCurrency) {
    ((RXCurrencyFormatTextField *)_textInpuField).placeholderFont = [UIFont systemFontOfSize:placeholderFont];
  }
}
  
- (void)setClearTextOnFocus:(BOOL)clearTextOnFocus {
  _clearTextOnFocus = clearTextOnFocus;
  _textInpuField.clearsOnBeginEditing = clearTextOnFocus;
}
  
- (void)setKeyboardType:(UIKeyboardType)keyboardType {
  _keyboardType = keyboardType;
  _textInpuField.keyboardType = keyboardType;
}
  
- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType {
  _returnKeyType = returnKeyType;
  _textInpuField.returnKeyType = returnKeyType;
}
  
- (void)setSecureTextEntry:(BOOL)secureTextEntry {
  _secureTextEntry = secureTextEntry;
  _textInpuField.secureTextEntry = secureTextEntry;
}
  
- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
  _clearButtonMode = clearButtonMode;
  _textInpuField.clearButtonMode = clearButtonMode;
}
  
- (void)setSelectionColor:(UIColor *)selectionColor {
  _selectionColor = selectionColor;
  if(selectionColor) {
    _textInpuField.tintColor = selectionColor;
  }
}
  
  
  
#pragma mark - content
- (void)removeTextField {
  if([_textInpuField isEditing]) {
    [_textInpuField resignFirstResponder];
  }
  [_textInpuField removeFromSuperview];
  _textInpuField = nil;
  _handler = nil;
}
  
- (void)configTextField {
  //#define SetValue(_property, _value) [self set##_property:_value]
  //    SetValue(Value, _value);
  //    SetValue(Placeholder, _placeholder);
  //    SetValue(PlaceholderColor, _placeholderColor);
  //    SetValue(ClearTextOnFocus, _clearTextOnFocus);
  //    SetValue(KeyboardType, _keyboardType);
  //    SetValue(ReturnKeyType, _returnKeyType);
  
  [self setValue:_value];
  [self setPlaceholder:_placeholder];
  [self setPlaceholderFont:_placeholderFont];
  [self setClearTextOnFocus:_clearTextOnFocus];
  [self setKeyboardType:_keyboardType];
  [self setReturnKeyType:_returnKeyType];
  
  // font / frame
  [self setFieldOfTextAttributes];
  [self setFieldOFReactPaddingInsets];
  [self setFieldOFReactBorderInsets];
  
  [_textInpuField setNeedsDisplay];
}
  
  
  
#pragma mark - Focus Control
  
- (void)textInputDidEnd {
  [self endEditing:YES];
  [self reactBlur];
  [self reactFocus];
}
  
- (void)textFieldlostFocus {
  _textInpuField.userInteractionEnabled = NO;
  if(_onFieldBlur) {
    _onFieldBlur(nil);
  }
}
  
- (void)reactFocus {
  _textInpuField.userInteractionEnabled = YES;
  [_textInpuField reactFocus];
}
  
- (void)reactBlur {
  [_textInpuField reactBlur];
  [self textFieldlostFocus];
}
  
- (void)didMoveToWindow {
  [_textInpuField reactFocusIfNeeded];
}

@end
