//
//  BXGLiveRoomViewModel.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
class BXGLiveRoomViewModel {
    
    let detailModel: BXGConstrueLiveModel
    let roomId: String
    
    init(detailModel fromDetailModel: BXGConstrueLiveModel, roomId fromRoomId: String) {
        detailModel = fromDetailModel
        roomId = fromRoomId
    }
}
