//
//  BXGStudyStatusTableManager.h
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/27.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGStudyStatusModel.h"

@interface BXGStudyStatusTableManager : NSObject
- (BOOL)addOneRecord:(BXGStudyStatusModel *)model;
- (BOOL)updateOneRecord:(BXGStudyStatusModel *)model;

#pragma mark - Search

- (NSArray<BXGStudyStatusModel *> *)searchAllRecordWithUserId:(NSString *)userId;

- (NSArray<BXGStudyStatusModel *> *)searchRecordWithUserId:(NSString *)userId
                                                  CourseId:(NSString *)courseId
                                                   PhaseId:(NSString *)phaseId
                                                  ModuleId:(NSString *)moduleId
                                                 SectionId:(NSString *)sectionId
                                                   VideoId:(NSString *)videoId;

- (BXGStudyStatusModel *)searchLastOneRecordWithUserId:(NSString *)userId
                                              CourseId:(NSString *)courseId
                                               PhaseId:(NSString *)phaseId
                                              ModuleId:(NSString *)moduleId;

- (BXGStudyStatusModel *)searchLastOneRecordOnCourseWithUserId:(NSString *)userId CourseId:(NSString *)courseId;

- (NSArray<BXGStudyStatusModel *> *)searchNoneSyncRecordWithUserId:(NSString *)userId;

#pragma mark - Delete

- (BOOL)deleteOneRecordWithUserId:(NSString *)userId
                         CourseId:(NSString *)courseId
                          PhaseId:(NSString *)phaseId
                         ModuleId:(NSString *)moduleId
                        SectionId:(NSString *)sectionId
                          VideoId:(NSString *)videoId;

- (BOOL)deleteAllRecordWithUserId:(NSString *)userId;

#pragma mark - Update

- (BOOL)updateSyncForAllNoneSyncRecordWithUserId:(NSString *)userId;
@end
