//
//  NSNumber+EqualString.h
//  web调用
//
//  Created by 郭朝顺 on 2018/5/4星期五.
//  Copyright © 2018年 乐乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (EqualString)

@property (nonatomic,readonly,copy) NSString * moneyDescription ;
- (BOOL)isEqualToString:(NSString *)aString;


@end
