//
//  NativePickerModule.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "NativePickerModule.h"

#import <RXExtenstion/RXExRXPickerView/RXPickerView.h>

UIKIT_STATIC_INLINE NSError* RXPickerError(NSString * desc) {
  return  [[NSError alloc] initWithDomain:@"NativePickerModule" code:NSURLErrorUnknown userInfo:@{NSLocalizedDescriptionKey: desc?:@"数据源错误"}];
}

@implementation NativePickerModule
RCT_EXPORT_MODULE();
    
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

/**
 *     隐藏所有 RRPickerView
 */
RCT_EXPORT_METHOD(HiddenPickerView){
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow ?: [[UIApplication sharedApplication].delegate window];
    if(!win) return;
    // 关闭 RRPickerView的显示
    for (UIView *view in win.subviews) {
        if ([view isKindOfClass:[RXPickerView class]]) {
            [view removeFromSuperview];
        }
    }
    
}
    
    
#pragma mark - LabelPickerView
/**
 *       LabelPickerView 一行文字的选择器
 *
 * @prama nomalSingle      默认第一条数据(一般都是 用户可以不选择的数据)
 * @prama nomalSelected    默认选择第几条
 * @prama itemList         数据源（ NSArray<NSString *>* ）  ⚠️
 * @prama resolver         异步回调 (选择picker的 点击回调)
 *
 */
RCT_EXPORT_METHOD(LabelPickerView:(NSString *)nomalSingle
                  nomalSelected:(NSInteger)nomalSelected
                  itemList:(NSArray<NSString *>*)itemList
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  
  if(!itemList || itemList.count == 0) {
      reject(nil,nil,RXPickerError(nil));
      return;
  }
  
  // 初始化
  RXPickerView * picker = RXPickerView_alloc;
  
  // 行高
  picker.itemHeight = 50;
  
  // 数据(可以为数据模型等)
  picker.items = itemList;
  
  // 准备 picker获取 的view
  [picker setItemViewBlock:^UIView *(UIView *reusingView, NSString * item, NSArray *selectedComponents) {
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = item? ([item isEqualToString:[NSString class]]?item:@"") :@"";
    return label;
  }];
  
  // 设置焦点
  if (nomalSelected > 0) {
      if(nomalSelected < picker.items.count) {
          picker.selectedIndex = nomalSelected;
      }
  }
  
  // 点击完成按钮的回调block
  [picker showWithDoneBlock:^(NSInteger index, NSString * item, NSArray * selectedComponents) {
    if(resolve) {
      resolve(@{
                @"index":@(index),
                @"item":item
                });
    }
  }];
  
  // 显示
  [picker show];
  
}
    
    
    
    
#pragma mark - CouponPickerView
/**
 *       CouponPickerView 优惠券的选择器
 *
 * @prama nomalSingle      默认第一条数据(一般都是 用户可以不选择的数据)
 * @prama nomalSelected    默认选择第几条
 * @prama itemList         数据源 ( NSArray<NSDictionary *>* ) ⚠️
 * @prama resolver         异步回调 (选择picker的 点击回调)
 *
 */
RCT_EXPORT_METHOD(CouponPickerView:(NSString *)nomalSingle
                  nomalSelected:(NSInteger)nomalSelected
                  itemList:(NSArray<NSDictionary *>*)itemList
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
//    if(itemList.count == 0) {
//        reject(nil,nil,RXPickerError(nil));
//        return;
//    }
//
//    RXPickerView *pv = RXPickerView_alloc;
//    NSMutableArray *items = [NSMutableArray array];
//
//    //默认第一条
//    if(nomalSingle || nomalSingle.length > 0) {
//        CouponItem *item0 = [[CouponItem alloc] init];
//        item0.single = nomalSingle;
//        [items addObject:item0];
//    }
//
//    //列表数据(一定是匹配的)
//    for(NSDictionary * dict in itemList) {
//        CouponItem *item = [[CouponItem alloc] init];
//        item.key1 = OBJECTFORKEY(dict, @"key1");
//        item.value1 = OBJECTFORKEY(dict, @"value1");
//        item.key2 = OBJECTFORKEY(dict, @"key2");
//        item.value2 = OBJECTFORKEY(dict, @"value2");
//        if([dict objectForKey:@"enable"]) {
//            item.enable = OBJECTFORKEY(dict, @"value2");
//        }
//        [items addObject:item];
//    }
//
//    pv.items = items;
//
//    // 设置view
//    pv.itemViewBlock = ^UIView *(UIView *reusingView, CouponItem *item) {
//        PickItemCouponView *itemView = (PickItemCouponView *)reusingView;
//        if (itemView == nil) {
//            itemView = [[PickItemCouponView alloc] init];
//            itemView.keyRatio = 0.5;
//        }
//        itemView.key1Label.text = item.key1;
//        itemView.value1Label.text = item.value1;
//        itemView.key2Label.text = item.key2;
//        itemView.value2Label.text = item.value2;
//        itemView.singleLabel.text = item.single;
//        itemView.enable = item.enable;
//        return itemView;
//    };
//
//    // 设置焦点
//    if (nomalSelected > 0) {
//        if(nomalSelected < pv.items.count) {
//            pv.selectedIndex = nomalSelected;
//        }
//    }
//
//    // 点选事件
//    pv.doneBlock = ^(NSInteger index, CouponItem *item) {
//        resolve(
//                @{
//                  @"index":@(index),
//                  @"enable":@(item.enable)
//                  }
//                );
//    };
//
//    // 显示
//    [pv show];
}
    
    

@end
