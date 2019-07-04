//
//  XWAnalyticsModel.m
//  FMDB
//
//  Created by WJF on 2019/6/28.
//

#import "XWAnalyticsModel.h"

@implementation XWAnalyticsModel

/**
 自定义“联合主键” 
 */
+(NSArray *)xw_unionPrimaryKeys{
    return @[@"sourcevc",@"methods"];
}



@end
