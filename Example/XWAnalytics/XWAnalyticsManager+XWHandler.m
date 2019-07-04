//
//  XWAnalyticsManager+XWHandler.m
//  XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//  Copyright © 2019 1097171985. All rights reserved.
//

#import "XWAnalyticsManager+XWHandler.h"

@implementation XWAnalyticsManager (XWHandler)


+(void)JKhandlePV:(id<XWAspectInfo>)data status:(XWPVSTATUS)status{
    
    NSString *vcName = NSStringFromClass([[data instance] class]);
    XWAnalyticsModel *dic = [XWAnalyticsManager shareInstance].analyticsModel;
    if (status ==XWPV_ENTER) {
        NSLog(@"enter data:%@",dic);
    }else{
        NSLog(@"leave data:%@",dic);
    }
}

+(void)JKHandleEvent:(id<XWAspectInfo>)data eventModel:(nonnull XWAnalyticsModel *)eventModel{
    NSLog(@"eventId:%@",eventModel);
    
    
}


@end
