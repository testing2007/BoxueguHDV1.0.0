//
//  BXGStudySectionExamViewModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/20.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

enum BXGStudySectionExamQuestionType: Int {
    case single = 0 // V
    case multiple = 1 // V
    case trueFalse = 2 // V
    case blank = 3
    case shortAnswer = 4
    case code = 5
    case apply = 6
}

let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

class BXGStudySectionExamAnswerModel {
    var answers: [Int: Bool]?
}

class BXGSectionExamOptionModel {
    var optionTitle: String?
    var optionPicture: String?
    
    var optionInitial: String?
    var optionIndex: Int?
}


class BXGSectionExamViewModel: NSObject {
    
    var courseModel: BXGStudyCourseModel
    var moduleModel: BXGCourseOutlineModuleModel
    var sectionModel: BXGCourseOutlineSectionModel
    
    var examModelList: [BXGSectionExamModel]?
    var examResultModel: BXGSectionExamResultModel?
    
    init(courseModel course: BXGStudyCourseModel, moduleModel module: BXGCourseOutlineModuleModel, sectionModel section: BXGCourseOutlineSectionModel) {
        courseModel = course
        moduleModel = module
        sectionModel = section
        super.init()
    }

    var examAnswerModelList: [BXGStudySectionExamAnswerModel]?

    func updateAnswerSubjectIndex(subjectIndex: Int, type: BXGStudySectionExamQuestionType, optionIndex: Int, selected: Bool) {
        switch type {
        case .single:
            if let list = self.examAnswerModelList {
                let answerModel = list[subjectIndex]
                var answers = [Int: Bool]()
                answers[optionIndex] = selected
                answerModel.answers = answers
            }
        case .multiple:
            if let list = self.examAnswerModelList {
                let answerModel = list[subjectIndex]
                
                if answerModel.answers == nil {
                    answerModel.answers = [Int: Bool]()
                }
                
                if var answers = answerModel.answers {
                    answers[optionIndex] = selected
                    answerModel.answers = answers
                }
            }
            
        case .trueFalse:
            if let list = self.examAnswerModelList {
                let answerModel = list[subjectIndex]
                var answers = [Int: Bool]()
                answers[optionIndex] = selected
                answerModel.answers = answers
            }
        default:break
        }
    }
    
    func loadAnswer(subjectIndex: Int) -> [Int: Bool]? {
        if let list = examAnswerModelList, subjectIndex < list.count,let answers = list[subjectIndex].answers  {
            return answers
        }else {
            return nil
        }
    }

