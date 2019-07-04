//
//  XWVC4.m
//  XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//  Copyright © 2019 1097171985. All rights reserved.
//

#import "XWVC4.h"

@interface XWVC4 ()

@end

@implementation XWVC4

+ (void)load{
    
    [XWAnalyticsManager analyticsEvents:NSStringFromClass([self class]) methods:@"JKClicked" position:@"vc4p" name:@"vc4n" url:@"vc4url" productType:@"vc4pr"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JKClicked)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}
- (void)JKClicked{
    
    NSLog(@"JKClicked : tap");
}

@end
