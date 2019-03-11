//
//  NSDictionary+JsonLog.m
//  web调用
//
//  Created by 郭朝顺 on 2018/12/14星期五.
//  Copyright © 2018年 乐乐. All rights reserved.
//

#import "NSDictionary+JsonLog.h"


@implementation NSArray (JsonLog)

- (NSString *)description{
    if ( [NSJSONSerialization isValidJSONObject:self] ) {
        NSData * data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        NSString * result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        result = [result stringByReplacingOccurrencesOfString:@"\\" withString:@""] ;
        return result;
    }
    
    return [NSString stringWithFormat:@"%@",self];

}


@end


@implementation NSDictionary (JsonLog)

//- (NSString *)descriptionWithLocale:(id)locale {
//    return [self description];
//}

- (NSString *)description{
    if ( [NSJSONSerialization isValidJSONObject:self] ) {
        NSData * data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        NSString * result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        result = [result stringByReplacingOccurrencesOfString:@"\\" withString:@""] ;
        return result;
    }
    return [NSString stringWithFormat:@"%@",self];

}


@end
