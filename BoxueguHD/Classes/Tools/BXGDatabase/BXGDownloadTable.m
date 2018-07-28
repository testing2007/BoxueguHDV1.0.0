//
//  BXGDownloadTable.h
//  FFDBPrj
//
//  Created by apple on 17/6/12.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "BXGDownloadTable.h"
#import "BXGDatabaseAPI.h"
#import "BXGDownloadPersistAPIModel.h"
#import "BoxueguHD-Swift.h"
@interface BXGDownloadTable()
@end

@implementation BXGDownloadTable

-(instancetype)init
{
    self = [super init];
    if(self) {
    }
    return self;
}

+(BOOL)createTable
{
    BOOL bResult = YES;
    bResult = [BXGDATABASE executeUpdate:@"CREATE TABLE if not exists downloadTable(\
               userId text NOT NULL, \
               courseId integer NOT NULL, \
               phaseId integer NOT NULL, \
               moduleId integer NOT NULL,\
               sectionId integer NOT NULL,\
               pointId integer NOT NULL, \
               videoId integer NOT NULL, \
               ccVideoId text NOT NULL, \
               phaseSort integer,\
               moduleSort integer,\
               sectionSort text, \
               pointSort integer, \
               courseName text, \
               courseType integer /*课程类型 就业班-1, 精品微课-2, 免费微课-3*/, \
               courseImageUrl text, \
               phaseName text,\
               moduleName text,\
               sectionName text, \
               sectionIsPass integer, \
               sectionIsTry integer, \
               pointName text, \
               watched integer, \
               token text, \
               qualityDesp text, \
               downloadUrl text, \
               videoPath text, \
               downloadState integer, \
               totalBytesWritten double, \
               totalBytesExpectedToWrite double, \
               progress double,\
               primary key(userId, courseId, phaseId, moduleId, sectionId, pointId, videoId, ccVideoId));"];
    if(bResult) {
        NSLog(@"success to create downloadResourceTable");
    }
    return bResult;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//将已下载的视频设置为已观看状态
-(void)updateVideoTableToWatchedStatusWithVideoIdx:(NSString*)videoIdx {
    NSLog(@"updateVideoTableToWatchedStatusWithVideoIdx");
}

//添加/更新记录
-(BOOL)addDownloadItem:(BXGDownloadPersistAPIModel*)item {
    BOOL bResult = YES;
    BXGDownloadAPIModel *apiDownloadModel = item.apiDownloaderItem;
    NSString *sql = [NSString stringWithFormat:@"insert or replace into downloadTable(\
                     userId, \
                     courseId, \
                     phaseId, \
                     moduleId,\
                     sectionId,\
                     pointId, \
                     videoId, \
                     ccVideoId, \
                     phaseSort,\
                     moduleSort,\
                     sectionSort, \
                     pointSort, \
                     courseName, \
                     courseType /*课程类型 就业班-1, 精品微课-2, 免费微课-3*/, \
                     courseImageUrl,\
                     phaseName,\
                     moduleName,\
                     sectionName, \
                     sectionIsPass, \
                     sectionIsTry, \
                     pointName, \
                     watched, \
                     token, \
                     qualityDesp, \
                     downloadUrl, \
                     videoPath, \
                     downloadState, \
                     totalBytesWritten, \
                     totalBytesExpectedToWrite, \
                     progress) \
                     values('%@' /*userId text NOT NULL*/, \
                     %d /*courseId integer NOT NULL*/, \
                     %d /*phaseId integer NOT NULL*/, \
                     %d /*moduleId integer NOT NULL*/,\
                     %d /*sectionId integer NOT NULL*/,\
                     %d /*pointId integer NOT NULL*/, \
                     %d /*videoId integer NOT NULL*/, \
                     '%@' /*ccVideoId text NOT NULL*/, \
                     %d /*phaseSort integer*/,\
                     %d /*moduleSort integer*/,\
                     %d /*sectionSort text*/, \
                     %d /*pointSort integer*/, \
                     '%@' /*courseName text*/, \
                     %d /*courseType integer*/, \
                     '%@' /*courseImageUrl text*/, \
                     '%@' /*phaseName text*/,\
                     '%@' /*moduleName text*/,\
                     '%@' /*sectionName text*/, \
                     %d /*sectionIsPass integer*/, \
                     %d /*sectionIsTry integer*/, \
                     '%@' /*pointName text*/, \
                     %d /*watched integer*/, \
                     '%@' /*token text*/, \
                     '%@' /*qualityDesp text*/, \
                     '%@' /*downloadUrl text*/, \
                     '%@' /*videoPath text*/, \
                     %lu  /*downloadState integer*/, \
                     %lld /*totalBytesWritten double*/, \
                     %lld /*totalBytesExpectedToWrite double*/, \
                     %f /*progress double*/);",
                     BXGDownloadEnvSource.instance.userId ?: @"",
                     apiDownloadModel.courseId,
                     apiDownloadModel.phaseId,
                     apiDownloadModel.moduleId,
                     apiDownloadModel.sectionId,
                     apiDownloadModel.pointId,
                     apiDownloadModel.videoId,
                     apiDownloadModel.ccVideoId,
                     apiDownloadModel.phaseSort,
                     apiDownloadModel.moduleSort,
                     apiDownloadModel.sectionSort,
                     apiDownloadModel.pointSort,
                     apiDownloadModel.courseName ?: @"",
                     apiDownloadModel.courseType,
                     apiDownloadModel.courseImageUrl ?: @"",
                     apiDownloadModel.phaseName ?: @"",
                     apiDownloadModel.moduleName ?: @"",
                     apiDownloadModel.sectionName ?: @"",
                     apiDownloadModel.sectionIsPass,
                     apiDownloadModel.sectionIsTry,
                     apiDownloadModel.pointName ?: @"",
                     (int)apiDownloadModel.watched,
                     item.token ?: @"",
                     item.qualityDesp ?: @"",
                     item.downloadURL ?: @"",
                     item.videoPath ?: @"",
                     item.downloadState,
                     (long long)item.totalBytesWritten,
                     item.totalBytesExpectedToWrite,
                     item.progress];
    bResult &= [BXGDATABASE executeUpdate:sql];
    if(bResult)
    {
        NSLog(@"success to add one record");
    }
    else
    {
        NSLog(@"fail to add one record, the code=%d, the reason=%@", [BXGDATABASE lastErrorCode], [BXGDATABASE lastErrorMessage]);
    }
    return bResult;
}

-(BOOL)addDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)items {
    BOOL bResult = YES;
    for (BXGDownloadPersistAPIModel *item in items) {
        bResult &= [self addDownloadItem:item];
    }
    return bResult;
}

