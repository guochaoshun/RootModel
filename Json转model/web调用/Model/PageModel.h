//
//  PageModel.h
//  web调用
//
//  Created by 郭朝顺 on 2019/1/2星期三.
//  Copyright © 2019年 乐乐. All rights reserved.
//

#import "RootModel.h"

@interface PageModel : RootModel

@property (nonatomic,strong) NSNumber * pageIndex ;
@property (nonatomic,strong) NSNumber * pageSize ;
@property (nonatomic,strong) NSNumber * totalCount ;


@end
