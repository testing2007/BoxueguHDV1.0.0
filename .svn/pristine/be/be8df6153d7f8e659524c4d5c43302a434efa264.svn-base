//
//  BXGCourseSectionModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/17.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

import ObjectMapper
class BXGCourseOutlineSectionModel: Mappable {
    
    var sectionId: Int?
    var sectionName: String? //
    // isTry = null
    var parentId: Int? //
    var isPass: Int? //
    var sort: Int? //
    var pointItems: [BXGCourseOutlinePointModel]?
    var isSectionTest: Int? //
    var isHomework: Int? //
    var sectionTestStatus: Int? //
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        sectionId <- map["sectionId"]
        sectionName <- map["sectionName"]
        parentId <- map["parentId"]
        isPass <- map["isPass"]
        sort <- map["sort"]
        pointItems <- map["pointItems"]
        isSectionTest <- map["isSectionTest"]
        isHomework <- map["isHomework"]
        sectionTestStatus <- map["sectionTestStatus"]
    }
}


