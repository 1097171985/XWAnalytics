//
//  XWVC5.m
//  XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//  Copyright © 2019 1097171985. All rights reserved.
//

#import "XWVC5.h"

@interface XWVC5 ()

@end

@implementation XWVC5

+ (void)load{
    
    [XWAnalyticsManager analyticsPV:NSStringFromClass([self class])];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
