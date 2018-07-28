//
//  BXGNetworkApp2API.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/12.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Moya

///courseStudyCenter/getStudentEmploymentCourse

class BXGApp2APIParserItem: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
        errorMessage <- map["errorMessage"]
    }
    
    
    var status: Int?
    var message: String?
    var result: Any?
    var errorMessage: String?
    
//    init(jsonData: JSON) {
//        status    = jsonData["status"].int
//        message = jsonData["message"].string
//        result  = jsonData["result"]
//        errorMessage = jsonData["errorMessage"].string
//    }
}

class BXGApp2APIParser: BXGNetworkAPIParser {
    
    func parse(_ data: Data) -> NetworkResponse {
        
        var status = 500
        var message = ""
        do {
            print("data: \(data)")
            // status
            let jsonData = try JSON(data: data)
            
            if let item = Mapper<BXGApp2APIParserItem>().map(JSONObject: jsonData.dictionaryObject) {
                if let itemStatus = item.status  {
                    if(itemStatus == 401 || itemStatus == 1001) {
                        status = 401
                    }else {
                        status = itemStatus
                    }
                }
                
                if let errorMsg = item.errorMessage {
                    if errorMsg == "1001" {
                        status = 401
                    }
                }
                
                if status == 401 {
                    message = "用户已过期"
                }else {
                    if let itemMessage = item.message {
                        message = itemMessage
                    }else {
                        message = ""
                    }
                }
                return .success(status: status, message: message, result: item.result)
            }else {
                status = 500
                message = "JSON解析错误"
                print("\(status)\n\(message)\n")
                return .success(status: 500, message: message, result: nil)
            }

        }catch {
            // json 解析错误
            status = 500
            message = "JSON解析错误"
            print("\(status)\n\(message)\n")
            return .success(status: 500, message: message, result: nil)
        }
    }
}


enum BXGNetworkApp2API {
    case courseStudyCenterEmploymentCourse()
    case courseStudyCenterMicroCourse(pageNumber: Int, pageSize: Int)
    case courseStudyCenterStudentApplyInformationPerfect()
    case courseStudyCenterQuerySDAndAggregation(courseId: Int)
    case courseStudyCenterQueryUserCourseStudyRoute(courseId: Int)
    
    case coursePlayCouseKnowledgeTree(courseId: Int, moduleId: Int, isTry: Bool)
    case courseTestSectionQuestionList(moduleId: Int, sectionId: Int)
    case courseTestSectionSaveAnswer(courseId: Int, sectionId: Int, answerInfos: String)
    
    case construeReplay(pageNo: String?, pageSize: String?, day: String?)   // 回放列表
    // 读取小节测试题

    
    // 直播
//    /bxg/appConstruePlan/getConstruePlanByDay
//    para[@"menuId"] = menuId; // nil
//    para[@"day"] = day;
    
    
    /// 直播: 获取直播状态 /bxg/appConstruePlan/checkPlanStatusById
//    - (void)appRequestConstrueCheckStatusWithPlanId:(NSString * _Nullable)planId
//    Finished:(BXGNetworkCallbackBlockType _Nullable)finished {
//    // para
//    NSMutableDictionary *para = [NSMutableDictionary new];
//    para[@"planId"] = planId;
//
//    // url
//    NSString *url = @"/bxg/appConstruePlan/checkPlanStatusById";
//
//    // request
//    [self appBaseRequestType:POST andURLString:url andParameter:para andFinished:finished];
//    }
    
    /// 直播: 月计划显示列表
//    - (void)appRequestConstruePlanByMonthWithMenuId:(NSString * _Nullable)menuId
//    Finished:(BXGNetworkCallbackBlockType _Nullable)finished {
//
//    // para
//    NSMutableDictionary *para = [NSMutableDictionary new];
//    para[@"menuId"] = menuId;
//
//    // url
//    NSString *url = @"/bxg/appConstruePlan/getConstruePlanByMonth";
//
//    // request
//    [self appBaseRequestType:POST andURLString:url andParameter:para andFinished:finished];
//    }

    
//    NSMutableDictionary *para = [NSMutableDictionary new];
//    para[@"pageNo"] = pageNo; // 可nil
//    para[@"pageSize"] = pageSize; // 可nil

//    para[@"day"] = day;   // 可nil
//
//    // url
//    NSString *url = @"/bxg/appConstruePlan/getLiveCallback";
    
}

extension BXGNetworkApp2API: BXGTargetType {
    
    var parameters: [String : Any]? {
        switch self {
        case .courseStudyCenterEmploymentCourse:
            return nil
            
        case let .courseStudyCenterMicroCourse(pageNumber: pageNumber, pageSize: pageSize):
            return ["pageNumber": pageNumber, "pageSize": pageSize]

        case .courseStudyCenterStudentApplyInformationPerfect:
            return nil
            
        case .courseStudyCenterQuerySDAndAggregation(let courseId):
            return ["courseId": courseId]
            
        case .courseStudyCenterQueryUserCourseStudyRoute(let courseId):
            return ["courseId": courseId]
            
        case .coursePlayCouseKnowledgeTree(let courseId, let moduleId, let isTry):
            return ["courseId": courseId, "moduleId":moduleId, "isTry":isTry]
            
        case .courseTestSectionQuestionList(let moduleId, let sectionId):
            return ["moduleId":moduleId, "sectionId": sectionId]
            
        case .courseTestSectionSaveAnswer(let courseId, let sectionId, let answerInfos):
            return ["courseId": courseId, "sectionId": sectionId, "answerInfos": answerInfos]
        
        case let .construeReplay(pageNo, pageSize, day):
        var para = [String:Any]()
        para["pageNo"] = pageNo
        para["pageSize"] = pageSize
        para["day"] = day
        return para
        }
//            return ["courseId": courseId, "sectionId": sectionId]

    }
    
    var path: String {
        switch self {
        case .courseStudyCenterEmploymentCourse:
            return "/courseStudyCenter/getStudentEmploymentCourse"
            
        case .courseStudyCenterMicroCourse:
            return "/courseStudyCenter/getStudentMicroCourse"
            
        case .courseStudyCenterStudentApplyInformationPerfect:
            return "/courseStudyCenter/studentApplyInformationPerfect"
            
        case .courseStudyCenterQuerySDAndAggregation:
            return "/courseStudyCenter/querySDAndAggregation"
            
        case .courseStudyCenterQueryUserCourseStudyRoute:
            return "/courseStudyCenter/queryUserCourseStudyRoute"
            
        case .coursePlayCouseKnowledgeTree:
            return "/coursePlay/getCourseKnowledgeTree"
            
        case .courseTestSectionQuestionList:
            return "/bxg/test/section/question/list"
            
        case .courseTestSectionSaveAnswer:
            return "/bxg/test/section/answer/save"
            
        case .construeReplay:
            return "/bxg/appConstruePlan/getLiveCallback"
        }
    }
    
    var parser: BXGNetworkAPIParser {
        return BXGApp2APIParser()
    }
    
    var cachePolicy: NetworkCachePolicy {
        return .none
    }
    
    var baseURL: URL { // 这个替换成 url
        return BXGNetworkBaseURL.app.baseURL
    }
    
    var headers: [String : String]? {
        return nil
    }

}

