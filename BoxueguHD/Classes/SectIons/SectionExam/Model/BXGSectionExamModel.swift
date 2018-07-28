//
//  BXGSectionExamModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/20.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import ObjectMapper

class BXGSectionExamModel: Mappable {
    var checkPointId: Int? //
    var questionHistoryId: String? //
    var questionHead: String? //
    var questionHeadText: String? //
    var options: String? //
    var optionsPicture: String? //
    var questionType: String? //
    var result: Bool?
    var filePath: String? //
    var questionFileName: String? //
    var questionFileFormat: String? //
    var standardAnswer: String?
    var answer: String?
    var solution: String?
    
    // parser
    var appQuestionType: BXGStudySectionExamQuestionType?
    var appImageList: [String]?
    var appQuestionHead: String? // HTML string
    var appCodeList: [String]?
    var appOptions: [String]?
    var appOptionsPicture: [String]? // URL String
    var appAnswers: [String]?
    var appStandardAnswers: [String]?
    var appSolution: String?
    var appSolutionImageList: [String]?
    var appSolutionCodeList: [String]?
    var appOptionModels: [BXGSectionExamOptionModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        checkPointId <- map["checkPointId"]
        questionHistoryId <- map["questionHistoryId"]
        questionHead <- map["questionHead"]
        questionHeadText <- map["questionHeadText"]
        options <- map["options"]
        optionsPicture <- map["optionsPicture"]
        questionType <- map["questionType"]
        result <- map["result"]
        filePath <- map["filePath"]
        questionFileName <- map["questionFileName"]
        questionFileFormat <- map["questionFileFormat"]
        standardAnswer <- map["standardAnswer"]
        answer <- map["answer"]
        solution <- map["solution"]
    }
}


//    "studentId": null,
//    "orderDetailId": null,
//    "courseId": null,
//    "sectionId": null,
//    "creator": null,
//    "operator": null,
//    "stuCourseId": null,
//    "userAnswer": null,
//    "solution": null,
//    "standardAnswer": null,
//    "studentSectionTestId": null,



//    "checkPointId": 190,
//    "questionHistoryId": "9d9a81fec82f4cb1bb0c75f8bf354510",
//    "questionHead": "<p>1+1=</p>\r\n\r\n<p><img alt=\"\" src=\"http://attachment-center.boxuegu.com/data/picture/online/2018/04/03/14/f1b76169a5a54b9cbeecea609c0b050a.jpg\" style=\"width: 360px; height: 360px;\" /></p>",
//    "questionHeadText": "1+1=",
//    "options": "[\"1\",\"2\",\"3\",\"4\"]",
//    "optionsPicture": "[\"http://attachment-center.boxuegu.com/data/attachment/online/2018/04/03/14/53f9daedb3ed48858b9059d369ee2874.jpg\",\"http://attachment-center.boxuegu.com/data/attachment/online/2018/04/03/14/71a658bdb6e14b09b5e0674f8c708fc7.jpg\",\"http://attachment-center.boxuegu.com/data/attachment/online/2018/04/03/14/ce333018643f4eeba7559a176db3329d.jpg\",\"http://attachment-center.boxuegu.com/data/attachment/online/2018/04/03/14/ae500731aca84591b9bcad699aa8d33c.jpg\"]",
//    "answer": null,
//    "questionType": "0",
//    "studentId": null,
//    "orderDetailId": null,
//    "courseId": null,
//    "sectionId": null,
//    "studentSectionTestId": null,
//    "result": false,
//    "creator": null,
//    "operator": null,
//    "stuCourseId": null,
//    "userAnswer": null,
//    "solution": null,
//    "standardAnswer": null,
//    "filePath": "http://attachment-center.boxuegu.com/data/attachment/online/2018/04/03/14/c2349bfcd5644104820dd2b96c23b35f.jpg",
//    "questionFileName": "QQ图片20180330151227.jpg",
//    "questionFileFormat": "jpg"



