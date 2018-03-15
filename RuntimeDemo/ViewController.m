//
//  ViewController.m
//  RuntimeDemo
//
//  Created by 唐鹏 on 2018/3/13.
//  Copyright © 2018年 ICX. All rights reserved.
//

#import "ViewController.h"
#import "Humen.h"
#include <objc/message.h>
#import "Animal.h"
#import "ReplaceMethod.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self addClassDynamiclly];
    Humen *humen = [[Humen alloc] init];
    [humen addHobby:@"football"];
    [humen addHobby:@"basketball"];
    [Humen repeatYourWords:@"you are my superstar!"];
    
    humen.name = @"allen";
    humen.age = 18;
    
    //NSLog(@"%@,%@,%@,%@",[humen allVars],[humen allPropertyies],[humen allMethods],[humen allProtocols]);
    
   // [humen oldMethod];
    
    ReplaceMethod *replace = [[ReplaceMethod alloc] init];
    [replace replaceMethod:@selector(addHobby:) fromObject:humen];
    
   // [humen oldMethod];
    [humen addHobby:@"table tennis"];
    
    [replace resetMethod:@selector(addHobby:) fromObject:humen];
    [humen addHobby:@"table tennis"];
//    Animal *an = [Animal new];
//    [an performSelector:@selector(oldMethod)];
    
}
/*
 void saySomeThing(id self,SEL _cmd,id var){
 NSLog(@"%@的年龄是%@,他说了一句%@",[self valueForKeyPath:@"_name"],object_getIvar(self, class_getInstanceVariable([self class], "_age")),var);
 }
 
 - (void)test:(NSString *)some{
 NSLog(@"%@",some);
 }
 
 - (void)addClassDynamiclly{
 //分配新类Person的空间和名字
 Class Person = objc_allocateClassPair([NSObject class], "Person", 0);
 //给类添加属性,属性名,内存大小,实际大小,编码类型
 class_addIvar(Person, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString*));
 class_addIvar(Person, "_age", sizeof(int), log2(sizeof(int)), @encode(int));
 //注册一个方法
 SEL sel = sel_registerName("say:");
 //添加方法的实现和返回类型,这里方法名是say,但是调用的实现却是saySomeThing的方法实现
 class_addMethod(Person, sel, (IMP)saySomeThing, "v@:@");
 //注册这个类
 objc_registerClassPair(Person);
 
 //实例化Person类
 id person = [[Person alloc] init];
 //通过KVC赋值
 [person setValue:@"allen" forKeyPath:@"_name"];
 //拿到类中的成员变量
 Ivar var = class_getInstanceVariable(Person, "_age");
 //对实例的变量赋值
 object_setIvar(person, var, @18);
 //调用方法,发送消息
 ((void (*)(id, SEL, id))objc_msgSend)(person,sel,@"123");
 //当实例不为nil时,Person是不能释放的
 person = nil;
 //需要实例销毁之后,才能销毁这个类
 objc_disposeClassPair(Person);
 }

 */


@end
