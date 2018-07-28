//
//  BXGDownloadPersistAPIModel.m
//  Demo
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import "BXGDownloadPersistAPIModel.h"
#import "BXGDownloadAPIModel.h"

@interface BXGDownloadPersistAPIModel()
@end

@implementation BXGDownloadPersistAPIModel

-(instancetype)initWithDownloadItem:(BXGDownloadAPIModel* _Nonnull)apiDownloadItem
                        andDownloadURL:(NSString* _Nullable)downloadURL
                              andToken:(NSString* _Nullable)token
                          andVideoPath:(NSString* _Nullable)videoPath
                        andQualityDesp:(NSString* _Nullable)qualityDesp {
    self = [super init];
    if(self) {
        self.apiDownloaderItem = [apiDownloadItem copy];
        self.downloadURL = downloadURL;
        self.token = token;
        self.videoPath = videoPath;
        self.qualityDesp = qualityDesp;
    }
    return self;
}

@end
