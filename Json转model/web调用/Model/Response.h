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
@interface Response : RootModel


@property (nonatomic,strong) NSNumber * resultCode ;
@property (nonatomic,copy) NSString * resultMsg ;
@property (nonatomic,strong) PageModel * page ;
// 测试本地属性和服务器属性的映射
@property (nonatomic,strong) NSNumber * isSuccess ;

@property (nonatomic,strong) NSArray <Person *> * resultInfo ;

@end
