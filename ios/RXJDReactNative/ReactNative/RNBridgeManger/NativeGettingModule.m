//
//  NativeGettingModule.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "NativeGettingModule.h"

@implementation NativeGettingModule
RCT_EXPORT_MODULE();
    
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}
@end
