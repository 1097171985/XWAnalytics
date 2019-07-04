//
//  XWVC3.m
//  XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//  Copyright © 2019 1097171985. All rights reserved.
//

#import "XWVC3.h"

@interface XWVC3 ()

@end

@implementation XWVC3

+ (void)load{
    
    [XWAnalyticsManager analyticsEvents:NSStringFromClass([self class]) methods:@"JKClicked1" position:@"vc3p" name:@"vc3n" url:@"vc3url" productType:@"vc3pr"];
    [XWAnalyticsManager analyticsEvents:NSStringFromClass([self class]) methods:@"JKClicked" position:@"vc3p1" name:@"vc3n1" url:@"vc3url1" productType:@"vc3pr1"];
    [XWAnalyticsManager analyticsEvents:NSStringFromClass([self class]) methods:@"testAAA" position:@"vc3p2" name:@"vc3n2" url:@"vc3url2" productType:@"vc3pr2"];
    [XWAnalyticsManager analyticsEvents:NSStringFromClass([self class]) methods:@"+testFun" position:@"vc3p3" name:@"vc3n3" url:@"vc3url3" productType:@"vc3pr3"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(0, 100, 200, 30);
    
    [button1 setTitle:@"click事件" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(JKClicked1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(0, 200, 200, 30);
    
    [button2 setTitle:@"类方法事件" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(JKClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    // Do any additional setup after loading the view.
}

- (void)JKClicked1{
    
    NSLog(@"JKClicked 2");
    
}


- (void)JKClicked{
    
    [XWVC3 testFun];
//    [self testAAA];
    
    
}

+ (void)testFun{
    NSLog(@"testFun");
}

- (void)testAAA{
    NSLog(@"testAAA");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
