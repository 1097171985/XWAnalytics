//
//  XWVC1.m
//  XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//  Copyright © 2019 1097171985. All rights reserved.
//

#import "XWVC1.h"

@interface XWVC1 ()

@end

@implementation XWVC1

+ (void)load{
    
    [XWAnalyticsManager analyticsPV:NSStringFromClass([self class])];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self aspect_hookSelector:@selector(viewDidAppear:) withOptions:XWAspectPositionAfter usingBlock:^(id data){
        NSLog(@"=======111111111========");
    } error:nil];
    [self aspect_hookSelector:@selector(viewDidDisappear:) withOptions:XWAspectPositionAfter usingBlock:^(id data){
        NSLog(@"=======22222222222========");
    } error:nil];
    // Do any additional setup after loading the view.
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
