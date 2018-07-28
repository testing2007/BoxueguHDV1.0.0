//
//  BXGDownloadTableManager.m
//  BoxueguHD
//
//  Created by apple on 2018/7/27.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "BXGDownloadTableManager.h"
#import "BXGDownloadTable.h"

@interface BXGDownloadTableManager()
@property (nonatomic, strong) BXGDownloadTable *downloadTable;
@end

@implementation BXGDownloadTableManager

+(instancetype)shareInstance
{ 
    static dispatch_once_t onceToken;
    static BXGDownloadTableManager* instance;
    dispatch_once(&onceToken, ^{
        instance = [[BXGDownloadTableManager alloc] init];
    });
    return instance;
}

- (BXGDownloadTable*)downloadTable {
    if(!_downloadTable) {
        _downloadTable = [BXGDownloadTable new];
    }
    return _downloadTable;
}

#pragma mark
//将已下载的视频设置为已观看状态
-(void)updateVideoTableToWatchedStatusWithVideoIdx:(NSString*)videoIdx {
    //    BXGVideoTable *vt = [BXGVideoTable new];
    //    [vt updateVideoTableToWatchedStatusWithVideoIdx:videoIdx];
}

//添加/更新记录
-(BOOL)addDownloadItem:(BXGDownloadPersistAPIModel*)item {
    return [self.downloadTable addDownloadItem:item];
}

-(BOOL)addDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)items {
    BOOL bResult = YES;
    for(BXGDownloadPersistAPIModel *item in items) {
        bResult &= [self addDownloadItem:item];
    }
    return bResult;
}

////删除待下载
-(BOOL)deleteWaitingDownloadItem:(BXGDownloadPersistAPIModel*)item {
    return [self.downloadTable deleteWaitingDownloadItem:item];
}

-(BOOL)deleteWaitingDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)items {
    BOOL bResult = YES;
    for(BXGDownloadPersistAPIModel *item in items) {
        bResult &= [self deleteWaitingDownloadItem:item];
    }
    return bResult;
}

-(BOOL)deleteAllWaitingDownloadItemsUnderCourseId:(int)courseId {
    return [self.downloadTable deleteAllWaitingDownloadItemsUnderCourseId:courseId];
}

-(BOOL)deleteAllWaitingDownloadItems {
    return [self.downloadTable deleteAllWaitingDownloadItems];
}

//删除已下载
-(BOOL)deleteDownloadedItem:(BXGDownloadPersistAPIModel*)item {
    return [self.downloadTable deleteDownloadedItem:item];
}

-(BOOL)deleteDownloadedItems:(NSArray<BXGDownloadPersistAPIModel*>*)arrDownloadingModel {
    if(arrDownloadingModel == nil || arrDownloadingModel.count==0) {
        return YES;
    }
    BOOL bSuccess = YES;
    for (BXGDownloadPersistAPIModel *item in arrDownloadingModel) {
        bSuccess &= [self.downloadTable deleteDownloadedItem:item];
    }
    return bSuccess;
}

-(BOOL)deleteAllDownloadedItemsUnderCourseId:(int)courseId {
    return [self.downloadTable deleteAllDownloadedItemsUnderCourseId:courseId];
}

-(BOOL)deleteAllDownloadedItems {
    return [self.downloadTable deleteAllDownloadedItems];
}

//查询--将查询的数据保存在内存中
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchAllDownloading {
    return [self.downloadTable searchAllDownloading];
}
///查询已完成下载的列表
//-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchAllDownloadedCourseInfo {
//    return [self.downloadTable searchAllDownloadedCourseInfo];
//}
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchAllDownloaded {
    return [self.downloadTable searchAllDownloaded];
}

-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchDownloadedCourseIndexByCourseId:(int)courseId {
    return [self.downloadTable searchDownloadedCourseIndexByCourseId:courseId];
}

//查询已下载的课程模块详情信息
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchDownloadedCourseDetailByCourseId:(int)courseId
                                                                           andPhaseId:(int)phaseId
                                                                          andModuleId:(int)moduleId{
    return [self.downloadTable searchDownloadedCourseDetailByCourseId:courseId andPhaseId:phaseId andModuleId:moduleId];
}

-(BOOL)isExistDatabase:(BXGDownloadAPIModel*)model {
    return [self.downloadTable isExistDatabase:model];
}

-(BXGDownloadPersistAPIModel*)searchDownloadItem:(BXGDownloadAPIModel*)model {
    return [self.downloadTable searchDownloadItem:model];
}

-(BOOL)isExistDownloaded:(BXGDownloadAPIModel*)model {
    return [self.downloadTable isExistDownloaded:model];
}

-(NSString*)searchDownloadedFilePathByCourseId:(int)courseId
                                    andPhaseId:(int)phaseId
                                   andModuleId:(int)moduleId
                                  andSectionId:(int)sectionId
                                    andPointId:(int)pointId
                                    andVideoId:(int)videoId {
    return [self.downloadTable searchDownloadedFilePathByCourseId:courseId
                                                       andPhaseId:phaseId
                                                      andModuleId:moduleId
                                                     andSectionId:sectionId
                                                       andPointId:pointId
                                                       andVideoId:videoId];
}




@end
