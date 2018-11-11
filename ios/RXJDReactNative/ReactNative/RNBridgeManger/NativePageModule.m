//
//  NativePageModule.m
//  RXJDReactNative
//
//  Created by srxboys on 2018/10/14.
//  Copyright © 2018年 srxboys. All rights reserved.
//

#import "NativePageModule.h"

#define TYPE_PUSH  @"push"
#define TYPE_PRE   @"pre"

@implementation NativePageModule
RCT_EXPORT_MODULE();
    
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

#pragma mark - RN的Controller   pop / disMiss
    
/**
 *
 RN页面 退出
 【面临问题】:
 1、在RN 页面浏览，接到 路由链接  。 -> 如果涉及到RN退出，跳转页面。 怎么判断，让RN消失。
 2、提醒框: 都是ViewControll ，在进入RN页面后，弹出的，怎么处理
 3、
 
 RN写法
 NativeModules.NativePageModule.pop(
 'WYBInvestSuccessViewController'
 )
 *
 **/
RCT_EXPORT_METHOD(pop:(NSString *)pageName) {
    UIViewController * c = [self removeControllerPageName:pageName];
    if(!c) return; //可能我们需要 暂时可以吧
    //这个是否解决 上面的问题呢？
//    [[PageRouter sharedPageRouter] goBackToViewController:c Animated:NO completion:nil];
//    [[PageRouter sharedPageRouter] goBackAnimated:YES];
    NSLog(@"pop nativePageName=%@", pageName);
}
    
RCT_EXPORT_METHOD(disMiss:(NSString *)pageName) {
    UIViewController * c = [self removeControllerPageName:pageName];
    if(!c) return; //可能我们需要 暂时可以吧
    //这个是否解决 上面的问题呢？
//    [[PageRouter sharedPageRouter] dismissViewController:c animated:YES complete:nil];
    NSLog(@"disMiss nativePageName=%@", pageName);
}
- (UIViewController *)removeControllerPageName:(NSString *)pageName {
    UIViewController * c = nil;
//    NSArray* navArray = ((UINavigationController *)[PageRouter sharedPageRouter].rootViewController).viewControllers;
//    NSArray* reversedArray = [[navArray reverseObjectEnumerator] allObjects];
//    for(UIViewController * vc in reversedArray) {
//        if([vc isKindOfClass:[RNRootPage class]]) {
//            RNRootPage * newC = (RNRootPage *)vc;
//            if([newC.pageName isEqualToString:pageName]) {
//                c = newC;
//            }
//            break;
//        }
//    }
    return c;
}
    
    
#pragma mark - 原生的Controller  push + routerPage
/**
 *      跳转到 URL
 **/
RCT_EXPORT_METHOD(pushMeasurementPageWithExtraParam:(NSDictionary *)params) {
    if(!params) return;
//    [[PageRouter sharedPageRouter] pushMeasurementPageWithExtraParam:params];
}


#pragma mark - 原生的Controller  push / present

/**
 *      跳转到 ViewController
 *
 *  【注意】WYBTotalAmoutDetailViewController 等 弹框的Controller  **** `不可使用` ****
 *
 RN写法:
 NativeModules.NativePageModule.pushController(
   'WYBInvestSuccessViewController', //pageName
   {                                 //params
     key1:value1,
     key2:value2,
     ...
   }
 )
 **/
RCT_EXPORT_METHOD(pushController:(NSString *)pageName params:(NSDictionary *)params) {
    [self turnController:TYPE_PUSH pageName:pageName params:params models:nil];
}

RCT_EXPORT_METHOD(preController:(NSString *)pageName params:(NSDictionary *)params) {
    [self turnController:TYPE_PRE pageName:pageName params:params models:nil];
}

#pragma mark   push / present With NSJsonModel
/**  具体看  - (void)setObject:(NSObject *)object models:(NSArray *)models   **/
RCT_EXPORT_METHOD(pushControllerWithModels:(NSString *)pageName params:(NSDictionary *)params models:(NSArray<NSDictionary *> *)models) {
    [self turnController:TYPE_PUSH pageName:pageName params:params models:models];
}

RCT_EXPORT_METHOD(preControllerWithModels:(NSString *)pageName params:(NSDictionary *)params models:(NSArray<NSDictionary *>*)models) {
    [self turnController:TYPE_PRE pageName:pageName params:params models:models];
}
    
