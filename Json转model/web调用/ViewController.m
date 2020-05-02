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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData:nil];
    

}

- (IBAction)loadData:(id)sender {
    
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
