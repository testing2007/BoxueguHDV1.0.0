//
//  UIView+Extension.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/21.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

extension UIView {
    var viewController: UIViewController? {
        
        var nextView: UIView? = self.superview
        while let next = nextView  {
            
            if let viewController = next.next as? UIViewController {
                return viewController
            }
            
            nextView = next.superview
        }
        return nil
    }
}