- (void)turnController:(NSString *)type pageName:(NSString *)pageName params:(NSDictionary *)params models:(NSArray<NSDictionary *>*)models{
    
    Class nameClass = NSClassFromString(pageName);
    UIViewController * c = [[nameClass alloc] init];
    if(![c isKindOfClass:[UIViewController class]]) {
        NSLog(@"class not is `UIViewController class`");
        return;
    }

    //set params
    [self setObject:c withParams:params];

    //set models
    [self setObject:c models:models];
//
    if([type isEqualToString:TYPE_PUSH]) {
        //push/pop
//        [[PageRouter sharedPageRouter] pushViewController:c animated:YES];
    }
    else {
        //present / disMiss
//        [[PageRouter sharedPageRouter] presentViewController:c animated:YES completion:nil];
    }
}
    
    
#pragma mark - 给 对象的属性 赋值
    
- (void)setObject:(NSObject *)object withParams:(NSDictionary *)params {
    for (NSString * key in params) {
        if (![key isKindOfClass:[NSString class]] || !key.length) {
            //            NSLog(@"1-非法的key：(%@)", key);
            continue;
        }
        id value = params[key];
        if(!value) continue;
        if([key isEqualToString:@"title"]) {
            // controller 标题 特殊处理
//            if([object isKindOfClass:[BaseViewController class]]) {
//                if([self veriValue:value forType:@encode(NSString*)]) {
//                    BaseViewController * c = (BaseViewController *)object;
//                    c.title = value;
//                    if([c respondsToSelector:@selector(setPageTitle:)]) {
//                        [c setPageTitle:value];
//                        NSLog(@"set pageTitle key=%@ value=%@", key, value);
//                        continue;
//                    }
//                }
//            }
        }

        // 下面无用
        //        NSRange range1 = [key rangeOfComposedCharacterSequencesForRange:NSMakeRange(1, 5)];
        //        NSLog(@"--%@--%@", @(range1.location), @(range1.length));
        //        for (int i=0; i<key.length;) {
        //            NSRange range = [key rangeOfComposedCharacterSequenceAtIndex:i];
        //            NSString *s = [key substringWithRange:range];
        //            NSLog(@"s(%@)--%@", @(i), s);
        //            i += range.length;
        //        }
        //        return;

        NSRange composedRange = [key rangeOfComposedCharacterSequenceAtIndex:0];
        //        NSLog(@"%@-%@", @(composedRange.location), @(composedRange.length));
        if (composedRange.length > 1) {
            NSLog(@"2-非法的key：(%@)", key);
            continue;
        }

        unichar first = [key characterAtIndex:0];
        if (first >= 97 && first <= 122) {
            first -= 32;
        }

        if (!(first >= 65 && first <= 90)
            && first != '_'
            && first != '$') {
            //            NSLog(@"3-非法的key：(%@)", key);
            continue;
        }

        NSString *tailKey = [key substringFromIndex:1];
        NSString *setter = [NSString stringWithFormat:@"set%c%@:", first, tailKey];
        //        NSLog(@"可能合法的key(%@) => setter(%@)", key, setter);

        if ([object respondsToSelector:NSSelectorFromString(setter)]) {
            @try {
                [object setValue:value forKey:key];
            }
            @catch(NSException *exception) {
                NSLog(@"e-%@", exception);
            }
        }
    }
}
    
    
/**
 *      给类对象的属性 赋值 数据模型对象
 *
   js代码如下:
     [
       {
         classModelName : 属性名1,
         数据模型名1:{ //NSDictionary
           key1:value1,
           key2:value2,
           ...
           }
       },
       {
         classModelName : 属性名2,
         数据模型名2:[ //NSArray
           value1,
           value2,
           ...
           ]
       },
       ...
     ]
 
   oc 代码:
     @property (nonatomic) 数据模型名1 *属性名1;
     @property (nonatomic) NSArray<数据模型名2> *属性名2;
 */
