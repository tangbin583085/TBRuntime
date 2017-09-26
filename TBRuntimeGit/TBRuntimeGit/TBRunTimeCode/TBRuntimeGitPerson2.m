//
//  TBRuntimeGitPerson.m
//  com.pintu.aaaaaa
//
//  Created by hanchuangkeji on 2017/9/25.
//  Copyright © 2017年 hanchuangkeji. All rights reserved.
//

#import "TBRuntimeGitPerson2.h"
#import <objc/runtime.h>

@implementation TBRuntimeGitPerson2

+ (void)load{
    //当我们的类加载到内存时候调用,在整个程序运行期间,只会调用一次
    //1.系统的方法
    Method orginalMethod = class_getClassMethod([self class], @selector(imageNamed:));

    //2.得到自己写的方法
    Method myMethod = class_getClassMethod([self class], @selector(imageWithName:));

    //将系统方法和我们的方法交换
    method_exchangeImplementations(orginalMethod, myMethod);
}


+ (UIImage *)imageNamed:(NSString *)name {
    return [super imageNamed:name];
}

+ (UIImage *)imageWithName:(NSString *)name{

    NSLog(@"%s", __func__);

    name=@"report_page_success_icon";
    
    //注意调用的方法
    return [self imageWithName:name];
}


@end
