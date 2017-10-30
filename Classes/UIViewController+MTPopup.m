//
//  UIViewController+MTPopup.m
//  MTPopup
//
//  Created by 黄伯驹 on 2017/10/30.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

#import "UIViewController+MTPopup.h"
#import "UIResponder+MTPopup.h"

@implementation UIViewController (MTPopup)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        ReplaceMethod(self, @selector(viewDidLoad), @selector(mt_viewDidLoad));
        ReplaceMethod(self, @selector(presentViewController:animated:completion:), @selector(mt_presentViewController:animated:completion:));
        ReplaceMethod(self, @selector(dismissViewControllerAnimated:completion:), @selector(mt_dismissViewControllerAnimated:completion:));
        ReplaceMethod(self, @selector(presentedViewController), @selector(mt_presentedViewController));
        ReplaceMethod(self, @selector(presentingViewController), @selector(mt_presentingViewController));
#pragma clang diagnostic pop
    });
}
@end
