//
//  ViewController.m
//  MyUIDemo
//
//  Created by Bob on 2018/12/21.
//  Copyright © 2018年 seabrea. All rights reserved.
//

#import "ViewController.h"
#import "SeaHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)inClickButton:(UIButton *)sender {
    
    if(sender.tag == 10000) {
        
        [SeaHUD alertTitle:@"这是标题" Content:@"这时内容这时内容这时内容这时内容这时内容" Confirm:^{
            NSLog(@"点击确定按钮");
        }];
    }
    else if(sender.tag == 10001) {
        NSArray<NSString *> *list = @[@"这时选择项0",@"这时选择项1",@"这时选择项2",@"这时选择项3",@"这时选择项4",@"这时选择项5",@"这时选择项6"];
        [SeaHUD popActionSheetList:list CloseTitle:@"这时关闭按钮" SelectAction:^(NSUInteger selectIndex) {
            NSLog(@"这时选择项%lu",selectIndex);
        }];
    }
    else if(sender.tag == 10002) {
        
    }
    else if(sender.tag == 10003) {
        
    }
    else if(sender.tag == 10004) {
        
    }
    else if(sender.tag == 10005) {
        
    }
}


@end
