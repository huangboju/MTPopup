//
//  UIResponder+MTPopup.m
//  MTPopup
//
//  Created by 黄伯驹 on 2017/10/30.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

#import "UIResponder+MTPopup.h"


@implementation UIResponder (MTPopup)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        
        ReplaceMethod(self, @selector(becomeFirstResponder), @selector(mt_becomeFirstResponder));

#pragma clang diagnostic pop
    });
}
@end
