//
//  Humen.h
//  RuntimeDemo
//
//  Created by tangpeng on 2018/3/13.
//Copyright © 2018年 ICX. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HumenDelegate<NSObject>
- (void)testDelegate;
@end
@interface Humen : NSObject<HumenDelegate>
{
    NSString *sex;
    NSMutableArray *hobbies;
}
@property(strong,nonatomic) NSString *name;
@property(assign,nonatomic) NSInteger age;
- (void)addHobby:(NSString *)hobby;
+ (void)repeatYourWords:(NSString *)words;


- (NSMutableDictionary *)allVars;
- (NSMutableDictionary *)allPropertyies;
- (NSMutableArray *)allMethods;
- (NSMutableArray *)allProtocols;

- (void)oldMethod;

@end
