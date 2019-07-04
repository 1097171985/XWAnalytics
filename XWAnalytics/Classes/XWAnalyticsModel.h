//
//  XWAnalyticsModel.h
//  FMDB
//
//  Created by WJF on 2019/6/28.
//

#import <Foundation/Foundation.h>
#import <XWFMDB/XWFMDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface XWAnalyticsModel : NSObject

/**  当前所在的控制器  */
@property (nonatomic, copy) NSString *sourcevc;
/**  方法名 （实例方法 直接方法名 类似：analyticsEvents。类方法 +方法名，类似：+analyticsEvents） */
@property (nonatomic, copy) NSString *methods;
/**  当前统计的是pv 还是 events  */
@property (nonatomic, assign) BOOL isPv;
/**  位置信息  */
@property (nonatomic, copy) NSString *position;
/**  名称  */
@property (nonatomic, copy) NSString *name;
/** 本地的地址或者h5的地址 也可以不传 */
@property (nonatomic, copy) NSString *url;
/**    */
@property (nonatomic, copy) NSString *productType;
/**  是否hook了  */
@property (nonatomic, assign) BOOL isHook;

@end

NS_ASSUME_NONNULL_END
