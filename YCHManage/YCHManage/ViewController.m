//
//  ViewController.m
//  YCHManage
//
//  Created by sunny on 2020/6/8.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *url = @"api/4/news/latest";
    [[ZBNetworking shaerdInstance]getWithUrl:url cache:NO params:nil progressBlock:^(int64_t bytesRead, int64_t totalBytes) {
        NSLog(@"%lld--%lld",bytesRead,totalBytes);
        //        [NSThread sleepForTimeInterval:2];
    } successBlock:^(id response) {
        NSLog(@"%@",response);
        //        User *user = [User mj_objectWithKeyValues:response];
        //        DBLOG(@"%@,%@",user.stories[0][@"title"],user.stories[0][@"id"]);
    } failBlock:^(NSError *error) {
        //        NSLog(@"%@",error);
        [[ZBNetworking shaerdInstance] totalCacheSize];
    }];
    NSLog(@"缓存size is %lu",[[ZBNetworking shaerdInstance] totalCacheSize]);
}

@end
