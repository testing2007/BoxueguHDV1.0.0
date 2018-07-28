//
//  BXGDownloadAPIModel.m
//  Demo
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import "BXGDownloadAPIModel.h"

@interface BXGDownloadAPIModel()
@end
@implementation BXGDownloadAPIModel

- (id)copyWithZone:(nullable NSZone *)zone {
    BXGDownloadAPIModel *copyObj = [BXGDownloadAPIModel allocWithZone:zone];
    copyObj.courseId = self.courseId;
    copyObj.courseName = self.courseName.copy;
    copyObj.courseType      = self.courseType;
    copyObj.phaseId =  self.phaseId;
    copyObj.phaseName = self.phaseName.copy;
    copyObj.phaseSort =  self.phaseSort;
    copyObj.moduleId = self.moduleId;
    copyObj.moduleName = self.moduleName.copy;
    copyObj.moduleSort = self.moduleSort;
    copyObj.sectionId      = self.sectionId;
    copyObj.sectionName   = self.sectionName.copy;
    copyObj.sectionSort   = self.sectionSort;
    copyObj.sectionIsPass  = self.sectionIsPass;
    copyObj.sectionIsTry   = self.sectionIsTry;
    copyObj.pointId       = self.pointId;
    copyObj.pointName     = self.pointName.copy;
    copyObj.pointSort      = self.pointSort;
    copyObj.videoId   = self.videoId;
    copyObj.ccVideoId =  self.ccVideoId;
    copyObj.watched = self.watched;
    return copyObj;
}
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    
    BXGDownloadAPIModel *copyObj = [BXGDownloadAPIModel allocWithZone:zone];
    copyObj.courseId = self.courseId;
    copyObj.courseName = self.courseName.mutableCopy;
    copyObj.courseType      = self.courseType;
    copyObj.phaseId =  self.phaseId;
    copyObj.phaseName = self.phaseName.mutableCopy;
    copyObj.phaseSort =  self.phaseSort;
    copyObj.moduleId = self.moduleId;
    copyObj.moduleName = self.moduleName.mutableCopy;
    copyObj.moduleSort = self.moduleSort;
    copyObj.sectionId      = self.sectionId;
    copyObj.sectionName   = self.sectionName.mutableCopy;
    copyObj.sectionSort   = self.sectionSort;
    copyObj.sectionIsPass  = self.sectionIsPass;
    copyObj.sectionIsTry   = self.sectionIsTry;
    copyObj.pointId       = self.pointId;
    copyObj.pointName     = self.pointName.mutableCopy;
    copyObj.pointSort      = self.pointSort;
    copyObj.videoId   = self.videoId;
    copyObj.ccVideoId =  self.ccVideoId;
    copyObj.watched = self.watched;
    
    return copyObj;
}

-(instancetype _Nullable )initWithCourseId:(int)courseId
                             andCourseName:(NSString* _Nonnull)courseName
                             andCourseType:(int)courseType
                         andCourseImageUrl:(NSString* _Nonnull)courseImageUrl
                                andPhaseId:(int)phaseId
                              andPhaseName:(NSString* _Nonnull)phaseName
                              andPhaseSort:(int)phaseSort
                               andModuleId:(int)moduleId
                             andModuleName:(NSString* _Nonnull)moduleName
                             andModuleSort:(int)moduleSort
                              andSectionId:(int)sectionId
                            andSectionName:(NSString* _Nonnull)sectionName
                            andSectionSort:(int)sectionSort
                          andSectionIsPass:(int)sectionIsPass
                           andSectionIsTry:(int)sectionIsTry
                                andPointId:(int)pointId
                              andPointName:(NSString* _Nonnull)pointName
                              andPointSort:(int)pointSort
                                andVideoId:(int)videoId
                              andCCVideoId:(NSString* _Nonnull)ccVideoId
                              andIsWatched:(BOOL)watched {
    self = [super init];
    if(self) {
        self.courseId = courseId;
        self.courseName = courseName;
        self.courseType      = courseType;
        self.courseImageUrl = courseImageUrl;
        self.phaseId =  phaseId;
        self.phaseName = phaseName;
        self.phaseSort =  phaseSort;
        self.moduleId = moduleId;
        self.moduleName = moduleName;
        self.moduleSort = moduleSort;
        self.sectionId      = sectionId;
        self.sectionName   = sectionName;
        self.sectionSort   = sectionSort;
        self.sectionIsPass  = sectionIsPass;
        self.sectionIsTry   = sectionIsTry;
        self.pointId       = pointId;
        self.pointName     = pointName;
        self.pointSort      = pointSort;
        self.videoId   = videoId;
        self.ccVideoId =  ccVideoId;
        self.watched = watched;
    }
    return self;
}

-(NSString * _Nullable)generateCustomId {
//    NSAssert(self.courseId!=nil, @"generateCustomId courseId is nil");
//    NSAssert(self.phaseId!=nil, @"generateCustomId phaseId is nil");
//    NSAssert(self.moduleId!=nil, @"generateCustomId moduleId is nil");
//    NSAssert(self.sectionId!=nil, @"generateCustomId sectionId is nil");
//    NSAssert(self.pointId!=nil, @"generateCustomId pointId is nil");
//    NSAssert(self.videoId!=nil, @"generateCustomId videoId is nil");
    return [[NSString alloc] initWithFormat:@"%d_%d_%d_%d_%d_%d_%@", self.courseId, self.phaseId, self.moduleId, self.sectionId, self.pointId, self.videoId, self.ccVideoId];
}

@end
