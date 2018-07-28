//
//  BXGNetworkManager.h
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/4.
//  Copyright © 2018年 boxuegu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define BXGNetworkLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

typedef NS_ENUM(NSUInteger, BXGNetWorkManagerRequest) {
    BXGNetWorkManagerRequestGET = 0,
    BXGNetWorkManagerRequestPOST = 1,
};

@class BXGNetworkManager;

//typedef void(^BXGNetworkResponseBlockType)(id responseObject, NSError *error);

@protocol BXGNetworkManagerDataSource<NSObject>

@optional
- (NSDictionary * _Nonnull)commonParameter;
@end

@protocol BXGNetworkManagerDelegate<NSObject>

@optional
- (void)networkManager:(BXGNetworkManager *)manager;
@end

@interface BXGNetworkManager : AFHTTPSessionManager
+ (instancetype)shared;

- (void)requestType:(BXGNetWorkManagerRequest)type
      BaseURLString:(NSString * _Nullable)baseURLString
          URLString:(NSString * _Nullable)urlString
          Parameter:(id _Nullable)para
           Finished:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))finished
             Failed:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failed;

@property (nonatomic, weak, nullable) id<BXGNetworkManagerDelegate> delegate;
@property (nonatomic, weak, nullable) id<BXGNetworkManagerDataSource> dataSource;
@end
