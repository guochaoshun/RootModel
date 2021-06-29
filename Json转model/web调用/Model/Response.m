//
//  Response.m
//  web调用
//
//  Created by 郭朝顺 on 2019/1/2星期三.
//  Copyright © 2019年 乐乐. All rights reserved.
//

#import "Response.h"

@implementation Response


+ (NSDictionary *)jsonArraryType{
    return @{
             @"resultInfo":@"Person"
             };
}

// key为属性名,  value为服务器名字
+ (NSDictionary *)propertyNameToJsonKey{
    return @{
             @"isSuccess":@"success"
             };
}


@end
