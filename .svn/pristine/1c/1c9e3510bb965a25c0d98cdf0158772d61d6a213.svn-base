//
//  BXGNetworkCacheManager.m
//  Boxuegu
//
//  Created by Renying Wu on 2018/5/4.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "BXGNetworkCacheManager.h"
#import "BXGNetworkCacheFileManager.h"
#import "NSString+BXGNetworkCache.h"

#define LoadFailedReturnCacheDataPolicyCacheDir @"LoadFailedReturnCacheDataPolicyCache"

@implementation BXGNetworkCacheManager

#pragma mark - Config

+ (NSString *)cachePathForLoadFailedReturnCacheDataPolicyPath {
    NSString *cachePath = [BXGNetworkCacheFileManager getCachePath];
    cachePath = [cachePath stringByAppendingPathComponent:LoadFailedReturnCacheDataPolicyCacheDir];
    return cachePath;
}

+ (NSString *)suffix {
    return @".cache";
}

#pragma mark - Function

+ (id)loadCache:(BXGNetWorkCachePolicy)cachePolicy WithURL:(NSString *)url para:(NSDictionary *)para {
    NSString *cacheKey = [self parseToCacheModelWithURL:url para:para];
    switch (cachePolicy) {
        case BXGNetWorkCachePolicyLoadFailedReturnCacheData:
            return [self loadLoadFailedReturnCacheDataPolicyWithCacheKey:cacheKey];
            break;
        default:
            return nil;
    }
}

+ (BOOL)saveCache:(BXGNetWorkCachePolicy)cachePolicy WithURL:(NSString *)url para:(NSDictionary *)para responseObject:(id)obj {
    NSString *cacheKey = [self parseToCacheModelWithURL:url para:para];
    switch (cachePolicy) {
        case BXGNetWorkCachePolicyLoadFailedReturnCacheData:
            return [self saveLoadFailedReturnCacheDataPolicyWithCacheKey:cacheKey responseObj:obj];
            break;
        default:
            return false;
    }
}

#pragma mark - Private Function


/**
 根据URL和Para生成唯一的Key

 @param url URL
 @param para Para
 @return Key
 */
+ (NSString *)parseToCacheModelWithURL:(NSString *)url para:(NSDictionary *)para {
    
    NSMutableString *paraString = [NSMutableString new];
    if(para && [para allKeys].count > 0) {
        NSArray *keysArray = [para allKeys];//获取所有键存到数组
        NSArray *sortedArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        // 遍历拼接
        for(NSInteger i = 0; i < sortedArray.count; i++) {
            NSString *key = sortedArray[i];
            id value = para[key];
            NSString *toValue = @"";
            if(![value isKindOfClass:NSString.class]) {
                if([value isKindOfClass:NSNumber.class]) {
                    toValue = [value stringValue];
                }
            }else {
                toValue = value;
            }
            if(paraString.length > 0){
                [paraString appendString:@","];
            }
            [paraString appendString:[NSString stringWithFormat:@"%@=%@",key,toValue]];
        }
    }
    
    NSMutableString *preKey = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"url=%@",url]];
    if(paraString.length > 0) {
        [preKey appendString:[NSString stringWithFormat:@",%@",paraString]];
    }
    NSString *md5String = [preKey md5String];
    return md5String;
}

+ (id)loadLoadFailedReturnCacheDataPolicyWithCacheKey:(NSString *)cacheKey {
    if(cacheKey.length > 0) {
        NSString *path = [self loadFailedReturnCacheDataPolicyPathForKey:cacheKey];
        if(path.length > 0) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            if(data) {
                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                return jsonObject;
            }
        }
    }
    return nil;
}

+ (NSString *)cachedFileNameForKey:(NSString *)key {
    NSString *suffix = [self suffix];
    NSString *fileName = [NSString stringWithFormat:@"%@%@",key,suffix];
    return fileName;
}

+ (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path {
    NSString *filename = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:filename];
}

+ (NSString *)loadFailedReturnCacheDataPolicyPathForKey:(NSString *)key {
    return [self cachePathForKey:key inPath:self.cachePathForLoadFailedReturnCacheDataPolicyPath];
}

+ (BOOL)saveLoadFailedReturnCacheDataPolicyWithCacheKey:(NSString *)cacheKey responseObj:(id)obj {
    
    NSData *data = nil;
    if(obj) {
        if([obj isKindOfClass:NSDictionary.class] || [obj isKindOfClass:NSArray.class]) {
            
            data= [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
        }
    }

    if(data && cacheKey) {
        
        NSString *cachePath= [self cachePathForLoadFailedReturnCacheDataPolicyPath];
        NSString *cacheFilePath = [self loadFailedReturnCacheDataPolicyPathForKey:cacheKey];
        
        // 创建 路径 不存在会创建
        [BXGNetworkCacheFileManager creatDirectoryWithPath:cachePath];
        return [BXGNetworkCacheFileManager saveFile:cacheFilePath withData:data];
        
    }else {
        return false;
    }
}

+ (void)clearLoadFailedReturnCacheDataPolicyCache {
    
    [BXGNetworkCacheFileManager removeFileOfPath:[self cachePathForLoadFailedReturnCacheDataPolicyPath]];
}
@end
