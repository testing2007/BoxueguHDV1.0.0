//
//  BXGNetworkAPI.m
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/5.
//  Copyright © 2018年 boxuegu. All rights reserved.
//

#import "BXGNetworkAPI.h"


@implementation BXGNetworkParserResult
@end

@implementation BXGNetworkAPI

- (void)requestType:(BXGNetWorkManagerRequest)type
          URLString:(NSString * _Nullable)urlString
          Parameter:(NSDictionary* _Nullable)para
        CachePolicy:(BXGNetWorkCachePolicy)cachePolicy
           Finished:(BXGNetworkResponseBlockType)finished {
    
    __weak typeof(self) weakSelf = self;
    
    [[BXGNetworkManager shared] requestType:type BaseURLString:self.baseURL URLString:urlString Parameter:para Finished:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf result:[weakSelf.parser parserWithResponseObject:responseObject] Finished:finished];
    } Failed:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf result:[weakSelf.parser parserWithError:error] Finished:finished];
    }];
}

- (void)result:(BXGNetworkParserResult *)parserResut Finished:(BXGNetworkResponseBlockType)finished {
    if(finished) {
        finished(parserResut.status, parserResut.result, parserResut.message);
    }
}
@end
