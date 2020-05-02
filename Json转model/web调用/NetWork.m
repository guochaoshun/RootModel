//
//  NetWork.m
//  web调用
//
//  Created by 郭朝顺 on 2018/12/13星期四.
//  Copyright © 2018年 乐乐. All rights reserved.
//

#import "NetWork.h"


#define Safe_Block(block, ...) if (block) { block(__VA_ARGS__); };

@implementation NetWork

- (void)startLoadData{
    
    if (self.urlString ==nil ) {
        return;
    }
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    request.HTTPMethod = @"POST";
    
    
    NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:self.parameters.count];
    for (NSString  * key in self.parameters) {
        NSString * str = [NSString stringWithFormat:@"%@=%@",key,self.parameters[key]];
        [array addObject:str];
    }
    NSString * body = [array componentsJoinedByString:@"&"];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];

    
    NSURLSession * session = [NSURLSession sharedSession];
    [session dataTaskWithRequest:request];
    
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            Safe_Block(self.fail,error);
            return  ;
        }
        //8.解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:nil];
        NSDictionary * result = dealWithDic(dic) ;
        NSLog(@"\n~~~~~~~~~~~~http~success~~~~~~~~~~~~~~~~<<\nURL = %@\npara = %@ \n responseObject = %@\n   >>~~~~~~~~~~~~http~end~~~~~~~~~~~~~~~~",self.urlString, self.parameters, result);
        Safe_Block(self.success,result);
        
        
        
    }];
    [task resume];
}

// 去掉 JSON字典/数组 里面的空值
id dealWithDic(id object) {
    
    
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray * arr = [(NSArray *)object mutableCopy];
        for (int i = (int)(arr.count-1); i>=0; i--) {
            id value = arr[i];
            if (value == nil || [value isKindOfClass:[NSNull class]]) {
                [arr removeObjectAtIndex:i];
            }
            if ([value isKindOfClass:[NSArray class] ] || [value isKindOfClass:[NSDictionary class] ]) {
                
                arr[i] = dealWithDic(value);
            }
            
            
        }
        return arr;
    }
    
    
    if ([object isKindOfClass:[NSDictionary class] ]) {
        NSMutableDictionary * result = [object mutableCopy];
        for (NSString * key in object) {
            id value = object[key];
            if (value == nil || [value isKindOfClass:[NSNull class]]) {
                [result removeObjectForKey:key];
            }
            if ([value isKindOfClass:[NSArray class] ] || [value isKindOfClass:[NSDictionary class] ]) {
                
                result[key] = dealWithDic(value);
            }
            
            
        }
        return result;
    }
    
    
    return object;
}



@end
