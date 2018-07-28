//
//  BXGStudyCenterProgressStatusTable.m
//  Boxuegu
//
//  Created by Renying Wu on 2018/3/16.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "BXGStudyStatusTable.h"
#import "BXGDatabaseAPI.h"

@implementation BXGStudyStatusTable


/**
 video_name text 3.0 added
 */
+ (BOOL)createTable {
    BOOL bResult = YES;
    NSString *sql = @"CREATE TABLE if not exists bxg_study_center_study_progress( \
    user_id text NOT NULL, \
    course_id text NOT NULL, \
    phase_id text, \
    module_id text NOT NULL, \
    section_id text NOT NULL, \
    point_id text NOT NULL, \
    video_id text NOT NULL, \
    video_name text, \
    is_sync integer NOT NULL, \
    status integer NOT NULL, \
    seek_time real NOT NULL, \
    duration_time real NOT NULL, \
    add_time text NOT NULL);";
    
    bResult = [BXGDATABASE executeUpdate:sql];
    return bResult;
}

- (void)setDefault:(BXGStudyStatusModel *)model {
    model.pointId = @"";
}

- (BOOL)addOneRecord:(BXGStudyStatusModel *)model {
    
    [self setDefault:model];
    
    NSString *sql = [NSString stringWithFormat:@"insert into bxg_study_center_study_progress( \
                     user_id, \
                     course_id, \
                     phase_id, \
                     module_id, \
                     section_id, \
                     point_id, \
                     video_id, \
                     video_name, \
                     current_percent, \
                     is_sync, \
                     status, \
                     seek_time, \
                     duration_time, \
                     add_time) values ( \
                                '%@', \
                               '%@', \
                               '%@', \
                               '%@', \
                               '%@', \
                               '%@', \
                               '%@', \
                               '%@', \
                               %zd, \
                               %zd, \
                                %f, \
                                %f, \
                               '%@');"
                     ,model.userId,
                     model.courseId,
                     model.phaseId,
                     model.moduleId,
                     model.sectionId,
                     model.pointId,
                     model.videoId,
                     model.videoName,
                     model.isSync,
                     model.status,
                     model.seekTime,
                     model.durantionTime,
                     model.addtime];
    
    BOOL bResult = false;
    bResult = [BXGDATABASE executeUpdate:sql];
    
    
#ifdef DEBUG
    NSMutableString *mutableString = [NSMutableString new];
    [mutableString appendFormat:@"\nTESTRWLOG:INSERT START:"];
    [mutableString appendFormat:@"\tcourseId:%@",model.courseId];
    [mutableString appendFormat:@"\tvideoId:%@",model.videoId];
    [mutableString appendFormat:@"\tseekTime:%0.2lf",model.seekTime];
    [mutableString appendFormat:@"\nTESTRWLOG:INSERT END"];
    NSLog(@"%@", mutableString);
#endif
    
    return bResult;
}
- (BOOL)updateOneRecord:(BXGStudyStatusModel *)model {
    
    [self setDefault:model];
    NSString *sql = [NSString stringWithFormat:@"UPDATE bxg_study_center_study_progress \
                     SET is_sync = %zd, status = %zd, seek_time = %f, duration_time = %f, add_time = '%@' \
                     where course_id = '%@' and phase_id = '%@' and module_id = '%@' and section_id = '%@' and point_id = '%@' and video_id = '%@' and user_id = '%@';"
                     ,model.isSync,
                     model.status,
                     model.seekTime,
                     model.durantionTime,
                     model.addtime,
                     model.courseId,
                     model.phaseId,
                     model.moduleId,
                     model.sectionId,
                     model.pointId,
                     model.videoId,
                     model.userId];
    
//    NSString *sql = [NSString stringWithFormat:@"UPDATE bxg_study_center_study_progress \
//                     SET current_percent = %f, is_sync = %zd, status = %zd, seek_time = %f, duration_time = %f, add_time = '%@', video_name = '%@' \
//                     where course_id = '%@' and module_id = '%@' and section_id = '%@' and point_id = '%@' and video_id = '%@' and user_id = '%@';"
//                     ,model.currentPercent,
//                     model.isSync,
//                     model.status,
//                     model.seekTime,
//                     model.durantionTime,
//                     model.addtime,
//                     model.videoName,
//                     model.courseId,
//                     model.moduleId,
//                     model.sectionId,
//                     model.pointId,
//                     model.videoId,
//                     model.userId];
    
    BOOL bResult = false;
    bResult = [BXGDATABASE executeUpdate:sql];
    
#ifdef DEBUG
    NSMutableString *mutableString = [NSMutableString new];
    [mutableString appendFormat:@"\nTESTRWLOG:UPDATE START:"];
    [mutableString appendFormat:@"\tcourseId:%@",model.courseId];
    [mutableString appendFormat:@"\tvideoId:%@",model.videoId];
    [mutableString appendFormat:@"\tseekTime:%0.2lf",model.seekTime];
    [mutableString appendFormat:@"\nTESTRWLOG:UPDATE END"];
    NSLog(@"%@", mutableString);
#endif
    
    return bResult;
}
- (BOOL)deleteOneRecordWithUserId:(NSString *)userId
                         CourseId:(NSString *)courseId
                          PhaseId:(NSString *)phaseId
                           ModuleId:(NSString *)moduleId
                          SectionId:(NSString *)sectionId
                            VideoId:(NSString *)videoId {
    NSString *sql = [NSString stringWithFormat:@"delete from bxg_study_center_study_progress where user_id = '%@' \
                     and course_id = '%@' \
                     and phase_id = '%@' \
                     and module_id = '%@' \
                     and section_id = '%@' \
                     and video_id = '%@';",
                     userId,
                     courseId,
                     phaseId,
                     moduleId,
                     sectionId,
                     videoId];
    
    BOOL bResult = false;
    bResult = [BXGDATABASE executeUpdate:sql];
    return bResult;
}

