//
//  UIViewController+Tracking.m
//  SwizzledUp
//
//  Created by Jolanta Zakrzewska on 17/05/2022.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(swizzled_viewDidLoad);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        method_exchangeImplementations(originalMethod, swizzledMethod);

    });
}

- (void)swizzled_viewDidLoad {
    [self swizzled_viewDidLoad];
    NSString *className = NSStringFromClass([self class]);
    NSString *logMessage = [NSString stringWithFormat:@"[%@] viewDidLoad", className];
    printf("%s\n", [logMessage cStringUsingEncoding:NSUTF8StringEncoding]);
}

@end
