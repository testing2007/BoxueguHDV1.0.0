//
//  BXGNetworkCacheManager.h
//  Boxuegu
//
//  Created by Renying Wu on 2018/5/4.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BXGNetWorkCachePolicy) {
    BXGNetWorkCachePolicyNone = 0,
    BXGNetWorkCachePolicyLoadFailedReturnCacheData = 1,
};

@interface BXGNetworkCacheManager : NSObject
+ (id)loadCache:(BXGNetWorkCachePolicy)cachePolicy WithURL:(NSString *)url para:(NSDictionary *)para;
+ (BOOL)saveCache:(BXGNetWorkCachePolicy)cachePolicy WithURL:(NSString *)url para:(NSDictionary *)para responseObject:(id)obj;
+ (void)clearLoadFailedReturnCacheDataPolicyCache;
@end
