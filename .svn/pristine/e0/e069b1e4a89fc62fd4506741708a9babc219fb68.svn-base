//
//  BXGLivePlayerSelectRouteView.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/27.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGLivePlayerSelectRouteView: UIView {
    
    var routeCount: Int?
    var currentRoute: Int?
    lazy var btnList: [UIButton] = {
        return [UIButton]()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        installUI()
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
    }
    @objc public var selectRouteClosre: ((_ route: Int) -> ())?
//    var selectRateClosure: ((_ rate: Float) -> ())?
//    let rateList = [
//        ["des": "1.0X", "value": 1.0],
//        ["des": "1.25X", "value": 1.25],
//        ["des": "1.5X", "value": 1.5],
//        ["des": "2.0X", "value": 2.0],
//        ]
    
    
//    let rateValueList: [Float] = [1.0, 1.25, 1.5, 2.0]
    
//    init(routeCount fromRouteCount: Int, currentRoute fromCurrentRoute: Int) {
//        routeCount = fromRouteCount
//        currentRoute = fromCurrentRoute
//
//        super.init(frame: CGRect.zero)
//        installUI()
//        self.backgroundColor = UIColor.white
//        self.layer.cornerRadius = 3
//        self.layer.masksToBounds = true
//    }
    
    @objc public func installData(routeCount fromRouteCount: Int, currentRoute fromCurrentRoute: Int) {
        // unsinstall UI
        routeCount = fromRouteCount
        currentRoute = fromCurrentRoute
        
        for btn in btnList {
            btn.removeFromSuperview()
        }
        btnList.removeAll()
        installUI()
        setCurrentRoute(route: fromCurrentRoute)
    }
    
    func setCurrentRoute(route: Int) {

        for (index, value) in btnList.enumerated() {
            if route == index{
                value.setTitleColor(UIColor.themeColor, for: .normal)
            }else {
                value.setTitleColor(UIColor.hexColor(hex: 0x34495E), for: .normal)
            }
        }
        currentRoute = route
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func clickRateBtn(sender: UIButton?) {
        if let sender = sender {
            
            if let selectRouteClosre = selectRouteClosre {
                selectRouteClosre(sender.tag)
            }
        }
    }
    
    func installUI() {
        
        var lastView: UIView?
        
        for i in 0 ..< (routeCount ?? 0) {
            let btn = UIButton(type: .system)
            
            let titile = "线路\(i+1)"
            btn.setTitle(titile, for: UIControlState.normal)
            btn.tag = i
            
            btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 14)
            btn.setTitleColor(UIColor.hexColor(hex: 0x34495E), for: .normal)
            btn.addTarget(self, action: #selector(clickRateBtn(sender:)), for: .touchUpInside)
            self.addSubview(btn)
            if let lastView = lastView {
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(lastView.snp.bottom)
                }
            }else {
                btn.snp.makeConstraints { (make) in
                    make.top.equalToSuperview()
                }
            }
            
            btn.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.width.equalTo(53)
                make.height.equalTo(30)
            }
            
            if i == ((routeCount ?? 0) - 1) {
                btn.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview()
                }
            }
            btnList.append(btn)
            lastView = btn
        }
    }
    
}
