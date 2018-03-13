//
//  Animal.m
//  RuntimeDemo
//
//  Created by tangpeng on 2018/3/13.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "Animal.h"
#import "Humen.h"
@implementation Animal
#pragma mark - invoke a method from another class dynamically
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return NO;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    return nil;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"oldMethod"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    Humen *humen = [Humen new];
    [anInvocation invokeWithTarget:humen];
}
@end
