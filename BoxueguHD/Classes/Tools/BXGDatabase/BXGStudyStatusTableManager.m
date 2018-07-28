//
//  BXGStudyStatusTableManager.m
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/27.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "BXGStudyStatusTableManager.h"

@implementation BXGStudyStatusTableManager

- (NSArray<BXGStudyStatusModel *> *)searchAllRecordWithUserId:(NSString *)userId {
    BXGStudyStatusTable *table = [BXGStudyStatusTable new];
    NSArray<BXGStudyStatusModel *> *result = [table searchAllRecordWithUserId:userId];
    return result;
}

- (NSArray<BXGStudyStatusModel *> *)searchRecordWithUserId:(NSString *)userId
                                                  CourseId:(NSString *)courseId
                                                   PhaseId:(NSString *)phaseId
                                                  ModuleId:(NSString *)moduleId
                                                 SectionId:(NSString *)sectionId
                                                   VideoId:(NSString *)videoId {
    BXGStudyStatusTable *table = [BXGStudyStatusTable new];
    
    return [table searchRecordWithUserId:userId CourseId:courseId PhaseId:phaseId ModuleId:moduleId SectionId:sectionId VideoId:videoId];
}

- (BXGStudyStatusModel *)searchLastOneRecordWithUserId:(NSString *)userId
                                              CourseId:(NSString *)courseId
                                               PhaseId:(NSString *)phaseId
                                              ModuleId:(NSString *)moduleId {
    BXGStudyStatusTable *table = [BXGStudyStatusTable new];
    return [table searchLastOneRecordWithUserId:userId CourseId:courseId PhaseId:phaseId ModuleId:moduleId];
}

- (BXGStudyStatusModel *)searchLastOneRecordOnCourseWithUserId:(NSString *)userId CourseId:(NSString *)courseId {
    BXGStudyStatusTable *table = [BXGStudyStatusTable new];
    return [table searchLastOneRecordOnCourseWithUserId:userId CourseId:courseId];
}

- (NSArray<BXGStudyStatusModel *> *)searchNoneSyncRecordWithUserId:(NSString *)userId {
    BXGStudyStatusTable *table = [BXGStudyStatusTable new];
    return [table searchNoneSyncRecordWithUserId:userId];
}

#pragma mark - Delete


- (BOOL)deleteOneRecordWithUserId:(NSString *)userId
                         CourseId:(NSString *)courseId
                          PhaseId:(NSString *)phaseId
                         ModuleId:(NSString *)moduleId
                        SectionId:(NSString *)sectionId
                          VideoId:(NSString *)videoId {
    BXGStudyStatusTable *table = [BXGStudyStatusTable new];
    
    return [table deleteOneRecordWithUserId:userId CourseId:courseId PhaseId:phaseId ModuleId:moduleId SectionId:sectionId VideoId:videoId];
}

- (BOOL)deleteAllRecordWithUserId:(NSString *)userId {
    BXGStudyStatusTable *table = [BXGStudyStatusTable new];
    return [table deleteAllRecordWithUserId:userId];
}

#pragma mark - Update

- (BOOL)updateSyncForAllNoneSyncRecordWithUserId:(NSString *)userId {
    BXGStudyStatusTable *table = [BXGStudyStatusTable new];
    return [table updateSyncForAllNoneSyncRecordWithUserId:userId];
}
@end
