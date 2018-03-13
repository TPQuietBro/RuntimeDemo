//
//  Humen.m
//  RuntimeDemo
//
//  Created by tangpeng on 2018/3/13.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "Humen.h"
#import <objc/message.h>

@implementation Humen

- (instancetype)init
{
    self = [super init];
    if (self) {
        hobbies = [[NSMutableArray alloc] init];
        sex = @"male";
    }
    return self;
}
- (void)addHobby:(NSString *)hobby{
    [hobbies addObject:hobby];
    NSLog(@"现在的爱好有:%@",hobbies);
}
+ (void)repeatYourWords:(NSString *)words{
    NSLog(@"重复了\"%@\"这句话",words);
}

- (void)testDelegate{
    NSLog(@"遵守了协议");
}
#pragma mark - show class info
- (NSMutableDictionary *)allVars{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (NSInteger i = 0; i < count; i++) {
        const char *varName = ivar_getName(vars[i]);
        NSString *name = [NSString stringWithUTF8String:varName];
        id value = [self valueForKey:name];
        if (value) {
            [dict setObject:value forKey:name];
        }else{
            NSLog(@"%@这个变量没有被赋值",name);
        }
    }
    free(vars);
    
    return dict;
}
- (NSMutableDictionary *)allPropertyies{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (NSInteger i = 0; i < count; i++) {
        const char *pName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:pName];
        id value = [self valueForKey:name];
        if (value) {
            [dict setObject:value forKey:name];
        }else{
            NSLog(@"%@这个属性没有被赋值",name);
        }
    }
    free(properties);
    return dict;
}

- (NSMutableArray *)allMethods{
    NSMutableArray *dict = [[NSMutableArray alloc] init];
    unsigned int count = 0;
    Method *methods = class_copyMethodList([self class], &count);
    
    for (NSInteger i = 0; i < count; i++) {
        SEL mName = method_getName(methods[i]);
        const char *sName = sel_getName(mName);
        NSString *name = [NSString stringWithUTF8String:sName];
        [dict addObject:name];
    }
    free(methods);
    return dict;
}

- (NSMutableArray *)allProtocols{
    NSMutableArray *dict = [[NSMutableArray alloc] init];
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocols = class_copyProtocolList([self class], &count);
    for (NSInteger i = 0; i < count; i ++) {
        const char *proName = protocol_getName(protocols[i]);
        NSString *name = [NSString stringWithUTF8String:proName];
        [dict addObject:name];
    }
    free(protocols);
    return dict;
}

#pragma mark - add new methods
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    if ([NSStringFromSelector(sel) isEqualToString:@"oldMethod"]) {
//        class_addMethod([self class], sel, (IMP)newMethod, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//void newMethod(id self,IMP _cmd){
//    NSLog(@"这是一个新方法哦");
//}

#pragma mark - replace current method by another method
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
    [anInvocation setSelector:@selector(replaceMethod)];
    [anInvocation invokeWithTarget:self];
}
- (void)replaceMethod{
    NSLog(@"替换了方法");
}

@end