-(NSString *_Nullable)databaseSQLConditionCustomIdByModel:(BXGDownloadAPIModel*)model
                                                andUserId:(NSString*)userId {
    return [NSString stringWithFormat:@"userId='%@' and courseId=%d and phaseId=%d and moduleId=%d and sectionId=%d  and pointId=%d and videoId=%d and ccVideoId='%@'", userId, model.courseId, model.phaseId, model.moduleId, model.sectionId, model.pointId, model.videoId, model.ccVideoId];
}


//删除待下载
-(BOOL)deleteWaitingDownloadItem:(BXGDownloadPersistAPIModel*)item {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId || !item || !item.apiDownloaderItem) {
        return NO;
    }

    NSString* sql = [NSString stringWithFormat:@"delete from downloadTable where downloadState!=4 and %@;", [self databaseSQLConditionCustomIdByModel:item.apiDownloaderItem andUserId:userId] ];
    BOOL bResult = [BXGDATABASE executeUpdate:sql];
    if(bResult)
    {
        NSLog(@"success to delete record, condition=%@", sql);
    }
    else
    {
        NSLog(@"fail to delete record, condition=%@, the code=%d, reason=%@", sql, [BXGDATABASE lastErrorCode], [BXGDATABASE lastErrorMessage]);
    }
    return bResult;
}

-(BOOL)deleteWaitingDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)items {
    BOOL bResult = YES;
    for (BXGDownloadPersistAPIModel *item in items) {
        bResult &= [self deleteWaitingDownloadItem:item];
    }
    return bResult;
}

