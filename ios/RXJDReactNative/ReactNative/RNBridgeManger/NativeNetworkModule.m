//
//  NativeNetworkModule.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "NativeNetworkModule.h"

#define TIME_OUT 20

UIKIT_STATIC_INLINE NSError* YLNetError(NSString * desc) {
    return  [[NSError alloc] initWithDomain:@"NativeNetworkModule" code:NSURLErrorUnknown userInfo:@{NSLocalizedDescriptionKey: desc?:@"请求超时,请检查网络连接状态"}];
}

@interface NativeNetworkModule()
@property (nonatomic, strong) NSMutableArray *apis;
@end

@implementation NativeNetworkModule
RCT_EXPORT_MODULE();
    
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}
    
    
#pragma mark - get & set
    
- (NSMutableArray *)apis{
    if (!_apis) {
        _apis = [NSMutableArray array];
    }
    return _apis;
}

@end
