//
//  BXGCourseViewModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/12.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit
import SwiftyJSON

import ObjectMapper

//[
//{
//    "phaseId": 219,
//    "phaseName": "阶段1 : UIKit基础",
//    "phaseRemark": null,
//    "createTime": null,
//    "phaseIsExtend": true,
//    "phaseLockStatus": 1,
//    "phaseStatus": 1,
//    "moduleAndPhaseHomeWorkList": [
//    {
//    "id": 85,
//    "type": 0,
//    "name": "1-1 iOS-研发模块",
//    "status": 0,
//    "startDate": "2018-04-19",
//    "hasApply": 1,
//    "couldTryLearn": 0,
//    "moduleStatus": 0,
//    "moduleProgress": "16.67",
//    "moduleVideoProgress": "20.22",
//    "moduleSectionFinished": 6,
//    "moduleSectionTotal": 36,
//    "moduleVideoFinished": 18,
//    "moduleVideoTotal": 89,
//    "currentPointName": "linux定时任务crontab",
//    "currentPointStudyTime": "2018-06-21 21:37:23",
//    "moduleDuration": 30,
//    "phaseHomeworkStatus": -2
//    },
//    {
//    "id": 96,
//    "type": 0,
//    "name": "1-2 分销2",
//    "status": -1,
//    "startDate": null,
//    "hasApply": 1,
//    "couldTryLearn": 0,
//    "moduleStatus": -1,
//    "moduleProgress": "0.00",
//    "moduleVideoProgress": "0.00",
//    "moduleSectionFinished": 0,
//    "moduleSectionTotal": 2,
//    "moduleVideoFinished": 0,
//    "moduleVideoTotal": 6,
//    "currentPointName": null,
//    "currentPointStudyTime": null,
//    "moduleDuration": 40,
//    "phaseHomeworkStatus": -2
//    },
//    {
//    "id": 196,
//    "type": 1,
//    "name": "1-3 UIKit基础-第1套试卷",
//    "status": -1,
//    "startDate": null,
//    "hasApply": 1,
//    "couldTryLearn": 0,
//    "moduleStatus": -1,
//    "moduleProgress": null,
//    "moduleVideoProgress": null,
//    "moduleSectionFinished": null,
//    "moduleSectionTotal": null,
//    "moduleVideoFinished": null,
//    "moduleVideoTotal": null,
//    "currentPointName": null,
//    "currentPointStudyTime": "2018-04-18 15:26:12",
//    "moduleDuration": null,
//    "phaseHomeworkStatus": -2
//    }
//    ]


class BXGCourseModuleModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        `id` <- map["id"]
        type <- map["type"]
        name <- map["name"]
        status <- map["status"]
        startDate <- map["startDate"]
        hasApply <- map["hasApply"]
        couldTryLearn <- map["couldTryLearn"]
        moduleStatus <- map["moduleStatus"]
        currentPointStudyTime <- map["moduleStatus"]
        phaseHomeworkStatus <- map["moduleStatus"]
        moduleVideoProgress <- map["moduleVideoProgress"]
        moduleProgress <- map["moduleProgress"]
    }
    
    
//    moduleProgress (string): 模块进度（百分比，不带‘%’号） ,
//    moduleStatus (integer): 学员模块状态：-1未开始、0进行中、1已完成 ,
//    moduleVideoProgress (string): 模块视频进度（百分比，不带‘%’号） ,
    
    var `id`: Int? // 196
    var type: Int? // 1
    var name: String? // "1-3 UIKit基础-第1套试卷"
    var status: Int? // -1
    var startDate: String?
    var hasApply: Int? //  1
    var couldTryLearn: Int? // 0
    var moduleStatus: Int? //
    
    var moduleVideoProgress: String?
    var moduleProgress: String?
    //    "moduleSectionFinished": null,
    //    "moduleSectionTotal": null,
    //    "moduleVideoFinished": null,
    //    "moduleVideoTotal": null,
    //    "currentPointName": null,
    var currentPointStudyTime: String? // "currentPointStudyTime": "2018-04-18 15:26:12",
    // "moduleDuration": null,
    var phaseHomeworkStatus: Int? // -2
    
}

class BXGCoursePhaseModel: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        phaseId <- map["phaseId"]
        phaseName <- map["phaseName"]
        phaseIsExtend <- map["phaseIsExtend"]
        phaseLockStatus <- map["phaseLockStatus"]
        phaseStatus <- map["phaseStatus"]
        moduleAndPhaseHomeWorkList <- map["moduleAndPhaseHomeWorkList"]
    }
    
    var phaseId: Int? // 219
    var phaseName: String? // "阶段1 : UIKit基础"
    // var phaseName: String? // null
    // var phaseRemark: String? // null
    // var createTime: String? // null
    var phaseIsExtend: Bool? // true
    var phaseLockStatus: Int? // 1
    var phaseStatus: Int? // 1
    var moduleAndPhaseHomeWorkList: Array<BXGCourseModuleModel>?

}


