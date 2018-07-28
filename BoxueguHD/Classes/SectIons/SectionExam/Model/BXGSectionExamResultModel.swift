//
//  BXGStudySectionExamResultModel.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/21.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import ObjectMapper

class BXGSectionExamResultModel:Mappable {
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        rightQuestionCount <- map["rightQuestionCount"]
        totalQuestionCount <- map["totalQuestionCount"]
        advise <- map["advise"]
        id <- map["id"]
        courseId <- map["courseId"]
        accuracy <- map["accuracy"]
        sectionId <- map["sectionId"]
        sectionTestDetailVos <- map["sectionTestDetailVos"]
    }
    
    var rightQuestionCount: Float?
    var totalQuestionCount: Int?
    var advise: String?
    var id: Int?
    var courseId: Int?
    var accuracy: Int?
    var sectionId: Int?
    var sectionTestDetailVos: [BXGSectionExamModel]?
    

}


//@property (nonatomic, strong) NSString* rightQuestionCount;
//@property (nonatomic, strong) NSString* totalQuestionCount;
//@property (nonatomic, strong) NSString* advise; // 建议
//@property (nonatomic, strong) NSString* idx;
//@property (nonatomic, strong) NSString* courseId;
//@property (nonatomic, strong) NSString* accuracy;
//@property (nonatomic, strong) NSString* sectionId;
//@property (nonatomic, strong) NSArray<BXGStudySectionExamModel *>* sectionTestDetailVos;
