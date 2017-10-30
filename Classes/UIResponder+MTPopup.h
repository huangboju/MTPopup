//
//  UIResponder+MTPopup.h
//  MTPopup
//
//  Created by 黄伯驹 on 2017/10/30.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@interface UIResponder (MTPopup)

@end
