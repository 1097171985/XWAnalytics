//
//  XWAnalyticsManager.m
//  Pods-XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//

#import "XWAnalyticsManager.h"

#import <XWFMDB/XWDBManager.h>

NSString const *XWPVKey = @"PV";
NSString const *XWEventKey = @"Events";
NSString const *XWEventIDKey = @"EventID";
NSString const *XWEventConfigKey = @"EventConfig";
NSString const *XWSelectorStrKey = @"selectorStr";
NSString const *XWTargetKey = @"target";

//设置俩张表
#define XWPV     @"XWPV"
#define XWEvents @"XWEvents"

@interface XWAnalyticsManager()

@property (nonatomic,strong,readwrite) NSDictionary *configureData;

@end

@implementation XWAnalyticsManager

static XWAnalyticsManager *_ubs =nil;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ubs = [XWAnalyticsManager new];
       
    });
    return _ubs;
}

//+ (void)configureDataWithJSONFile:(NSString *)jsonFilePath{
//    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    [XWAnalyticsManager shareInstance].configureData = dic;
//    if ([XWAnalyticsManager shareInstance].configureData) {
//        [self setUp];
//    }
//}
//
//+ (void)configureDataWithPlistFile:(NSString *)plistFileName{
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistFileName ofType:@"plist"]];
//    [XWAnalyticsManager shareInstance].configureData = dic;
//    if ([XWAnalyticsManager shareInstance].configureData) {
//        [self setUp];
//    }
//}

/**
 统计页面
 
 @param sourcevc sourcevc description
 */
+ (void)analyticsPV:(NSString *)sourcevc{
    
    XWAnalyticsModel *pvModel = [[XWAnalyticsModel alloc]init];
    pvModel.xw_tableName = XWPV;
    pvModel.sourcevc = sourcevc;
    pvModel.methods = @"viewshoworhidden";
    pvModel.isPv = YES;
    pvModel.isHook = NO;
    [pvModel xw_save];
    
    NSArray *pv = [XWAnalyticsModel xw_findAll:XWPV];
    if (pv.count > 0) {
         [self configPV];
    }
    
}

/**
 统计事件
 
 @param sourcevc sourcevc description
 @param methods 方法（实例方法 直接方法名 类似：analyticsEvents。类方法 +方法名，类似：+analyticsEvents）
 @param position 位置信息
 @param name 名称
 @param url url
 @param productType productType description
 */
+ (void)analyticsEvents:(NSString *)sourcevc methods:(NSString *)methods position:(NSString *)position name:(NSString *)name url:(NSString *)url productType:(NSString *)productType{
    
    XWAnalyticsModel *pvModel = [[XWAnalyticsModel alloc]init];
    pvModel.xw_tableName = XWEvents;
    pvModel.sourcevc = sourcevc;
    pvModel.methods  = methods;
    pvModel.position = position;
    pvModel.name = name;
    pvModel.url  = url;
    pvModel.productType  = productType;
    pvModel.isPv = NO;
    pvModel.isHook = NO;
    [pvModel xw_save];
    
    NSArray *events = [XWAnalyticsModel xw_findAll:XWEvents];
    if (events.count > 0) {
         [self configEvents];
    }
}

/**  设置数据库信息  */
- (void)settingFmdbInfo{
    [XWDBManager shareManager].sqliteName = @"xwanalytics";
}


//MARK:PVConfig
+ (void)configPV{
    
    NSArray *pv = [XWAnalyticsModel xw_findAll:XWPV];
    for (XWAnalyticsModel *pvModel in pv) {
        if(!pvModel.isHook){
            pvModel.xw_tableName = XWPV;
            Class target = NSClassFromString(pvModel.sourcevc);
            [target aspect_hookSelector:@selector(viewDidAppear:) withOptions:XWAspectPositionAfter usingBlock:^(id data){
                [self JKhandlePV:data status:XWPV_ENTER];
            } error:nil];
            [target aspect_hookSelector:@selector(viewDidDisappear:) withOptions:XWAspectPositionAfter usingBlock:^(id data){
                [self JKhandlePV:data status:XWPV_LEAVE];
            } error:nil];
            pvModel.isHook = YES;
            [pvModel xw_saveOrUpdateAsync:^(BOOL isSuccess) {

            }];
        }
    }
    
}

+ (void)JKhandlePV:(id<XWAspectInfo>)data status:(XWPVSTATUS)status{
    
    NSString *vcName = NSStringFromClass([[data instance] class]);
    NSString* where = [NSString stringWithFormat:@"where %@=%@",xw_sqlKey(@"sourcevc"),xw_sqlValue(vcName)];
    NSArray* arr = [XWAnalyticsModel xw_find:XWPV where:where];
    if (arr.count > 0) {
        if (status ==XWPV_ENTER) {
            NSLog(@"111---enter data:%@",arr[0]);
        }else{
            NSLog(@"111---leave data:%@",arr[0]);
        }
    }
    
}

//MARK: EventConfig
+ (void)configEvents{
    NSArray *events = [XWAnalyticsModel xw_findAll:XWEvents];
    for (XWAnalyticsModel *eventsModel in events) {
        if (!eventsModel.isHook) {
            Class target =NSClassFromString(eventsModel.sourcevc);
            NSString *selectorStr = eventsModel.methods;
            if ([selectorStr hasPrefix:@"+"]) {
                selectorStr = [selectorStr substringFromIndex:1];
                SEL selector = NSSelectorFromString(selectorStr);
                [target  aspect_hookClassSelector:selector withOptions:XWAspectPositionAfter usingBlock:^(id<XWAspectInfo> data){
                    [self JKHandleEvent:data eventModel:eventsModel];
                } error:nil];
            }else{
                SEL selector = NSSelectorFromString(selectorStr);
                [target aspect_hookSelector:selector withOptions:XWAspectPositionAfter usingBlock:^(id<XWAspectInfo> data){
                    [self JKHandleEvent:data eventModel:eventsModel];
                } error:nil];
            }
            eventsModel.xw_tableName = XWEvents;
            eventsModel.isHook = YES;
            [eventsModel xw_saveOrUpdateAsync:^(BOOL isSuccess) {
                
            }];
        }
    }
}

+ (void)JKHandleEvent:(id<XWAspectInfo>)data eventModel:(XWAnalyticsModel *)eventModel{
    
    NSLog(@"222----eventModel:%@",eventModel);
    
    
}

@end
