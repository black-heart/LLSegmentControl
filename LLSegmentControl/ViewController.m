//
//  ViewController.m
//  LLSegmentControl
//
//  Created by lll on 16/8/15.
//  Copyright © 2016年 llliu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"测试"];
    LLSegmentView * view = [[LLSegmentView alloc] initWithButtonTitles:@[@"第一",@"第二",@"第三"]];
    view.selected = 2;
    view.delegate = self;
    [self.view addSubview:view];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2., self.view.frame.size.width, self.view.frame.size.height/2.)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text          = [NSString stringWithFormat:@"默认第%ld个",(long)view.selected + 1];
    label.tag           = 100;
    [self.view addSubview:label];
}

-(void)segmentViewButtonPress:(int)index {
    UILabel * label = [self.view viewWithTag:100];
    label.text = [NSString stringWithFormat:@"点击了第%d个",index + 1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