-(BOOL)deleteAllWaitingDownloadItemsUnderCourseId:(int)courseId {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        return NO;
    }
    
    NSString* sql = [NSString stringWithFormat:@"delete from downloadTable where courseId=%d and userId='%@';", courseId, userId];
    BOOL bResult = [BXGDATABASE executeUpdate:sql];
    if(bResult)
    {
        NSLog(@"success to delete record, condition=%@", sql);
    }
    else
    {
        NSLog(@"fail to delete record, condition=%@, the code=%d, reason=%@", sql, [BXGDATABASE lastErrorCode], [BXGDATABASE lastErrorMessage]);
    }
    return bResult;
}

-(BOOL)deleteAllWaitingDownloadItems{
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        return NO;
    }
    
    NSString* sql = [NSString stringWithFormat:@"delete from downloadTable where downloadState!=4 and userId='%@';", userId];
    BOOL bResult = [BXGDATABASE executeUpdate:sql];
    if(bResult)
    {
        NSLog(@"success to delete record, condition=%@", sql);
    }
    else
    {
        NSLog(@"fail to delete record, condition=%@, the code=%d, reason=%@", sql, [BXGDATABASE lastErrorCode], [BXGDATABASE lastErrorMessage]);
    }
    return bResult;
}

//删除已下载
-(BOOL)deleteDownloadedItem:(BXGDownloadPersistAPIModel*)item {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId || !item || !item.apiDownloaderItem) {
        return NO;
    }
    
    NSString* sql = [NSString stringWithFormat:@"delete from downloadTable where downloadState=4 and %@;", [self databaseSQLConditionCustomIdByModel:item.apiDownloaderItem andUserId:userId]];
    BOOL bResult = [BXGDATABASE executeUpdate:sql];
    if(bResult)
    {
        NSLog(@"success to delete record, condition=%@", sql);
    }
    else
    {
        NSLog(@"fail to delete record, condition=%@, the code=%d, reason=%@", sql, [BXGDATABASE lastErrorCode], [BXGDATABASE lastErrorMessage]);
    }
    return bResult;
}

-(BOOL)deleteDownloadedItems:(NSArray<BXGDownloadPersistAPIModel*>*)arrDownloadingModel {
    BOOL bResult = YES;
    for (BXGDownloadPersistAPIModel *item in arrDownloadingModel) {
        bResult &= [self deleteWaitingDownloadItem:item];
    }
    return bResult;
}

-(BOOL)deleteAllDownloadedItemsUnderCourseId:(int)courseId{
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        return NO;
    }
    
    NSString* sql = [NSString stringWithFormat:@"delete from downloadTable where downloadState=4 and userId='%@' and courseId=%d;", userId, courseId];
    BOOL bResult = [BXGDATABASE executeUpdate:sql];
    if(bResult)
    {
        NSLog(@"success to delete record, condition=%@", sql);
    }
    else
    {
        NSLog(@"fail to delete record, condition=%@, the code=%d, reason=%@", sql, [BXGDATABASE lastErrorCode], [BXGDATABASE lastErrorMessage]);
    }
    return bResult;
}

-(BOOL)deleteAllDownloadedItems {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        return NO;
    }
    
    NSString* sql = [NSString stringWithFormat:@"delete from downloadTable where downloadStat=4 and userId='%@';", userId];
    BOOL bResult = [BXGDATABASE executeUpdate:sql];
    if(bResult)
    {
        NSLog(@"success to delete record, condition=%@", sql);
    }
    else
    {
        NSLog(@"fail to delete record, condition=%@, the code=%d, reason=%@", sql, [BXGDATABASE lastErrorCode], [BXGDATABASE lastErrorMessage]);
    }
    return bResult;
}

