//
//  BXGCourseModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/12.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import ObjectMapper




class BXGStudyCourseModel:Mappable {
    
    enum BXGStudyCourseModelType {
        case employmentCourse
        case microCourse
    }
    
    var learnStatus: String? // "1"
    var totalModule: Int? // 2
    var firstModuleId: String? // "47"
    var stuLastStudyTime: String? // "2018-06-19 18:18"
    var smallImgPath: String? // "http:\/\/attachment-center.boxuegu.com\/data\/picture\/online\/2018\/03\/23\/10\/8dbe96ff42b44dc183d276df4bf56791.jpg"
    var hasStudyModule: Int? // 0
    var status: String? // "1"
    var courseName: String? // "xd测试免费微课xd测试免费微课xd测试免费微课xd测试免费微课"
    var `id`: Int? // 895
    var learningPercentPross: String? // "0.00"
    var terminateCause: String? // "-1"
    var menuId: Int? // 162 学科id
    var learningProgress: String? // "0\/2"
//    var lecturers: null ? // null
    
    var type:BXGStudyCourseModelType?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        learnStatus <- map["learnStatus"]
        totalModule <- map["totalModule"]
        firstModuleId <- map["firstModuleId"]
        stuLastStudyTime <- map["stuLastStudyTime"]
        smallImgPath <- map["smallImgPath"]
        hasStudyModule <- map["hasStudyModule"]
        status <- map["status"]
        courseName <- map["courseName"]
        `id` <- map["id"]
        learningPercentPross <- map["learningPercentPross"]
        terminateCause <- map["terminateCause"]
        menuId <- map["menuId"]
        learningProgress <- map["learningProgress"]
    }
}
