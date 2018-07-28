//
//  UIColor+BXG.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/13.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
extension UIColor {
    class var themeColor: UIColor {
        return UIColor.hexColor(hex: 0x466DE2)
    }
    
    static func hexColor(hex : Int) -> UIColor {
        
        let red = ((CGFloat)((hex & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hex & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hex & 0xFF))/255.0;
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    static func hexColor(hex : Int, alpha: CGFloat) -> UIColor {
        
        let red = ((CGFloat)((hex & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hex & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hex & 0xFF))/255.0;
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func random () -> UIColor {
        
        let r = CGFloat(Double(arc4random() % 256) / 255.0);
        let g = CGFloat(Double(arc4random() % 256) / 255.0);
        let b = CGFloat(Double(arc4random() % 256) / 255.0);
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
