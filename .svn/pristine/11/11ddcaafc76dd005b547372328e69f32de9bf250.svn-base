//
//  BXGDownloadCCModel.h
//  Demo
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGDownloadState.h"
#import "DWSDK.h"

@interface BXGDownloadCCModel : NSObject

@property (nonatomic, strong) NSString *customId; //不能为空,因为ccVideoId不能唯一
@property (nonatomic, strong) NSString *ccVideoId;
@property (nonatomic, strong) NSString *downloadURL;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *videoPath;
//@property (nonatomic, strong) NSString *definition;
@property (nonatomic, strong) NSString *desp;
//@property (nonatomic, strong) DWDownloadModel *downloadModel;
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

@property (nonatomic, strong) NSData *resumeData;//只有在url失效且systemVersion<11.3的时候才使用上
-(BXGDownloadState)convertBXGDownloadState:(DWDownloadState)downloadState ;
-(DWDownloadState)convertCCDownloadState:(BXGDownloadState)downloadState;

-(instancetype)initWithCustomId:(NSString* _Nonnull)customId
                   andCCVideoId:(NSString* _Nonnull)ccVideoId;

-(instancetype)initWithCustomId:(NSString* _Nonnull)customId
                   andCCVideoId:(NSString* _Nonnull)ccVideoId
                 andDownloadURL:(NSString* _Nullable)downloadURL
            andDownloadFilePath:(NSString* _Nullable)filePath
               andDownloadToken:(NSString* _Nullable)token
         andDownloadQualityDesp:(NSString* _Nullable)dowloadQualityDesp;

@end
