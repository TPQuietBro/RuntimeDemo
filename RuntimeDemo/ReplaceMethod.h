//
//  ReplaceMethod.h
//  RuntimeDemo
//
//  Created by tangpeng on 2018/3/14.
//Copyright © 2018年 ICX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplaceMethod : NSObject
@property(assign,nonatomic) IMP originIMP;
- (void)replaceMethod:(SEL)aselector fromObject:(id)object;
- (void)resetMethod:(SEL)aselector fromObject:(id)object;
@end
