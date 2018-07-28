//
//  BXGNetworkAPI.h
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/5.
//  Copyright © 2018年 boxuegu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGNetworkCacheManager.h"
#import "BXGNetworkManager.h"


typedef void(^BXGNetworkResponseBlockType)(NSInteger status, id result, NSString *message);
//@class BXGNetworkCacheManager;
// 处理 cache and parser

@interface BXGNetworkParserResult: NSObject
@property (nonatomic, assign) NSUInteger status;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSString *message;
@end


@protocol BXGNetworkParser<NSObject>
// 同步
- (BXGNetworkParserResult *)parserWithResponseObject:(id _Nullable)responseObject;
- (BXGNetworkParserResult *)parserWithError:(NSError * _Nullable)error;
@end


@interface BXGNetworkAPI : NSObject

@property (nonatomic, strong) id<BXGNetworkParser> parser;
@property (nonatomic, strong) NSString *baseURL;

- (void)requestType:(BXGNetWorkManagerRequest)type
          URLString:(NSString * _Nullable)urlString
          Parameter:(NSDictionary * _Nullable)para
        CachePolicy:(BXGNetWorkCachePolicy)cachePolicy
           Finished:(BXGNetworkResponseBlockType)finished;
@end
