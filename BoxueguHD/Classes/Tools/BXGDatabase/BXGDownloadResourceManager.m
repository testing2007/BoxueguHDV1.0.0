//
//  BXGDownloadResourceManager.m
//  Demo
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import "BXGDownloadResourceManager.h"
#import "BXGDatabaseAPI.h"
#import "BXGFileManager.h"

@interface BXGDownloadResourceManager()
@property (nonatomic, strong, readwrite) NSString *downloadDBPath;
@end

@implementation BXGDownloadResourceManager

+(instancetype)shareInstance {
    static BXGDownloadResourceManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [BXGDownloadResourceManager new];
    });
    return instance;
}

-(NSString*)downloadDBPath {
    if(!_downloadDBPath) {
        NSString *documentDir = [BXGFileManager getDocumentPath];
        NSLog(@"documentDir=%@", documentDir);
        NSString *dbPath = [documentDir stringByAppendingPathComponent:DB_NAME];
        if(![BXGFileManager creatFileWithPath:dbPath]) {
            NSAssert(NO, @"fail to create db path");
        }
        _downloadDBPath = dbPath;
    }
    return _downloadDBPath;
}

@end
