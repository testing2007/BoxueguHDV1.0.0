//
//  BXGDownloadTableProtocol.h
//  Demo
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGDownloadPersistAPIModel.h"

@protocol BXGDownloadTableProtocol <NSObject>

///将已下载的视频设置为已观看状态
-(void)updateVideoTableToWatchedStatusWithVideoIdx:(NSString*)videoIdx;

///添加/更新记录
-(BOOL)addDownloadItem:(BXGDownloadPersistAPIModel*)item;
-(BOOL)addDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)items;

///删除待下载
-(BOOL)deleteWaitingDownloadItem:(BXGDownloadPersistAPIModel*)item;
-(BOOL)deleteWaitingDownloadItems:(NSArray<BXGDownloadPersistAPIModel*>*)arrDownloadingModel;
-(BOOL)deleteAllWaitingDownloadItemsUnderCourseId:(int)courseId;
-(BOOL)deleteAllWaitingDownloadItems;


///删除已下载
-(BOOL)deleteDownloadedItem:(BXGDownloadPersistAPIModel*)item;
-(BOOL)deleteDownloadedItems:(NSArray<BXGDownloadPersistAPIModel*>*)arrDownloadingModel;
-(BOOL)deleteAllDownloadedItemsUnderCourseId:(int)courseId;
-(BOOL)deleteAllDownloadedItems;

////查询
//-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchAllDownloadInfo;

///查询正在下载的列表
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchAllDownloading;
///查询已完成下载的列表
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchAllDownloaded;


//-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchDownloadedGroupByPhaseListByCourseId:(int)courseId;
//                                                                        andGroupbyPhaseId:(int)phaseId;

-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchDownloadedCourseIndexByCourseId:(int)courseId;
-(NSMutableArray<BXGDownloadPersistAPIModel*>*)searchDownloadedCourseDetailByCourseId:(int)courseId
                                                                           andPhaseId:(int)phaseId
                                                                          andModuleId:(int)moduleId;

///是否存在于数据库中
-(BOOL)isExistDatabase:(BXGDownloadAPIModel*)model;
///是否存在已下载完成记录
-(BOOL)isExistDownloaded:(BXGDownloadAPIModel*)model;
///查询下载模型
-(BXGDownloadPersistAPIModel*)searchDownloadItem:(BXGDownloadAPIModel*)model;
///查询已下载文件路径, 有则返回, 没有就返回nil
-(NSString*)searchDownloadedFilePathByCourseId:(int)courseId
                                    andPhaseId:(int)phaseId
                                   andModuleId:(int)moduleId
                                  andSectionId:(int)sectionId
                                    andPointId:(int)pointId
                                    andVideoId:(int)videoId;

@end
