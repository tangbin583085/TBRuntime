//
//  TBRunTimeGitVC.m
//  com.pintu.aaaaaa
//
//  Created by hanchuangkeji on 2017/9/25.
//  Copyright © 2017年 hanchuangkeji. All rights reserved.
//

#import "TBRunTimeGitVC.h"
#import "NSObject+TBRunTimeGit.h"
#import "TBRuntimeGitPerson.h"
#import "TBRuntimeGitPerson2.h"
#import <objc/runtime.h>

@interface TBRunTimeGitVC ()

@property (nonatomic, strong)TBRuntimeGitPerson *person;

@end

@implementation TBRunTimeGitVC

- (TBRuntimeGitPerson *)person {
    if (_person == nil) {
        _person = [[TBRuntimeGitPerson alloc] init];
    }
    return _person;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIProgressView *myView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    myView.progress = 0.6;
    myView.frame = CGRectMake(20, 20, 200, 50);
    [self.view addSubview:myView];

}

// 给分类添加属性
- (IBAction)btn1Click:(id)sender {
    [self.person setMyProperty:@"tangbin"];
    NSLog(@"%@", [self.person getMyProperty]);
}

- (IBAction)btn2Click:(id)sender {
//    TBRuntimeGitPerson *person = [[TBRuntimeGitPerson alloc] init];
    self.person.age = 98;
    [self getProperties:self.person];
}

- (IBAction)btn3Click:(id)sender {
    [self getProperties2:self.person];
}

- (IBAction)btn4Click:(id)sender {
    [self addProperty:self.person];
}

- (IBAction)btn5Click:(id)sender {
    [self replaceProperty:self.person];
}

- (IBAction)btn6Click:(id)sender {
    [self getPropertyValue:self.person];
}

- (IBAction)editValue:(id)sender {
    [self editValueIvar:self.person];
}

- (IBAction)btnExchangeFun:(id)sender {
    
    [self exchangeFunc];
}


// 获取类属性 方法1
- (NSArray *)getProperties:(id)object {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; i < count; i++) {
        objc_property_t t = properties[i];
        const char * propertyName = property_getName(t);
        NSString *stringName = [NSString stringWithUTF8String:propertyName];
        NSLog(@"propertyName -- > %@", stringName);
        
        NSLog(@"%@", [NSString stringWithUTF8String:property_getAttributes(t)]);
        
        [array addObject:stringName];
    }
    return array;
}


// 获取类属性 方法2
- (NSArray *)getProperties2:(id)object {
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([object class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *ivarStringName = [NSString stringWithUTF8String:ivarName];
        NSLog(@"ivarStringName %@", ivarStringName);
        NSLog(@"ivar_getTypeEncoding %@", [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)]);
        [array addObject:ivarStringName];
    }
    return array;
}

// 添加属性 方法1
- (void)addProperty:(id)object {
    const char *name2 = "name2";
    objc_property_attribute_t t1 = {"T", "@\"NSString\""};
    objc_property_attribute_t t2 = {"C", ""};
    objc_property_attribute_t t3 = { "V", "tangbin2" };
    objc_property_attribute_t attrs[] = {t1, t2, t3};
    class_addProperty([object class], name2, attrs, 3);
}

// 替换属性
- (void)replaceProperty:(id)object {
    const char *age = "age";
    objc_property_attribute_t t1 = {"T", "@\"NSString\""};
    objc_property_attribute_t t2 = {"C", ""};
    objc_property_attribute_t t3 = { "V", "tangbin2" };
    objc_property_attribute_t attrs[] = {t1, t2, t3};
    class_replaceProperty([object class], age, attrs, 3);
}

// 获取值属性
- (void)getPropertyValue:(id)object {
    Ivar ivar = class_getInstanceVariable([object class], "_name");
    NSString *name = object_getIvar(self.person, ivar);
    NSLog(@"%@", name);
}

// 修改属性
- (void)editValueIvar:(id)object {
    Ivar ivar = class_getInstanceVariable([object class], "_name");
    object_setIvar(object, ivar, @"hello China");
}

+ (void)load {
    [super load];
    Method methodSource = class_getInstanceMethod([self class], @selector(description));
    Method methodDes = class_getInstanceMethod([self class], @selector(myDescription));
    method_exchangeImplementations(methodSource, methodDes);
}

- (void)exchangeFunc {
    [self description];
}

- (NSString *)description {
    NSLog(@"%s", __func__);
    return [super description];
}

- (NSString *)myDescription {
    NSLog(@"%s", __func__);
    NSLog(@"begin");
    NSString *stringOld = [self myDescription];
    NSLog(@"%@", stringOld);
    NSLog(@"end");
    return stringOld;
}



@end
