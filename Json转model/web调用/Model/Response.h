//
//  Response.h
//  web调用
//
//  Created by 郭朝顺 on 2019/1/2星期三.
//  Copyright © 2019年 乐乐. All rights reserved.
//

#import "RootModel.h"
#import "PageModel.h"
#import "Person.h"
#import "Teacher.h"
@interface Response : RootModel

/// KVC内部会帮我们做类型转换,转成对应的基本类型, 不论是传入NSNumber还是NSString类型,resultCode的值都正确
@property (nonatomic,assign) NSInteger resultCode ;

@property (nonatomic,copy) NSString * resultMsg ;
@property (nonatomic,strong) PageModel * page ;
@property (nonatomic, strong) Teacher *teacher;
// 测试本地属性和服务器属性的映射
@property (nonatomic,strong) NSNumber * isSuccess ;

@property (nonatomic,strong) NSArray <Person *> * resultInfo ;

@end
