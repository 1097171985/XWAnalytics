//
//  XWViewController.m
//  XWAnalytics
//
//  Created by 1097171985 on 06/28/2019.
//  Copyright (c) 2019 1097171985. All rights reserved.
//

#import "XWViewController.h"

#import "XWVC1.h"
#import "XWVC2.h"
@interface XWViewController ()

@end

@implementation XWViewController

+ (void)load{
    
//    [XWAnalyticsManager xw];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 200, 30);
    button.center = self.view.center;
    [button setTitle:@"页面统计" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(0, 0, 200, 30);
    button1.center = CGPointMake(self.view.center.x, self.view.center.y+50) ;
    
    [button1 setTitle:@"事件统计" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clicked1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    [self aspect_hookSelector:@selector(viewDidAppear:) withOptions:XWAspectPositionAfter usingBlock:^(id data){
        NSLog(@"=======111111111========");
    } error:nil];
    [self aspect_hookSelector:@selector(viewDidDisappear:) withOptions:XWAspectPositionAfter usingBlock:^(id data){
        NSLog(@"=======22222222222========");
    } error:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clicked{
    
    XWVC1 *jkaVC = [XWVC1 new];
    [self.navigationController pushViewController:jkaVC animated:YES];
    
}

- (void)clicked1{
    
    XWVC2 *jkbVC = [XWVC2 new];
    [self.navigationController pushViewController:jkbVC animated:YES];
    
}


@end
