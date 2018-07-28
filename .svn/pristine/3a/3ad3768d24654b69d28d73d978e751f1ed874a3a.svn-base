//
//  BXGNetworkOnlineAPI.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/27.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Moya

class BXGNetworkOnlineAPIParserItem:Mappable {
    var success: Bool?
    var errorMessage: String?
    var resultObject: Any?
    
    //    init(jsonData: JSON) {
    //        success    = jsonData["success"].bool
    //        errorMessage = jsonData["errorMessage"].string
    //        resultObject  = jsonData["resultObject"]
    //    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        errorMessage <- map["errorMessage"]
        resultObject <- map["resultObject"]
    }
    
}

class BXGNetworkOnlineAPIParser: BXGNetworkAPIParser {
    
    func parse(_ data: Data) -> NetworkResponse {
        
        var status = 500
        var message = ""
        do {
            print("data: \(data)")
            // status
            let jsonData = try JSON(data: data)
            let item = Mapper<BXGNetworkApp01ParserItem>().map(JSONObject: jsonData.dictionaryObject)
            //            let item = BXGNetworkApp01ParserItem.init(jsonData: jsonData)
            
            if let item = item {
                if let success = item.success {
                    if(success) {
                        status = 200
                    }else {
                        status = 400
                    }
                }else {
                    message = "JSON解析错误"
                    status = 500
                }
                
                if let msg = item.errorMessage {
                    if(msg == "1001") {
                        status = 401
                        message = "用户已过期"
                    }else {
                        message = msg
                    }
                }else {
                    message = "";
                }
                
                print("item: \(item)")
                return .success(status: status, message: message, result: item.resultObject)
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

enum BXGNetworkOnlineAPI {
    case courseSearch(pageNumber: Int, keyword: String, searchCourseBelong: Int, pageSize: Int)
}

extension BXGNetworkOnlineAPI: BXGTargetType {
    var parser: BXGNetworkAPIParser {
        return BXGNetworkOnlineAPIParser()
    }
    
    var cachePolicy: NetworkCachePolicy {
        return .none
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .courseSearch(let pageNumber, let keyword, let searchCourseBelong, let pageSize):
            var para = [String: Any]()
            para["pageNumber"] = pageNumber
            para["keyword"] = keyword
            para["searchCourseBelong"] = searchCourseBelong
            para["pageSize"] = pageSize
            return para
        }
    }
    var requestMethod: BXGRequestMothod{
        return .get
    }
    
    var baseURL: URL {
        return BXGNetworkBaseURL.online.baseURL
    }
    
    var path: String {
        switch self {
        case .courseSearch:
            return "search/courseSearch"
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
