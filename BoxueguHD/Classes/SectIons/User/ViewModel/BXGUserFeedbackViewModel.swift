//
//  BXGUserFeedbackViewModel.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGUserFeedbackViewModel {
    func postFeedback(text: String, mobile: String?, finished: @escaping (_ succeed: Bool, _ message: String?) ->()) {
        BXGNetworkManager.request(api: BXGNetworkApp1API.postFeedback(text: text, mobile: mobile)) { (response) in
            switch response {
            case .success(let status, let message, let result):
                if status == 200 {
                    finished(true, message)
                    return
                }else {
                    finished(false, message)
                }
            case .failure(_):
                finished(false, "网络异常")
            }
        }
    }
}
