//
//  BXGNetworkQALibAPI.m
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/5.
//  Copyright © 2018年 boxuegu. All rights reserved.
//

#import "BXGNetworkQALibAPI.h"

@implementation BXGNetworkQALibAPI
/**
 问答-评价问题 /questionRepository/evaluationQuestion
 
 @param questionId 问题id
 @param starLevel     评价星级
 @param solveStatus 是否解决(UNSOLVED：未解决，SOLVED：已解决)
 @param content     内容
 @param finished  finished
 */
//- (void)questionSpriteRequestEvaluationQuestionWithQuestionId:(NSString* _Nullable)questionId
//                                                    starLevel:(NSString* _Nullable)starLevel
//                                                  solveStatus:(NSString* _Nullable)solveStatus
//                                                      content:(NSString* _Nullable)content //评价内容
//                                                     Finished:(BXGNetworkCallbackBlockType _Nullable)finished;

/**
 问答-是否拥有问答权限 /questionElf/checkQuestionPermission
 
 @param courseId 课程id, 多个课程id 可以使用逗号隔开
 @param finished 回调函数
 */
//- (void)questionSpriteRequestCheckQuestionPermissionWithCourseId:(NSString* _Nullable)courseId
//                                                        Finished:(BXGNetworkCallbackBlockType _Nullable)finished;
@end
