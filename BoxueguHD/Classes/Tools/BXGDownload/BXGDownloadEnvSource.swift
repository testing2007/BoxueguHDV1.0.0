//
//  BXGDownloadManager.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/19.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

class BXGDownloadEnvSource: NSObject {
    @objc static let instance:BXGDownloadEnvSource = BXGDownloadEnvSource()
    
    @objc func userId() -> String {
        return BXGUserCenter.shared.userModel?.user_id ?? ""
    }
    
    @objc func ccUserId()->String {
        return BXGUserCenter.shared.userModel?.cc_user_id ?? ""
    }
    
    @objc func ccAPIKey()->String {
        return BXGUserCenter.shared.userModel?.cc_api_key ?? ""
    }
}
