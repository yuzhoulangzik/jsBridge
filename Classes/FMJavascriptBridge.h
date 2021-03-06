//
//  FMJavascriptBridge.h
//  Pods
//
//  Created by carl on 16/2/3.
//
//

#import <Foundation/Foundation.h>

@protocol FMWebViewJavascriptDelegate<NSObject>
@required
- (void)evaluateJavaScript:(NSString *)javaScriptString
         completionHandler:
             (void (^)(id result, NSError *error))completionHandler;
@end

@interface FMJavascriptBridge : NSObject

@property(assign) id<FMWebViewJavascriptDelegate> delegate;

@property(assign) NSUInteger numRequestsLoading;

/**
 * enable log
 */
+ (void)enableLogging;

/**
 * 设置log max length default is 500
 *
 *  @param length
 */
+ (void)setLogMaxLength:(NSUInteger)length;

/**
 *  初始化bridge
 *
 *  @param bundle js 文件所在的bundle
 *
 *  @return
 */
- (instancetype)initWithResourceBundle:(NSBundle *)bundle;

@end
