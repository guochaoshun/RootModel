//
//  Teacher.h
//  web调用
//
//  Created by 郭朝顺 on 2021/6/29.
//  Copyright © 2021 乐乐. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teacher : Person

@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, copy) NSString *title;


@end

NS_ASSUME_NONNULL_END
