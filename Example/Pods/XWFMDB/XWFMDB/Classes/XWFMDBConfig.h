//
//  XWFMDBConfig.h
//  Pods
//
//  Created by WJF on 2019/6/28.
//

#ifndef XWFMDBConfig_h
#define XWFMDBConfig_h

// 过期方法注释
#define XWFMDBDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#define xw_primaryKey @"xw_id"
#define xw_createTimeKey @"xw_createTime"
#define xw_updateTimeKey @"xw_updateTime"

//keyPath查询用的关系，xw_equal:等于的关系；xw_contains：包含的关系.
#define xw_equal @"Relation_Equal"
#define xw_contains @"Relation_Contains"

#define xw_complete_B void(^_Nullable)(BOOL isSuccess)
#define xw_complete_I void(^_Nullable)(xw_dealState result)
#define xw_complete_A void(^_Nullable)(NSArray* _Nullable array)
#define xw_changeBlock void(^_Nullable)(xw_changeState result)

typedef NS_ENUM(NSInteger,xw_changeState){//数据改变状态
    xw_insert,//插入
    xw_update,//更新
    xw_delete,//删除
    xw_drop//删表
};

typedef NS_ENUM(NSInteger,xw_dealState){//处理状态
    xw_error = -1,//处理失败
    xw_incomplete = 0,//处理不完整
    xw_complete = 1//处理完整
};

typedef NS_ENUM(NSInteger,xw_sqliteMethodType){//sqlite数据库原生方法枚举
    xw_min,//求最小值
    xw_max,//求最大值
    xw_sum,//求总和值
    xw_avg//求平均值
};

typedef NS_ENUM(NSInteger,xw_dataTimeType){
    xw_createTime,//存储时间
    xw_updateTime,//更新时间
};

/**
 封装处理传入数据库的key和value.
 */
extern NSString* _Nonnull xw_sqlKey(NSString* _Nonnull key);
/**
 转换OC对象成数据库数据.
 */
extern NSString* _Nonnull xw_sqlValue(id _Nonnull value);
/**
 根据keyPath和Value的数组, 封装成数据库语句，来操作库.
 */
extern NSString* _Nonnull xw_keyPathValues(NSArray* _Nonnull keyPathValues);
/**
 直接执行sql语句;
 @tablename nil时以cla类名为表名.
 @cla 要操作的类,nil时返回的结果是字典.
 提示：字段名要增加XW_前缀
 */
extern id _Nullable xw_executeSql(NSString* _Nonnull sql,NSString* _Nullable tablename,__unsafe_unretained _Nullable Class cla);
/**
 自定义数据库名称.
 */
extern void xw_setSqliteName(NSString*_Nonnull sqliteName);
/**
 删除数据库文件
 */
extern BOOL xw_deleteSqlite(NSString*_Nonnull sqliteName);
/**
 设置操作过程中不可关闭数据库(即closeDB函数无效).
 默认是NO.
 */
extern void xw_setDisableCloseDB(BOOL disableCloseDB);
/**
 手动关闭数据库.
 */
extern void xw_closeDB();
/**
 设置调试模式
 @debug YES:打印调试信息, NO:不打印调试信息.
 */
extern void xw_setDebug(BOOL debug);

/**
 事务操作.
 @return 返回YES提交事务, 返回NO回滚事务.
 */
extern void xw_inTransaction(BOOL (^ _Nonnull block)());

/**
 清除缓存
 */
extern void xw_cleanCache();

#endif /* XWFMDBConfig_h */