- (BXGStudyStatusModel *)searchModelWithResultSet:(FMResultSet *)resultSet {
    BXGStudyStatusModel *model = [BXGStudyStatusModel new]; 
    model.userId = [resultSet stringForColumn:@"user_id"];
    model.courseId = [resultSet stringForColumn:@"course_id"];
    model.phaseId = [resultSet stringForColumn:@"phase_id"];
    model.moduleId = [resultSet stringForColumn:@"module_id"];
    model.sectionId = [resultSet stringForColumn:@"section_id"];
    model.pointId = [resultSet stringForColumn:@"point_id"];
    model.videoId = [resultSet stringForColumn:@"video_id"];
    model.videoName = [resultSet stringForColumn:@"video_name"];
    model.isSync = [resultSet intForColumn:@"is_sync"];
    model.status = [resultSet intForColumn:@"status"];
    model.seekTime = [resultSet doubleForColumn:@"seek_time"];
    model.durantionTime = [resultSet doubleForColumn:@"duration_time"];
    model.addtime = [resultSet stringForColumn:@"add_time"];
    return model;
}

//- (NSArray<BXGStudyStatusModel *> *)searchRecordWithUserId:(NSString *)userId CourseId:(NSString *)courseId PhaseId:(NSString *)phaseId ModuleId:(NSString *)moduleId VideoId:(NSString *)videoId {
//
//    NSString *sql = [NSString stringWithFormat:@"select * from bxg_study_center_study_progress where user_id = '%@' and course_id = '%@' and phase_id = '%@' and module_id = '%@' and video_id = '%@';",userId,courseId,phaseId,moduleId,videoId];
//
//    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
//    NSMutableArray *array = [NSMutableArray new];
//
//    while ([resultSet next]) {
//        BXGStudyStatusModel *model = [self searchModelWithResultSet:resultSet];
//
//        [array addObject:model];
//    }
//    return array;
//
//}

- (NSArray<BXGStudyStatusModel *> *)searchRecordWithUserId:(NSString *)userId
                                                                CourseId:(NSString *)courseId
                                                                 PhaseId:(NSString *)phaseId
                                                                  ModuleId:(NSString *)moduleId
                                                                 SectionId:(NSString *)sectionId
                                                                   VideoId:(NSString *)videoId {
    
    NSString *sql = [NSString stringWithFormat:@"select * from bxg_study_center_study_progress where user_id = '%@' and course_id = '%@' \
                     and phase_id = '%@' \
                     and module_id = '%@' \
                     and section_id = '%@' \
                     and video_id = '%@';",
                     userId,
                     courseId,
                     phaseId,
                     moduleId,
                     sectionId,
                     videoId];
    
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    NSMutableArray *array = [NSMutableArray new];
    
    while ([resultSet next]) {
        BXGStudyStatusModel *model = [self searchModelWithResultSet:resultSet];
        [array addObject:model];
    }
    return array;
}
- (BOOL)deleteAllRecordWithUserId:(NSString *)userId {
    
    NSString *sql = [NSString stringWithFormat:@"delete from bxg_study_center_study_progress where user_id = '%@';",userId];
    
    BOOL bResult = false;
    bResult = [BXGDATABASE executeUpdate:sql];
    return bResult;
}