    func requestSectionExam(moduleId: Int, sectionId: Int, finished: @escaping (_ succeed: Bool, _ message: String)->()) {
        BXGNetworkManager.request(api: BXGNetworkApp2API.courseTestSectionQuestionList(moduleId: moduleId, sectionId: sectionId)) { (response) in
            switch response {
            case .success(let status, let message, let result):
                
                if let examModels: [BXGSectionExamModel] = Mapper<BXGSectionExamModel>().mapArray(JSONObject: result) {
                    print(examModels)
                    for e in examModels {
                        self.parserExamModel(examModel: e)
                    }
                    self.examModelList = examModels
                    
//                    var examAnswerModelList: [BXGStudySectionExamAnswerModel]?
                    var resultModels = [BXGStudySectionExamAnswerModel]()
                    for _ in examModels {
                        resultModels.append(BXGStudySectionExamAnswerModel())
                    }
                    self.examAnswerModelList = resultModels
                    finished(true, "")
                    return
                }else {
                    self.examModelList = nil
                    self.examResultModel = nil
                }
                
                
                print("")
            case .failure(let error):
                self.examModelList = nil
            }
            finished(false, "")
        }
    }
    
    
    func postSectionExamAnswer(finished: @escaping (_ succeed: Bool, _ message: String?) -> ()) {
        
        guard let courseId = courseModel.id, let sectionId = sectionModel.sectionId else {
            return
        }
        
        guard let examModelList = examModelList, let examAnswerModelList = examAnswerModelList else {
            return
        }
        
        var answerSerializerArray = [Any]()
        
        for (index, examModel) in examModelList.enumerated() {
            let answerModel = examAnswerModelList[index]
            var result: String?
            if let answerMap = answerModel.answers {
                let sortedKeys = answerMap.keys.sorted { (key1, key2) -> Bool in
                    return key1 > key2
                }
                
                
                if let questionTyppe = examModel.questionType, let intValue = Int(questionTyppe), let type = BXGStudySectionExamQuestionType(rawValue: intValue) {
                    switch type {
                        
                    case .single:
                        var sigleResult: String? = nil
                        
                        for key in sortedKeys {
                            if answerMap[key] == true {
                                sigleResult = String(key)
                                break;
                            }
                        }
                        result = sigleResult
                        
                    case .multiple:
                        var multipleResult = [String]()
                        for key in sortedKeys {
                            if answerMap[key] == true {
                                multipleResult.append(String(key))
                            }
                        }
                        let json = JSON.init(multipleResult)
                        result = json.rawString()
                        
                    case .trueFalse:
                        var trueFalseResult: String? = nil
                        
                        for key in sortedKeys {
                            if answerMap[key] == true {
                                trueFalseResult = (key == 0) ? "对" : "错"
                                break;
                            }
                        }
                        result = trueFalseResult
                    default:
                        result = ""
                    }
                }
            }
            var resultDic = [String: Any]()
            resultDic["checkPointId"] = "\(examModel.checkPointId ?? 0)"
            resultDic["questionHistoryId"] = examModel.questionHistoryId
            resultDic["answer"] = result
            answerSerializerArray.append(resultDic)
        }
        let json = JSON.init(answerSerializerArray)
//        let answerSerializerArrayString = json.string ?? ""
        var answerSerializerArrayString: String? = nil
        do {

            if let data = try? JSONSerialization.data(withJSONObject: answerSerializerArray, options: .prettyPrinted) {
                answerSerializerArrayString = String.init(data: data, encoding: String.Encoding.utf8)
                answerSerializerArrayString = answerSerializerArrayString?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }

        }catch {

        }
        
        
        BXGNetworkManager.request(api: BXGNetworkApp2API.courseTestSectionSaveAnswer(courseId: courseId, sectionId: sectionId, answerInfos: answerSerializerArrayString ?? "")) { (response) in
            switch response {
            case .success(let status, let message, let result):
                let resultModel = Mapper<BXGSectionExamResultModel>().map(JSONObject: result)
                if let examList = resultModel?.sectionTestDetailVos {
                    for e in examList {
                        self.parserExamModel(examModel: e)
                    }
                }
                self.examResultModel = resultModel
                finished(true, "")
                return
                
            case .failure(let error):
                print()
            }
            finished(false, "")
        }
    }
    
    /// 解析题目模型
    ///
    /// - Parameter examModel: 题目模型
    func parserExamModel(examModel: BXGSectionExamModel) {
        
        if let questionTypeString = examModel.questionType,
            let questionTypeInt = Int(questionTypeString), let questionType = BXGStudySectionExamQuestionType(rawValue: questionTypeInt) {
            examModel.appQuestionType = questionType
        }else {
            examModel.appQuestionType = nil
        }
        
        if let questionHead = examModel.questionHead {
            examModel.appImageList = BXGHTMLParser.parserToSectionExamImageURL(withHTML: questionHead) as? [String]
            examModel.appQuestionHead = BXGHTMLParser.parserToSectionExamContentString(withHTML: questionHead)
        }
        
        if let optionsPicture = examModel.optionsPicture, let data = optionsPicture.data(using: String.Encoding.utf8) {
            do {
                examModel.appOptionsPicture = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String]
            }catch {
                
            }
        }
        
