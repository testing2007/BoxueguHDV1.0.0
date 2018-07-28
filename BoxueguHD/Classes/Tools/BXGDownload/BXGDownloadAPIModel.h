//
//  BXGDownloadAPIModel.h
//  Demo
//
//  Created by apple on 2018/7/5.
//  Copyright © 2018年 com.bokecc.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BXGDownloadAPIModel : NSObject

@property (nonatomic, assign) int courseId;
@property (nonatomic, strong) NSString * _Nullable courseName;
@property (nonatomic, assign) int courseType;     //课程类型 就业班-1, 精品微课-2, 免费微课-3
@property (nonatomic, strong) NSString * _Nullable courseImageUrl; //课程图片Url
@property (nonatomic, assign) int phaseId;
@property (nonatomic, strong) NSString * _Nullable phaseName;
@property (nonatomic, assign) int phaseSort;
@property (nonatomic, assign) int moduleId;
@property (nonatomic, strong) NSString * _Nullable moduleName;
@property (nonatomic, assign) int moduleSort;
@property (nonatomic, assign) int sectionId;      //sectionId = 106625
@property (nonatomic, strong) NSString * _Nullable sectionName;    //sectionName: 考试要求
@property (nonatomic, assign) int sectionSort;    //sort: 42383
@property (nonatomic, assign) int sectionIsPass;  //isPass
@property (nonatomic, assign) int sectionIsTry;   //isTry
@property (nonatomic, assign) int pointId;        //pointId: 10050424
@property (nonatomic, strong) NSString * _Nullable pointName;      //pointName: 02-环境安装
@property (nonatomic, assign) int pointSort;      //sort: 79078
@property (nonatomic, assign) int videoId;        //videoId: 10050142
@property (nonatomic, strong) NSString * _Nullable ccVideoId;      //ccVideoId: B65A43879308369C9C33DC5901307461
@property (nonatomic, assign) BOOL watched;

//-(instancetype)init
-(NSString *_Nullable)generateCustomId;

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
                   andIsWatched:(BOOL)watched;
@end
