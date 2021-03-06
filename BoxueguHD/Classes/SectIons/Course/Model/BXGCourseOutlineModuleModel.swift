//
//  BXGCourseModuleModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/17.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

import ObjectMapper

class BXGCourseOutlineModuleModel: Mappable {
    
    var moduleId: Int?
    var nextType: Int? //
    var nextModuleId: Int? //
    var phaseHomeworkId: Int? // null
    var phaseHomeworkStatus: Int? //
    var phaseId: Int? //
    var moduleName: String? //
    var studentCourseId: Int? //
    var sort: Int? //
    var phaseSort: Int? //
    var mentId: Int? //
    var mentName: Int? //
    var duration: Int? //
    var sectionItems: [BXGCourseOutlineSectionModel]? //
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        moduleId <- map["moduleId"]
        nextType <- map["nextType"]
        nextModuleId <- map["nextModuleId"]
        phaseHomeworkId <- map["phaseHomeworkId"]
        phaseHomeworkStatus <- map["phaseHomeworkStatus"]
        phaseId <- map["phaseId"]
        moduleName <- map["moduleName"]
        studentCourseId <- map["studentCourseId"]
        sort <- map["sort"]
        phaseSort <- map["phaseSort"]
        mentId <- map["mentId"]
        mentName <- map["mentName"]
        duration <- map["duration"]
        sectionItems <- map["sectionItems"]
    }
}

//"moduleId": 17,
//"nextType": 0,
//"nextModuleId": 83,
//"phaseHomeworkId": null,
//"phaseHomeworkStatus": 0,
//"phaseId": 11,
//"moduleName": "新增模块（转转）",
//"studentCourseId": 434,
//"sort": 4,
//"phaseSort": 1,
//"mentId": 145,
//"mentName": "Java",
//"duration": 12,

