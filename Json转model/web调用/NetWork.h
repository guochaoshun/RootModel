//
//  NetWork.h
//  web调用
//
//  Created by 郭朝顺 on 2018/12/13星期四.
//  Copyright © 2018年 乐乐. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^callBackBlock)(id data);
@interface NetWork : NSObject

@property (nonatomic,copy) NSString * urlString ;
@property (nonatomic,strong) NSDictionary * parameters ;
@property (nonatomic,copy) callBackBlock success ;
@property (nonatomic,copy) callBackBlock fail ;
- (void)startLoadData ;

@end
