//
//  BXGHUDTool.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/16.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import MBProgressHUD
class BXGHUDTool {
    
    static weak var currentHUD: MBProgressHUD?
    class func showHUD(string: String) {
        
        
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.mode = .text
        hud.margin = 13;
        hud.isUserInteractionEnabled = true;
        hud.removeFromSuperViewOnHide = true;
        hud.detailsLabelFont = UIFont.pingFangSCMedium(withSize: 16)
        hud.detailsLabelColor = UIColor.hexColor(hex: 0xf5f5f5)
        hud.detailsLabelText = string;
        
        currentHUD = hud;
        hud.hide(animated: true, afterDelay: 1.2)
    }
    
    class func showLoadingHUD(string: String) {
        
        
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.mode = .indeterminate
        hud.margin = 13;
        hud.isUserInteractionEnabled = true;
        hud.removeFromSuperViewOnHide = true;
        hud.detailsLabelFont = UIFont.pingFangSCMedium(withSize: 16)
        hud.detailsLabelColor = UIColor.hexColor(hex: 0xf5f5f5)
        hud.detailsLabelText = string;
        
                currentHUD = hud;
        //        hud.hide(animated: true, afterDelay: 1.2)
    }
    
    class func closeHUD() {
        if let hud = currentHUD {
            hud.hide(animated: true)
        }
    }
}