///查询正在下载的列表
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchAllDownloading {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray new];
    NSString* sql = [NSString stringWithFormat:@"select * from downloadTable where downloadState!=4 and userId='%@';", userId];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    if(resultSet == nil) {
        NSLog(@"WARNING:--cann't find result, the reason=%@", [BXGDATABASE lastError]);
    }
    while ([resultSet next]) {
        BXGDownloadPersistAPIModel *record = [self getRecord:resultSet];
        if(record) {
            record.downloadState = BXGDownloadStateNone;//查询未下载完成出来的初始状态
            [arr addObject:record];
        }
    }
    NSLog(@"The number of undownloaded have %d in the database", arr.count);
    return arr.count>0 ? arr : nil;
}

//查询已下载的课程模块索引信息
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchDownloadedCourseIndexByCourseId:(int)courseId {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray new];
    //获取到所有以 (课程/阶段/模块) 分组, 并以 phaseSort/moduleSort/sectionSort 多字段排序
    NSString* sql = [NSString stringWithFormat:@"select * from downloadTable where downloadState=4 and userId='%@' and courseId=%d group by courseId, phaseId, moduleId order by phaseSort asc, moduleSort asc, sectionSort asc;", userId, courseId];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    while ([resultSet next]) {
        BXGDownloadPersistAPIModel *record = [self getRecord:resultSet];
        if(record) {
            [arr addObject:record];
        }
    }
    return arr.count>0 ? arr : nil;
}

//查询已下载的课程模块详情信息
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchDownloadedCourseDetailByCourseId:(int)courseId
                                                                           andPhaseId:(int)phaseId
                                                                          andModuleId:(int)moduleId {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray new];
    //获取到所有以 (课程/阶段/模块) 分组, 并以 phaseSort/moduleSort/sectionSort 多字段排序
    NSString* sql = [NSString stringWithFormat:@"select * from downloadTable where downloadState=4 and userId='%@' and courseId=%d and phaseId=%d and moduleId=%d order by phaseSort asc, moduleSort asc, sectionSort asc;", userId, courseId, phaseId, moduleId];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    while ([resultSet next]) {
        BXGDownloadPersistAPIModel *record = [self getRecord:resultSet];
        if(record) {
            [arr addObject:record];
        }
    }
    return arr.count>0 ? arr : nil;
}


///查询已完成下载的列表
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchAllDownloaded {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray new];
//    select * from downloadResourceTable  order by courseId DESC
    NSString* sql = [NSString stringWithFormat:@"select * from downloadTable where downloadState=4 and userId='%@' order by courseId, phaseSort asc, moduleSort asc, sectionSort asc;", userId];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    while ([resultSet next]) {
        BXGDownloadPersistAPIModel *record = [self getRecord:resultSet];
        if(record) {
            [arr addObject:record];
        }
    }
    return arr.count>0 ? arr : nil;
}

-(BXGDownloadPersistAPIModel*)getRecord:(FMResultSet*) resultSet {
    BXGDownloadPersistAPIModel *model = [BXGDownloadPersistAPIModel new];
    model.apiDownloaderItem = [BXGDownloadAPIModel new];
    
    model.apiDownloaderItem.courseId = [resultSet intForColumn:@"courseId"];
    model.apiDownloaderItem.phaseId = [resultSet intForColumn:@"phaseId"];
    model.apiDownloaderItem.moduleId = [resultSet intForColumn:@"moduleId"];
    model.apiDownloaderItem.sectionId = [resultSet intForColumn:@"sectionId"];
    model.apiDownloaderItem.pointId = [resultSet intForColumn:@"pointId"];
    model.apiDownloaderItem.videoId = [resultSet intForColumn:@"videoId"];
    model.apiDownloaderItem.ccVideoId = [resultSet stringForColumn:@"ccVideoId"];
    model.apiDownloaderItem.phaseSort = [resultSet intForColumn:@"phaseSort"];
    model.apiDownloaderItem.moduleSort = [resultSet intForColumn:@"moduleSort"];
    model.apiDownloaderItem.sectionSort = [resultSet intForColumn:@"sectionSort"];
    model.apiDownloaderItem.pointSort = [resultSet intForColumn:@"courseId"];
    model.apiDownloaderItem.courseName = [resultSet stringForColumn:@"courseName"];
    model.apiDownloaderItem.courseType = [resultSet intForColumn:@"courseType"];
    model.apiDownloaderItem.courseImageUrl = [resultSet stringForColumn:@"courseImageUrl"];
    model.apiDownloaderItem.phaseName = [resultSet stringForColumn:@"phaseName"];
    model.apiDownloaderItem.moduleName = [resultSet stringForColumn:@"moduleName"];
    model.apiDownloaderItem.sectionName = [resultSet stringForColumn:@"sectionName"];
    model.apiDownloaderItem.sectionIsPass = [resultSet intForColumn:@"sectionIsPass"];
    model.apiDownloaderItem.sectionIsTry = [resultSet intForColumn:@"sectionIsTry"];
    model.apiDownloaderItem.pointName = [resultSet stringForColumn:@"pointName"];
    model.apiDownloaderItem.watched = [resultSet intForColumn:@"watched"];
    model.token = [resultSet stringForColumn:@"token"];
    model.qualityDesp = [resultSet stringForColumn:@"qualityDesp"];
    model.downloadURL = [resultSet stringForColumn:@"downloadURL"];
    model.videoPath = [resultSet stringForColumn:@"videoPath"];
    model.downloadState = [resultSet intForColumn:@"downloadState"];
    model.totalBytesWritten = [resultSet longLongIntForColumn:@"totalBytesWritten"];
    model.totalBytesExpectedToWrite = [resultSet longLongIntForColumn:@"totalBytesExpectedToWrite"];
    model.progress = [resultSet doubleForColumn:@"progress"];
    
    return model;
}

