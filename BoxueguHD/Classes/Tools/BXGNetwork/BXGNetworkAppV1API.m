//
//  BXGNetworkAppV1API.m
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/5.
//  Copyright © 2018年 boxuegu. All rights reserved.
//

#import "BXGNetworkAppV1API.h"

@interface BXGNetworkAppV1ParserItem: NSObject

@property (nonatomic, strong) NSNumber *success; // bool true or false
@property (nonatomic, strong) NSString *errorMessage; // 1001 用户验证错误
@property (nonatomic, strong) id resultObject;
@end

@implementation BXGNetworkAppV1ParserItem
@end

@interface BXGNetworkAppV1Parser: NSObject <BXGNetworkParser>
@end

@implementation BXGNetworkAppV1Parser

- (BXGNetworkParserResult *)parserWithResponseObject:(id _Nullable)responseObject {
    BXGNetworkParserResult *result = [BXGNetworkParserResult new];
    
    // 处理状态码
    NSInteger status = 500;
    
    if ([responseObject isKindOfClass:NSDictionary.class]){
        
//        BXGNetworkAppV1ParserItem *item = [BXGNetworkAppV1ParserItem yy_modelWithDictionary:responseObject];
        BXGNetworkAppV1ParserItem *item = [BXGNetworkAppV1ParserItem new];
        if(item) {
            if(item.success.boolValue == true) {
                status = 200;
            }
            if([item.errorMessage isEqualToString:@"1001"]) {
                status = 401;
            }
            
            result.message = item.errorMessage;
            // 处理resultObject
            result.result = item.resultObject;
        }
    }
    result.status = status;
    
    // 处理Error Message
    
    return result;
}

- (BXGNetworkParserResult *)parserWithError:(NSError * _Nullable)error {
    BXGNetworkParserResult *result = [BXGNetworkParserResult new];
    
    // 处理状态码
    NSInteger status = 500;
    
    if(error) {
        status = 408;
    }
    result.status = status;
    
    // 处理Error Message

    return result;
}

@end

#pragma mark - Request

@implementation BXGNetworkAppV1API

- (void)requestLoginUserName:(NSString * _Nonnull)userName
                    Password:(NSString * _Nonnull)password
                    Finished:(BXGNetworkResponseBlockType _Nullable) finished {
    // para
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"username"] = userName;
    para[@"password"] = password;
    
    // url
    NSString *url = @"/user/login/";
    
    // request
    [self requestType:BXGNetWorkManagerRequestPOST URLString:url Parameter:para CachePolicy:BXGNetWorkCachePolicyNone Finished:finished];
}
@end
