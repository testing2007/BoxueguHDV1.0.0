//
//  BXGNetworkManager.m
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/4.
//  Copyright © 2018年 boxuegu. All rights reserved.
//

#import "BXGNetworkManager.h"

static BXGNetworkManager *_instance;
@implementation BXGNetworkManager
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BXGNetworkManager alloc]initWithSessionConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",@"text/javascript",@"text/xml",@"application/json", @"image/jpeg",@"image/png", nil];
        _instance.requestSerializer.timeoutInterval = 10;
        
        // set header
//        NSString *platform = @"iPad";
        NSString *platform = @"iPhone";
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *version = infoDict[@"CFBundleShortVersionString"];
        [_instance.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"bxg-os"];
        [_instance.requestSerializer setValue:platform forHTTPHeaderField:@"bxg-platform"];
        [_instance.requestSerializer setValue:version forHTTPHeaderField:@"bxg-version"];
    });
    return _instance;
}

- (void)requestType:(BXGNetWorkManagerRequest)type
      BaseURLString:(NSString * _Nullable)baseURLString
          URLString:(NSString * _Nullable) urlString
          Parameter:(id _Nullable)para
           Finished:(void(^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))finished
             Failed:(void(^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failed {
    
    //        andFinished:BXGNetworkFinishedBlockType finished andFailed:BXGNetworkFailedBlockType failed {
    __weak typeof(self) weakSelf = self;
    
    // 公共的参数会被自定义的参数所覆盖
    NSMutableDictionary *mPara = [NSMutableDictionary new];
    if([self.dataSource respondsToSelector:@selector(commonParameter)]) {
        NSDictionary *commonPara = [self.dataSource commonParameter];
        if(commonPara) {
            // 添加公共参数
            [mPara setDictionary:commonPara];
        }
    }
    if(para){
        // 添加自定义参数
        [mPara setDictionary:para];
    }
    
    // 路径拼接
    
    NSAssert(baseURLString, @"baseURLString is nil");
    
    NSString *absolutePath = [baseURLString stringByAppendingPathComponent:urlString];
    
    // 设置回调
    void(^success)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)  = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf logWithTask:task responseObject:responseObject error:nil parameter:mPara];
        if(finished) {
            finished(task, responseObject);
        }

    };
    void(^failure)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf logWithTask:task responseObject:nil error:error parameter:mPara];
        if(failed) {
            failed(task, error);
        }

    };
    void(^progress)(NSProgress * _Nonnull Progress) = ^(NSProgress * _Nonnull Progress) {
        
    };
    
    switch(type) {
        case BXGNetWorkManagerRequestGET:
            [[BXGNetworkManager shared] GET:absolutePath parameters:mPara progress:progress success:success failure:failure];
            break;
        case BXGNetWorkManagerRequestPOST:
            [[BXGNetworkManager shared] POST:absolutePath parameters:mPara progress:progress success:success failure:failure];
            break;
    }
    
}


// 日志功能
- (void)logWithTask:(NSURLSessionDataTask * _Nonnull)task responseObject:(id  _Nullable)responseObject error:(NSError* _Nullable)error parameter:(NSDictionary * _Nullable)parameter {
    BXGNetworkLog(@"\nURL:\n%@\nHeader:\n%@\nBody:\n%@\nResponse:\n%@\nError:\n%@\n",
                 task.currentRequest.URL,
                 task.currentRequest.allHTTPHeaderFields,
                 parameter,
                 responseObject,
                  error);
}




@end