- (void)setObject:(NSObject *)object models:(NSArray *)models {
    for(NSInteger i = 0; i < models.count ; i ++) {
        NSDictionary * dict = models[i];
        if(!dict) return;
        if([dict isKindOfClass:[NSDictionary class]]) {

            //通过valueDict的key 来，判断是模型名(RN_Model_Name)还是 属性名
            NSArray * subAllKeys = dict.allKeys;
            if([subAllKeys containsObject:@"classModelName"]) {
                NSString * attName = nil; //属性名
                NSString * modelClassString = nil;
                id modelValue = nil;
                for(NSString * subkey in subAllKeys) {
                    if([subkey isEqualToString:@"classModelName"]) {
                        attName = dict[subkey];
                    }
                    else {
                        modelClassString = subkey;
                        modelValue = dict[subkey];
                    }
                }
                if(!attName) return;
                if(attName.length == 0) continue;
//
                if(!modelClassString||!modelValue) continue;
                if(modelClassString.length ==0) continue;
                if([modelValue isKindOfClass:[NSDictionary class]]) {
                    Class modelClass = NSClassFromString(modelClassString);
                     //下面 JSONModel  MJExtenstion  YYModel 等处理
//                    id model = [[modelClass alloc] initWithDictionary:modelValue error:nil];
//                    if(model){
//                        [self setObject:object withParams:@{attName:model}];
//                    }
                }
                else if([modelValue isKindOfClass:[NSArray class]]){
                    Class modelClass = NSClassFromString(modelClassString);
                    id model = [[modelClass alloc] initWithArray:modelValue];
                    if(model){
                        [self setObject:object withParams:@{attName:model}];
                    }
                }
            }
            else {
                //属性名 和  数据模型名 一模一样 //当然这种情况不存在
                //                Class modelClass = NSClassFromString(key);
                //                id model = [[modelClass alloc] initWithDictionary:value error:nil];
                //                if(model){
                //                    [self setObject:object withParams:@{key:model}];
                //                }
            }
        }
    }
}
    
    
    
    /**
     * 放弃使用
     */
    /*
     - (void)runtime_setObject:(id)object params:(NSDictionary *)params {
     Class nameClass = [object class];
     for(NSString *_key in params) {
     if(_key.length == 0) continue;
     if(![_key isKindOfClass:[NSString class]]) continue;
     NSString *key = [NSString stringWithFormat:@"%@", _key];
     id value = params[key];
     if(!value) continue;
     if([key isEqualToString:@"title"]) {
     // controller 标题 特殊处理
     if([object isKindOfClass:[BaseViewController class]]) {
     if([self veriValue:value forType:@encode(NSString*)]) {
     BaseViewController * c = (BaseViewController *)object;
     c.title = value;
     if([c respondsToSelector:@selector(setPageTitle:)]) {
     [c setPageTitle:value];
     NSLog(@"set pageTitle key=%@ value=%@", key, value);
     continue;
     }
     }
     }
     }
     
     Ivar keyIvar = class_getInstanceVariable(nameClass, [key UTF8String]);
     NSString * newKey = key;
     if(!keyIvar) {
     //针对 (property的)setter/getter 的对象处理
     newKey = [NSString stringWithFormat:@"_%@", key];
     keyIvar = class_getInstanceVariable(nameClass, [newKey UTF8String]);
     }
     if(keyIvar) {
     const char * type = ivar_getTypeEncoding(keyIvar);
     
     if([self veriValue:value forType:type]) {
     NSLog(@"set key=%@ value=%@", key, value);
     #warning mark - 目前针对 赋值，有的 属性，会崩溃 url
     object_setIvar(object, keyIvar, value);
     }
     else {
     NSLog(@"**** \nnot set key=%@ value=%@\n\n", key, value);
     }
     }
     else {
     NSLog(@"**[no keyIvar]** \nnot set key=%@ value=%@\n\n", key, value);
     }
     }
     }
     */


    
    // 验证 value 是否 和对象定义的数据类型一致
- (BOOL)veriValue:(id)value forType:(const char *)typeString {
    if(value == nil || [value isKindOfClass:[NSNull class]]) return NO;
    
    if(typeString[0] == '@') {
        //oc 数据类型
#define NewType [NSString stringWithCString:typeString encoding:NSUTF8StringEncoding]
#define StringCmp(_str) [NewType isEqualToString:_str]
#define PackObj(_str) [NSString stringWithFormat:@"@\"%@\"", _str]
        
        NSString * ArrayType = PackObj(@"NSArray");
        NSString * MutableArrayType = PackObj(@"NSMutableArray");
        NSString * DictionaryType = PackObj(@"NSDictionary");
        NSString * MutableDictionaryType = PackObj(@"NSMutableDictionary");
        
        if(StringCmp(ArrayType) || StringCmp(MutableArrayType)) {
            return [value isKindOfClass:[NSArray class]];
        }
        if(StringCmp(DictionaryType) || StringCmp(MutableDictionaryType)) {
            return [value isKindOfClass:[NSDictionary class]];
        }
        
        return [value isKindOfClass:[NSString class]];;
    }
    
    //基本数据类型
    BOOL result = NO;
    switch (typeString[0]) {
        case 'S': //unsignedShortValue
        case 's': //shortValue
        case 'I': //unsignedIntValue
        case 'i': //intValue
        case 'L': //unsignedLongValue
        case 'l': //longValue
        case 'Q': //unsignedLongLongValue
        case 'q': //longLongValue
        case 'F': //CGFloatValue
        case 'f': //floatValue
        case 'B': //boolValue
        case 'd': //doubleValue
        result = [value isKindOfClass:[NSNumber class]];
        break;
        default:
        break;
    }
    return result;
}
    
@end