#pragma mark - Search

- (NSArray<BXGStudyStatusModel *> *)searchAllRecordWithUserId:(NSString *)userId {
    
    NSString *sql = [NSString stringWithFormat:@"select * from bxg_study_center_study_progress where user_id = '%@';",userId];

    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    NSMutableArray *array = [NSMutableArray new];
    
    while ([resultSet next]) {
        BXGStudyStatusModel *model = [self searchModelWithResultSet:resultSet];
        [array addObject:model];
    }
    return array;
}

- (BXGStudyStatusModel *)searchLastOneRecordWithUserId:(NSString *)userId
                                                            CourseId:(NSString *)courseId
                                                             PhaseId:(NSString *)phaseId
                                                              ModuleId:(NSString *)moduleId {
    
    NSString *sql = [NSString stringWithFormat:@"select * from bxg_study_center_study_progress where user_id = '%@' and course_id = '%@' and phase_id = '%@' and module_id = '%@' order by  add_time  desc limit 1;", userId, courseId, phaseId, moduleId];
    
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    NSMutableArray *array = [NSMutableArray new];
    
    while ([resultSet next]) {
        BXGStudyStatusModel *model = [self searchModelWithResultSet:resultSet];
        [array addObject:model];
    }
    return array.firstObject;
}

- (BXGStudyStatusModel *)searchLastOneRecordOnCourseWithUserId:(NSString *)userId CourseId:(NSString *)courseId {
    
    NSString *sql = [NSString stringWithFormat:@"select * from bxg_study_center_study_progress where user_id = '%@' and course_id = '%@' order by  add_time desc limit 1;", userId, courseId];
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    NSMutableArray *array = [NSMutableArray new];
    
    while ([resultSet next]) {
        BXGStudyStatusModel *model = [self searchModelWithResultSet:resultSet];
        [array addObject:model];
    }
    BXGStudyStatusModel *model = array.firstObject;
    if(model) {
        if(model.phaseId.length > 0 && model.moduleId.length > 0) {
            
        }else {
            model = nil;
        }
    }
    return model;
}

/**
 查询未同步状态
 
 @param userId 用户
 @return 未同步状态的数据
 */
- (NSArray<BXGStudyStatusModel *> *)searchNoneSyncRecordWithUserId:(NSString *)userId {
    
    NSString *sql = [NSString stringWithFormat:@"select * from bxg_study_center_study_progress where user_id = '%@' and is_sync = 0;", userId];
    
    FMResultSet *resultSet = [BXGDATABASE executeQuery:sql];
    NSMutableArray *array = [NSMutableArray new];
    
    while ([resultSet next]) {
        
        BXGStudyStatusModel *model = [self searchModelWithResultSet:resultSet];
        [array addObject:model];
    }
    return array;
}

#pragma mark - Update

/**
 同步所有未同步状态的数据

 @param userId 用户
 @return 是否成功
 */
- (BOOL)updateSyncForAllNoneSyncRecordWithUserId:(NSString *)userId {
    NSString *sql = [NSString stringWithFormat:@"UPDATE bxg_study_center_study_progress \
                     SET is_sync = 1 \
                     where user_id = '%@' and is_sync = 0;",userId];
    
    BOOL bResult = false;
    bResult = [BXGDATABASE executeUpdate:sql];
    return bResult;
}

#pragma mark BXGUpgradeInterface

-(void)upgradeV2toV3 {
    
    BOOL bResult = YES;
    bResult = [BXGDATABASE executeUpdate:@"alter TABLE bxg_study_center_study_progress ADD COLUMN video_name text"];
    bResult &= [BXGDATABASE executeUpdate:@"alter TABLE bxg_study_center_study_progress ADD COLUMN phase_id text"];
    if(bResult)
    {
        NSLog(@"success to execute bxg_study_center_study_progress::upgradeV2toV3");
    }
    else
    {
        NSLog(@"fail to execute execute bxg_study_center_study_progress::upgradeV2toV3, the code=%d, the reason=%@", [BXGDATABASE lastErrorCode], [BXGDATABASE lastErrorMessage]);
    }
    return ;
}
@end
