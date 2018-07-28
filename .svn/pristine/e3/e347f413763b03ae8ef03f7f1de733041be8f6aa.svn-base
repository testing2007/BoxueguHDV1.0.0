//
//  BXGDownloadPersistAPIModel.h
//  Demo
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGDownloadState.h"
#import "BXGDownloadAPIModel.h"

@interface BXGDownloadPersistAPIModel : NSObject
@property (nonatomic, strong) BXGDownloadAPIModel *apiDownloaderItem;
//@property (nonatomic, strong) NSString *ccVideoId;
@property (nonatomic, strong) NSString *downloadURL;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *videoPath;
@property (nonatomic, strong) NSString *qualityDesp;
//下载状态
@property (nonatomic, assign) BXGDownloadState downloadState;
// 已下载的数量
@property (nonatomic, assign) int64_t totalBytesWritten;
// 文件的总大小
@property (nonatomic, assign) int64_t totalBytesExpectedToWrite;
// 下载进度
@property (nonatomic, assign) float progress;
// 下载速度
@property (nonatomic, assign) float speed;

-(instancetype)initWithDownloadItem:(BXGDownloadAPIModel* _Nonnull)apiDownloadItem
                        andDownloadURL:(NSString* _Nullable)downloadURL
                              andToken:(NSString* _Nullable)token
                          andVideoPath:(NSString* _Nullable)videoPath
                        andQualityDesp:(NSString* _Nullable)qualityDesp;

@end
