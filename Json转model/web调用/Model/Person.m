//
//  Person.m
//  web调用
//
//  Created by 郭朝顺 on 2018/12/13星期四.
//  Copyright © 2018年 乐乐. All rights reserved.
//

#import "Person.h"

@implementation Person

// key为属性名,  value为服务器名字
+ (NSDictionary *)propertyNameToJsonKey{
    return @{
             @"city":@"cityy"
             };
}

@end
