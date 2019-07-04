//
//  XWAnalyticsManager.h
//  Pods-XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//

#import <Foundation/Foundation.h>
#import "XWAspects.h"
#import "XWAnalyticsModel.h"
NS_ASSUME_NONNULL_BEGIN

extern NSString const *XWPVKey;
extern NSString const *XWEventKey;
extern NSString const *XWEventIDKey;
extern NSString const *XWEventConfigKey;
extern NSString const *XWSelectorStrKey;
extern NSString const *XWTargetKey;

typedef NS_ENUM(NSInteger, XWPVSTATUS){
    XWPV_ENTER = 0,         //进入页面
    XWPV_LEAVE              //离开页面
};


@interface XWAnalyticsManager : NSObject

@property (nonatomic,strong,readonly) XWAnalyticsModel *analyticsModel;
/**
 生成单例的方法
 
 @return 单例对象
 */
+ (instancetype)shareInstance;


/**
 统计页面

 @param sourcevc sourcevc description
 */
+ (void)analyticsPV:(NSString *)sourcevc;

/**
 统计事件

 @param sourcevc sourcevc description
 @param methods 方法（实例方法 直接方法名 类似：analyticsEvents。类方法 +方法名，类似：+analyticsEvents）
 @param position 位置信息
 @param name 名称
 @param url url
 @param productType productType description
 */
+ (void)analyticsEvents:(NSString *)sourcevc methods:(NSString *)methods position:(NSString *)position name:(NSString *)name url:(NSString *)url productType:(NSString *)productType;


///**
// 通过json配置文件导入配置信息
// json配置文件或plist配置文件只导入一个就好了
// @param jsonFilePath json文件沙盒路径
// */
//+ (void)configureDataWithJSONFile:(NSString *)jsonFilePath;
//
///**
// 通过plist配置文件导入配置信息
// json配置文件或plist配置文件只导入一个就好了
// @param plistFileName plist文件名字（不带后缀名）
// */
//+ (void)configureDataWithPlistFile:(NSString *)plistFileName;

/**
 处理PV
 这个方法需要开发者重载进行具体的操作
 @param data 页面信息
 @param status 进入或离开页面的状态
 */
+ (void)JKhandlePV:(id<XWAspectInfo>)data status:(XWPVSTATUS)status;

/**
 处理事件
 这个方法需要开发者重载进行具体的操作
 @param data 事件信息
 @param eventModel 事件eventModel 
 */
+ (void)JKHandleEvent:(id<XWAspectInfo>)data eventModel:(XWAnalyticsModel *)eventModel;

@end

NS_ASSUME_NONNULL_END
