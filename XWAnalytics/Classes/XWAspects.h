//
//  XWAspects.h
//  Pods-XWAnalytics_Example
//
//  Created by WJF on 2019/6/28.
//

#import <Foundation/Foundation.h>


typedef NS_OPTIONS(NSUInteger, XWAspectOptions) {
    XWAspectPositionAfter   = 0,            /// Called after the original implementation (default)
    XWAspectPositionInstead = 1,            /// Will replace the original implementation.
    XWAspectPositionBefore  = 2,            /// Called before the original implementation.
    
    XWAspectOptionAutomaticRemoval = 1 << 3 /// Will remove the hook after the first execution.
};

/// Opaque Aspect Token that allows to deregister the hook.
@protocol XWAspectToken <NSObject>

/// Deregisters an aspect.
/// @return YES if deregistration is successful, otherwise NO.
- (BOOL)remove;

@end

/// The AspectInfo protocol is the first parameter of our block syntax.
@protocol XWAspectInfo <NSObject>

/// The instance that is currently hooked.
- (id)instance;

/// The original invocation of the hooked method.
- (NSInvocation *)originalInvocation;

/// All method arguments, boxed. This is lazily evaluated.
- (NSArray *)arguments;

@end

/**
 Aspects uses Objective-C message forwarding to hook into messages. This will create some overhead. Don't add aspects to methods that are called a lot. Aspects is meant for view/controller code that is not called a 1000 times per second.
 
 Adding aspects returns an opaque token which can be used to deregister again. All calls are thread safe.
 */
@interface NSObject (XWAspects)

/// Adds a block of code before/instead/after the current `selector` for a specific class.
///
/// @param block Aspects replicates the type signature of the method being hooked.
/// The first parameter will be `id<AspectInfo>`, followed by all parameters of the method.
/// These parameters are optional and will be filled to match the block signature.
/// You can even use an empty block, or one that simple gets `id<AspectInfo>`.
///
/// @note Hooking static methods is not supported.
/// @return A token which allows to later deregister the aspect.
+ (id<XWAspectToken>)aspect_hookSelector:(SEL)selector
                                withOptions:(XWAspectOptions)options
                                 usingBlock:(id)block
                                      error:(NSError **)error;

/// Adds a block of code before/instead/after the current `selector` for a specific instance.
- (id<XWAspectToken>)aspect_hookSelector:(SEL)selector
                                withOptions:(XWAspectOptions)options
                                 usingBlock:(id)block
                                      error:(NSError **)error;

/** 拦截类方法   */
+ (id<XWAspectToken>)aspect_hookClassSelector:(SEL)selector withOptions:(XWAspectOptions)options usingBlock:(id)block error:(NSError *__autoreleasing *)error;

/** 拦截类方法   */
- (id<XWAspectToken>)aspect_hookClassSelector:(SEL)selector withOptions:(XWAspectOptions)options usingBlock:(id)block error:(NSError *__autoreleasing *)error;



@end


typedef NS_ENUM(NSUInteger, XWAspectErrorCode) {
    XWAspectErrorSelectorBlacklisted,                   /// Selectors like release, retain, autorelease are blacklisted.
    XWAspectErrorDoesNotRespondToSelector,              /// Selector could not be found.
    XWAspectErrorSelectorDeallocPosition,               /// When hooking dealloc, only AspectPositionBefore is allowed.
    XWAspectErrorSelectorAlreadyHookedInClassHierarchy, /// Statically hooking the same method in subclasses is not allowed.
    XWAspectErrorFailedToAllocateClassPair,             /// The runtime failed creating a class pair.
    XWAspectErrorMissingBlockSignature,                 /// The block misses compile time signature info and can't be called.
    XWAspectErrorIncompatibleBlockSignature,            /// The block signature does not match the method or is too large.
    
    XWAspectErrorRemoveObjectAlreadyDeallocated = 100   /// (for removing) The object hooked is already deallocated.
};

extern NSString *const XWAspectErrorDomain;
