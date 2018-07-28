//
//  NSString+BXGNetworkCache.m
//  Boxuegu
//
//  Created by Renying Wu on 2018/7/2.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "NSString+BXGNetworkCache.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (BXGNetworkCache)
- (NSString *)md5String {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}
@end

