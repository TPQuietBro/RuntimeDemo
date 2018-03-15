//
//  ReplaceMethod.m
//  RuntimeDemo
//
//  Created by tangpeng on 2018/3/14.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "ReplaceMethod.h"
#import <objc/message.h>

@implementation ReplaceMethod
- (void)replaceMethod:(SEL)aselector fromObject:(id)object{

    //得到实例方法
    Method method = class_getInstanceMethod([object class], aselector);
    //保存原方法实现留作恢复
    IMP orginIMP = method_getImplementation(method);
    self.originIMP = orginIMP;
    //替换原方法
    class_replaceMethod([object class], aselector, (IMP)newMethod, "v@:");
}

- (void)resetMethod:(SEL)aselector fromObject:(id)object{

    //恢复原方法
    class_replaceMethod([object class], aselector, self.originIMP, "v@:");
}

void newMethod(id self,IMP _cmd){
    NSLog(@"被替换了");
}
@end
