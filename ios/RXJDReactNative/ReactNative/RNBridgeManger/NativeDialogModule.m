//
//  NativeDialogModule.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "NativeDialogModule.h"

@implementation NativeDialogModule
RCT_EXPORT_MODULE();
    
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}
    
RCT_EXPORT_METHOD(showToast:(NSString *)toast){
    
}
    
RCT_EXPORT_METHOD(showAlertView:(NSString *)title
                  message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray<NSString*>*)otherButtonTitles
                  cancelHandler:(RCTResponseSenderBlock)cancelHandler
                  dismissHandler:(RCTResponseSenderBlock)dismissHandler ){
  
}
@end
