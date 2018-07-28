//
//  BXGDeviceMacro.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 itheima. All rights reserved.
//

import Foundation

public struct BXGDevice {
    static let IsRetina:Bool = UIScreen.main.scale>=2.0
    static let IsIPhone:Bool = ((UI_USER_INTERFACE_IDIOM() ==  .phone))
    static let IsIPad:Bool = {(UI_USER_INTERFACE_IDIOM() == .pad) || UIDevice.current.model.elementsEqual("iPad")}()
    
    static let ScreenWidth:double_t = double_t(min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
    static let ScreenHeight:double_t = double_t(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
    
    static let RelativeScreenWidth:double_t = double_t(UIScreen.main.bounds.size.width)
    static let RelativeScreenHeight:double_t = double_t(UIScreen.main.bounds.size.height)
    
    static let AbsoluteScreenWidth:double_t =  double_t(min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
    static let AbsoluteScreenHeight:double_t = double_t(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
    
    
    static let IsIPhone4OrLess = {BXGDevice.IsIPhone && AbsoluteScreenHeight < 568.0}()
    static let IsIPhone5 = {BXGDevice.IsIPhone && AbsoluteScreenHeight == 568.0}()
    static let IsIPhone6 = {BXGDevice.IsIPhone && AbsoluteScreenHeight == 667.0}()
    static let IsIPhone6Plus = {BXGDevice.IsIPhone && AbsoluteScreenHeight == 736.0}()
    static let IsIPhoneX = {BXGDevice.IsIPhone && AbsoluteScreenHeight == 812.0}()
    
    static let NaviBarOffset = { ()->double_t in return BXGDevice.IsIPhoneX ? 88 : 64 }()
    static let StatusBarOffset = { ()->double_t in return BXGDevice.IsIPhoneX ? 44 : 20 }()
    static let BottomSafeOffset = { ()->double_t in return BXGDevice.IsIPhoneX ? 34 : 0 }()
    
    static let ToolBarHeight = 44
}
