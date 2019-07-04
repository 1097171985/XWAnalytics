//
//  NSCache+XWCache.m
//  FMDB
//
//  Created by WJF on 2019/6/28.
//

#import "NSCache+XWFmdb.h"

static NSCache* keyCaches;

@implementation NSCache (XWFmdb)

+(instancetype)xw_cache{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyCaches = [NSCache new];
    });
    return keyCaches;
}

@end