class BXGCourseProgressModel:Mappable {
    var dayHasStudy: String? // "122"
    var courseLearningProgress: String? // "0.00"
    var menuName: String? // "JS"
    var userCourseStatus: Int? // 1
    var dayLeftForService: String? // "243"
    var phaseDiagramList: [BXGCoursePhaseProgressModel]?
    var oldStuCourse: Bool? // true
    var courseName: String? // "前端就业课程【UI交稿用】"
    var courseType: Int? // 0
    var studentCourseId: Int? // 382
    var showPhaseExtend: Bool? // false
    var menuId: Int? // 251
    var courseId: Int? // 867
    var studentId: String? // "0d7f13bd166a4f7ebeddc3d113eea02f"
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        dayHasStudy <- map["dayHasStudy"]
        courseLearningProgress <- map["courseLearningProgress"]
        menuName <- map["menuName"]
        userCourseStatus <- map["userCourseStatus"]
        dayLeftForService <- map["dayLeftForService"]
        phaseDiagramList <- map["phaseDiagramList"]
        oldStuCourse <- map["oldStuCourse"]
        courseName <- map["courseName"]
        courseType <- map["courseType"]
        studentCourseId <- map["studentCourseId"]
        showPhaseExtend <- map["showPhaseExtend"]
        menuId <- map["menuId"]
        courseId <- map["courseId"]
        studentId <- map["studentId"]
        
    }
}

class BXGCoursePhaseProgressModel:Mappable {
    var stuPhaseStatus: Int? // 2
    var phaseName: String? // "开始"
    var phaseId: Int? // 88
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        stuPhaseStatus <- map["stuPhaseStatus"]
        phaseName <- map["phaseName"]
        phaseId <- map["phaseId"]
    }
}


//
//class BXGResultModelItem: Mappable  {
//
//}
//class BXGResultModel:Mappable  {
//
//
//
//}


class BXGCourseViewModel {
    
    public var courseModels: [BXGStudyCourseModel]?
    public var set: Set<Int> = Set<Int>()
    public var phaseModels :[BXGCoursePhaseModel]?
    public var courseProgressModel: BXGCourseProgressModel?

    
    public func requestQuerySDAndAggregation(courseId: Int, finished: @escaping (_ success: Bool,_ message: String) ->()) {
        BXGNetworkManager.request(api: BXGNetworkApp2API.courseStudyCenterQuerySDAndAggregation(courseId: courseId)) {[unowned self] (response) in
            switch response {
            case .success(let status, let message, let result):
                if(status == 200) {
                    let json = JSON(result)
                    let model = Mapper<BXGCourseProgressModel>().map(JSONObject: json.dictionaryObject)

                    self.courseProgressModel = model
                    finished(true, "成功")
                    
                }
            case .failure(let error):break;
                
            }
            finished(false, "失败")
        }
    }
    
    public func requestStudentApplyInformationPerfect(finished: @escaping (_ success: Bool,_ message: String) ->()) {
        BXGNetworkManager.request(api: BXGNetworkApp2API.courseStudyCenterStudentApplyInformationPerfect()) { (response) in
            switch response {
            case .success(let status, let message, let result):
                if(status == 200) {
                    if let b = JSON(result).bool, b {
                        // 成功
                        print("succeed")
                        finished(true, "成功")
                        return
                    }else {
                        finished(false, message)
                        return
                    }
                }
            case .failure(let error):break;
            finished(false, "网络异常")
                return
            }
        }
    }
    
    public func requestStudyRoute(courseId: Int, finished: @escaping (_ success: Bool, _ message: String) ->()) {
        
        BXGNetworkManager.request(api: BXGNetworkApp2API.courseStudyCenterQueryUserCourseStudyRoute(courseId: courseId)) { (response) in
            switch response {
            case .success(let status, let message, let result):
                // 需要在这里 解析 JSON 后返回出来
                if let list = result as? Array<Any> {
                    
                    let modelList = Mapper<BXGCoursePhaseModel>().mapArray(JSONObject: list)
                    
                    self.phaseModels = modelList
                    finished(true, "成功")
                    return
                }
                
            case .failure(let error):
                print("error")
            }
            self.phaseModels = nil
            finished(false, "失败")
            return
            
        }
    }
    
    public func requestStudyCourse(finished: @escaping (_ success: Bool,_ message: String) ->()) {
        
        BXGNetworkManager.request(api: BXGNetworkApp2API.courseStudyCenterEmploymentCourse()) { [unowned self](response) in
            var responseArrary = [BXGStudyCourseModel]()
            var requestFailed = false
            
            
            switch response {
            case .success(let status, _, let result):
                print(response)
                
                if (status == 200) {
                    
                    if let result = result {
                        let json = JSON(result).arrayObject
                        let any = Mapper<BXGStudyCourseModel>().mapArray(JSONObject: json)
                        
                        if let array = any {
                            for m in array {
                                m.type = .employmentCourse
                            }
                            responseArrary.append(contentsOf: array)
                        }
                    }
                }else {
                    requestFailed = true
                }
                
            case .failure(_):
                print(response)
                requestFailed = true
            }
            
            BXGNetworkManager.request(api: BXGNetworkApp2API.courseStudyCenterMicroCourse(pageNumber: 1, pageSize: 10000)) { (response) in
                switch response {
                case .success(let status, _, let result):
                    
                    if (status == 200) {
                        
                        if let result = result {
                            let json = JSON(result)
                            let json2 = json["list"]
                            
                            let any = Mapper<BXGStudyCourseModel>().mapArray(JSONObject: json2.arrayObject)
                            if let array = any {
                                for m in array {
                                    m.type = .microCourse
                                }
                                responseArrary.append(contentsOf: array)
                            }
                        }
                    }else {
                        requestFailed = true
                    }
                   
                    print(response)
                case .failure(_):
                    print(response)
                    requestFailed = true
                }
                
                // 回调
                if(responseArrary.count == 0 && requestFailed == true) {
                    
                    self.courseModels = nil
                    finished(false, "加载失败")
                }else {
                    
                    self.courseModels = responseArrary
                    finished(true, "")
                }
            }
        }
    }
}
