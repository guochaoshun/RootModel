//
//  RootModel.m
//  ZWYL_iOS
//
//  Created by 李雅珠 on 4/14/17.
//  Copyright © 2017 zwyl. All rights reserved.
//

#import "RootModel.h"
#import <objc/runtime.h>

@implementation RootModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        // 方式1 , 简单,但是不能处理嵌套
//        [self setValuesForKeysWithDictionary:dic];
        // 方式2 ,
        //得到当前class的所有属性
        uint count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        
        //循环并用KVC得到每个属性的值
        for (int i = 0; i<count; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = @(property_getName(property));
            id value = [dic valueForKey:propertyName];

            // 处理value , 如果propertyNameToJsonKey有值,
            NSString * jsonKey  = [[self class]propertyNameToJsonKey][propertyName] ;
            if (jsonKey != nil) {
                value = [dic valueForKey:jsonKey];
            }
            
            NSString *type = @(property_getAttributes(property));
            NSLog(@"name = %@  type = %@  value = %@",propertyName,type,value);
            
            if ([type containsString:@"\""]) {
                NSString * className = [type componentsSeparatedByString:@"\""][1];
                
                // 处理model中嵌套model
                Class modelClass = NSClassFromString(className) ;
                BOOL isRootModelClass = [modelClass isKindOfClass: object_getClass([RootModel class])] ;
                if (isRootModelClass) {
                    RootModel * subModel = [[modelClass alloc]initWithDic:value] ;
                    [self setValue:subModel forKey:propertyName];
                    continue ;
                }
                // 处理model中嵌套数组
                if ([className isEqualToString:@"NSArray"]) {
                    NSString * modelClassName = [[self class] jsonArraryType][propertyName] ;
                    modelClass = NSClassFromString(modelClassName) ;

                    BOOL isRootModelClass = [modelClass isKindOfClass: object_getClass([RootModel class])] ;
                    if (isRootModelClass) {
                        NSArray * subModelArray = [modelClass modelArrayWithDicArray:value] ;
                        [self setValue:subModelArray forKey:propertyName];
                        continue ;
                    }
                }
            }
            [self setValue:value forKey:propertyName];

        }
        
        //释放
        free(properties);

        
    }
    return self;
    
}

+ (NSMutableArray *)modelArrayWithDicArray:(NSArray *)dicArray {
    NSMutableArray * temp = [[NSMutableArray alloc] initWithCapacity:dicArray.count];
    for (NSDictionary * dic in dicArray) {
        RootModel * model = [[[self class] alloc]initWithDic:dic];
        [temp addObject:model];
    }
    return temp;
}


#pragma mark 
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"%s  key = %@ value = %@",__func__,  key,value);

   
}
- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"%s  key = %@ value = nil",__func__,  key);
}
 

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,[self modelToDictionary]];
}

/// 把一个RootModel还原成成一个字典 , 主要为了description使用
- (NSDictionary *)modelToDictionary {
    
    //初始化一个字典
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    //循环并用KVC得到每个属性的值
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        
        id value = [self valueForKey:name]?:@"nil";//默认值为nil字符串
        // model中嵌套了子model
        if ([value isKindOfClass:[RootModel class]]) {
            RootModel * subModel = value ;
            //递归调用子model , 装载到字典里
            [dictionary setObject:[subModel modelToDictionary] forKey:name];
            continue ;
        }
        // model中嵌套了array , array中都是RootModel
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray * subArray = value ;
            NSMutableArray * temp = [[NSMutableArray alloc]initWithCapacity:subArray.count];
            for (RootModel * subModel in subArray) {
                [temp addObject:[subModel modelToDictionary]];
            }
            [dictionary setObject:temp forKey:name];
            continue ;
        }
        //普通属性装载到字典里
        [dictionary setObject:value forKey:name];
    }
    
    //释放
    free(properties);
    
    return dictionary;
    
    
}


+ (NSDictionary *)jsonArraryType{
    return @{};
}
+ (NSDictionary *)propertyNameToJsonKey{
    return @{};
}

// 归档
- (void)encodeWithCoder:(NSCoder*)encoder
{
    unsigned int count;
    Ivar* ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char* name = ivar_getName(ivar);
        NSString* strName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:strName];
        [encoder encodeObject:value forKey:strName];
    }
    free(ivars);
}

// 解档
- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init]) {
        unsigned int count;
        Ivar* ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char* name = ivar_getName(ivar);
            NSString* strName = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:strName];
            [self setValue:value forKey:strName];
        }
        free(ivars);
    }
    return self;
}



@end