        if let options = examModel.options, let data = options.data(using: String.Encoding.utf8) {
            do {
                examModel.appOptions = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String]
            }catch {
                
            }
        }
        
        
        if let questionType = examModel.appQuestionType {
            
            if questionType == .single || questionType == .multiple {
                
                var optionModels = [BXGSectionExamOptionModel]()
                var optionIndex = 0
                
                while(optionIndex < examModel.appOptionsPicture?.count ?? 0 || optionIndex < examModel.appOptions?.count ?? 0) {
                    let model = BXGSectionExamOptionModel()
                    if let optionTitles = examModel.appOptions, optionIndex < optionTitles.count {
                        model.optionTitle = optionTitles[optionIndex]
                    }
                    
                    if let optionPictures = examModel.appOptionsPicture, optionIndex < optionPictures.count {
                        model.optionPicture = optionPictures[optionIndex]
                    }
                    optionModels.append(model)
                    optionIndex = optionIndex + 1
                }
                examModel.appOptionModels = optionModels
                
            }else if questionType == .trueFalse {
                
                var optionModels = [BXGSectionExamOptionModel]()
                for i in 0...1 {
                    let model = BXGSectionExamOptionModel()
                    
                    if i == 0 {
                        model.optionTitle = "对"
                    }else {
                        model.optionTitle = "错"
                    }
                    optionModels.append(model)
                }
                examModel.appOptionModels = optionModels
            }
        }
        
//        if let standardAnswer = examModel.standardAnswer, let data = standardAnswer.data(using: String.Encoding.utf8) {
//            do {
//                examModel.appStandardAnswers = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String]
//
//                if let _ = examModel.appStandardAnswers {
//
//                }else {
//                    if standardAnswer == "对" {
//                        examModel.appStandardAnswers = ["0"]
//                    }else if standardAnswer == "错"{
//                        examModel.appStandardAnswers = ["1"]
//                    }else {
//                        examModel.appStandardAnswers = [standardAnswer]
//                    }
//                }
//            }catch {
//
//            }
//        }else {
//            examModel.appStandardAnswers = [String]()
//        }
        if let standardAnswer = examModel.standardAnswer {
            if standardAnswer == "对" {
                examModel.appStandardAnswers = ["0"]
            }else if standardAnswer == "错"{
                examModel.appStandardAnswers = ["1"]
            }else {
                let json = JSON.init(parseJSON: standardAnswer)
                examModel.appAnswers = json.arrayObject as? [String]
            }
        }
        
        if let answer = examModel.answer {
            if answer == "对" {
                examModel.appAnswers = ["0"]
            }else if answer == "错"{
                examModel.appAnswers = ["1"]
            }else {
                let json = JSON.init(parseJSON: answer)
                examModel.appAnswers = json.arrayObject as? [String]
            }
        }
//        if let answer = examModel.answer, let data = answer.data(using: String.Encoding.utf8) {
//            do {
//                examModel.appAnswers = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String]
//
//                if let _ = examModel.appAnswers {
//
//                }else {
//                    if answer == "对" {
//                        examModel.appAnswers = ["0"]
//                    }else if answer == "错"{
//                        examModel.appAnswers = ["1"]
//                    }else {
//                        examModel.appAnswers = [answer]
//                    }
//                }
//            }catch {
//
//            }
//        }else {
//            examModel.appAnswers = [String]()
//        }
        
        if let solution = examModel.solution {
            examModel.appSolution = BXGHTMLParser.parserToSectionExamContentString(withHTML: solution)
            examModel.appSolutionImageList = BXGHTMLParser.parserToSectionExamImageURL(withHTML: solution) as? [String]
        }else {
            examModel.solution = "";
            examModel.appSolutionImageList = nil;
            examModel.appSolutionCodeList = nil;
        }


        print(examModel.appImageList)
    }
    
    func updateSectionExamState(section: Int, isPassed: Bool) {

        if let sectionTestStatus = sectionModel.sectionTestStatus {
            if sectionTestStatus != 1 && isPassed {
                sectionModel.sectionTestStatus = 1
            }
        }
    }
}
