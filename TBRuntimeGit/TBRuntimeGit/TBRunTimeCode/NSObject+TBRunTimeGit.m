//
//  NSObject+TBRunTimeGit.m
//  com.pintu.aaaaaa
//
//  Created by hanchuangkeji on 2017/9/25.
//  Copyright © 2017年 hanchuangkeji. All rights reserved.
//

#import "NSObject+TBRunTimeGit.h"
#import <objc/runtime.h>

@implementation NSObject (TBRunTimeGit)

static const char tbKey = '\0';

- (void)setMyProperty:(NSString *)string {
    
    // 添加属性
    objc_setAssociatedObject(self, &tbKey, string, OBJC_ASSOCIATION_ASSIGN);
}

- (id)getMyProperty {
    
    // 获取属性
    return objc_getAssociatedObject(self, &tbKey);
}



@end
