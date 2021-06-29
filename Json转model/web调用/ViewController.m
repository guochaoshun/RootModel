//
//  ViewController.m
//  web调用
//
//  Created by 郭朝顺 on 2018/4/21星期六.
//  Copyright © 2018年 乐乐. All rights reserved.
//

#import "ViewController.h"
#import "NSNumber+EqualString.h"
#import "Person.h"
#import "NetWork.h"
#import "Response.h"
#import "Teacher.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test2];

}


// 模型中存在嵌套模型
- (void)test1 {

    NSDictionary *responseDic = @{@"resultCode":@(200),
                                  @"resultMsg":@"请求成功",
                                  @"success":@(YES),
                                  @"teacher":@{@"school":@"高中",
                                               @"subject":@"数学",
                                               @"schoolId":@(1000),
                                               @"name":@"王XX",
                                               @"job":@"老师",
                                  },
    };
    Response *responseModel = [[Response alloc] initWithDic:responseDic];
    NSLog(@"%@",responseModel);

    NSLog(@"%@",responseModel.teacher);
    NSAssert([responseModel.teacher isMemberOfClass:[Teacher class]], @"出错了,模型中存在嵌套模型,转换失败");

}


// 模型中存在数组,数组内是一组model
- (void)test2 {
    NSDictionary *response = @{@"resultCode":@(200),
                               @"resultMsg":@"请求成功",
                               @"resultInfo":@[
                                       @{
                                           @"name":@"用户1",
                                           @"job":@"卖萌",
                                       },@{
                                           @"name":@"用户2",
                                           @"job":@"卖苹果",
                                       },@{
                                           @"name":@"用户1",
                                           @"job":@"卖香蕉",
                                       },
                               ],
    };
    Response *respone = [[Response alloc] initWithDic:response];
    NSLog(@"%@",respone);

    NSLog(@"%@",respone.resultInfo.description);
    NSAssert([respone.resultInfo.firstObject isMemberOfClass:[Person class]], @"出错了,模型中存在数组,转换失败");

}

// 模型中存在继承链
- (void)test3 {
    NSDictionary * dic = @{@"school":@"高中",
                           @"subject":@"数学",
                           @"schoolId":@(1000),
                           @"name":@"王XX",
                           @"job":@"老师",
    };
    Teacher *teacher = [[Teacher alloc] initWithDic:dic];
    NSLog(@"%@",teacher);
    NSAssert(teacher.name, @"转换失败,模型中存在继承链,父类属性没有转换成功");

    /// KVC内部会帮我们做类型转换,转成对应的基本类型, 不论是传入NSNumber还是NSString类型
    [teacher setValue:@"222" forKey:@"schoolId"];
    NSLog(@"字符串类型: %zd ",teacher.schoolId);

    [teacher setValue:@(333) forKey:@"schoolId"];
    NSLog(@"NSNumber类型: %zd ",teacher.schoolId);
}



- (void)loadData:(id)sender {
    
    NetWork * network = [[NetWork alloc] init] ;
    network.urlString = @"http://qz.test.internet.zhiwangyilian.com/api/client-community/client/community/hot/hotList";
    network.parameters = @{@"pageIndex":@"0",
                           @"pageSize":@"2",
    };
    network.success = ^(NSDictionary * data) {
        
        Response * re = [[Response alloc] initWithDic:data];
        NSLog(@"%@ %@",[re.page class],re.page);
        NSLog(@"%@",re);
        
    };
    network.fail = ^(NSError * error) {
        NSLog(@"%@",error);
    };
    [network startLoadData];
    
}

@end
