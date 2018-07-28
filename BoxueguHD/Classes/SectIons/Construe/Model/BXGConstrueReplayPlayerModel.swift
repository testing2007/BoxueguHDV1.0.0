//
//  BXGConstrueReplayPlayerModel.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import ObjectMapper
class BXGConstrueReplayPlayerModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        recordVideoId <- map["recordVideoId"]
    }
    
    var name: String?
    var recordVideoId: String?
    
    
}
