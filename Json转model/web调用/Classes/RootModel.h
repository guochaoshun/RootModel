//
//  ZWYLModel.h
//  ZWYL_iOS
//
//  Created by 李雅珠 on 4/14/17.
//  Copyright © 2017 zwyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootModel : NSObject<NSCoding>

/// json中嵌套了数组,数组中是一个个的RootModel子类,需要重写这个,把json中的key和model的子类名字映射
@property (nonatomic,readonly,class,strong) NSDictionary * jsonArraryType ;

/// 属性名字映射到json中的Key , 比如属性的名字叫userID , 服务返回叫id , @{@"userID":@"id"}
@property (nonatomic,readonly,class,strong) NSDictionary * propertyNameToJsonKey ;


- (instancetype)initWithDic:(NSDictionary *)dic ;

/// 传入一个数组,里面是一个个字典, 返回一个当前model组成的数组
+ (NSMutableArray *)modelArrayWithDicArray:(NSArray *)dicArray;

@end