///是否存在于数据库中
-(BOOL)isExistDatabase:(BXGDownloadAPIModel*)model {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        NSLog(@"userId is nil, can't execute searching database");
        return false;
    }
    NSString* sql = [NSString stringWithFormat:@"select * from downloadTable where %@;", [self databaseSQLConditionCustomIdByModel:model andUserId:userId]];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    return [resultSet next] ? true : false;
}

///是否存在已下载完成记录
-(BOOL)isExistDownloaded:(BXGDownloadAPIModel*)model {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        NSLog(@"userId is nil, can't execute searching database");
        return false;
    }
    NSString* sql = [NSString stringWithFormat:@"select * from downloadTable where downloadState=4 and %@;", [self databaseSQLConditionCustomIdByModel:model andUserId:userId]];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    return [resultSet next] ? true : false;
}

-(BXGDownloadPersistAPIModel*)searchDownloadItem:(BXGDownloadAPIModel*)model {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        NSLog(@"userId is nil, can't execute searching database");
        return nil;
    }
    NSString* sql = [NSString stringWithFormat:@"select * from downloadTable where %@;", [self databaseSQLConditionCustomIdByModel:model andUserId:userId]];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    BXGDownloadPersistAPIModel *record = nil;
    if([resultSet next]) {
        record = [self getRecord:resultSet];
    }
    return record;
}

-(NSString*)searchDownloadedFilePathByCourseId:(int)courseId
                                    andPhaseId:(int)phaseId
                                   andModuleId:(int)moduleId
                                  andSectionId:(int)sectionId
                                    andPointId:(int)pointId
                                    andVideoId:(int)videoId {
    NSString* userId = [BXGDownloadEnvSource.instance userId];
    if(!userId) {
        NSLog(@"userId is nil, can't execute searching database");
        return nil;
    }
    NSString* sql = [NSString stringWithFormat:@"select * from downloadTable where downloadState=4 and userId='%@' and courseId=%d and phaseId=%d and moduleId=%d and sectionId=%d  and pointId=%d and videoId=%d;", userId, courseId, phaseId, moduleId, sectionId, pointId, videoId];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    NSMutableArray<BXGDownloadPersistAPIModel*> *arrRecord = [NSMutableArray new];
    if([resultSet next]) {
        BXGDownloadPersistAPIModel *record = nil;
        record = [self getRecord:resultSet];
        [arrRecord addObject:record];
    }
    NSAssert(arrRecord.count<=1, @"the result shouldn't be appeared the sql=%@", sql);
    NSString *filePath = arrRecord[0].videoPath;
    return filePath;
}

@end
