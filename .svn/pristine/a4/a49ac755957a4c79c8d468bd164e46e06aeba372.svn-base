//
//  BXGVODPlayerSelectRateView.swift
//  BoxueguHD
//
//  Created by mynSoo Wu on 2018/7/26.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGVODPlayerSelectRateView: UIView {
    
    var selectRateClosure: ((_ rate: Float) -> ())?
    let rateList = [
        ["des": "1.0X", "value": 1.0],
        ["des": "1.25X", "value": 1.25],
        ["des": "1.5X", "value": 1.5],
        ["des": "2.0X", "value": 2.0],
        ]
    
    
    let rateValueList: [Float] = [1.0, 1.25, 1.5, 2.0]
    lazy var btnList: [UIButton] = {
        return [UIButton]()
    }()
    init() {
        
        super.init(frame: CGRect.zero)
        installUI()
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
    }
    
    func setCurrentRate(rate: Float) {
        
        var rateIndex: Int?
        for (index, _) in rateValueList.enumerated() {
            if  rateValueList[index] == rate {
                rateIndex = index
                break;
            }
        }
        
        
        for (index, value) in btnList.enumerated() {
            if let rateIndex = rateIndex, rateIndex == index{
                value.setTitleColor(UIColor.themeColor, for: .normal)
            }else {
                value.setTitleColor(UIColor.hexColor(hex: 0x34495E), for: .normal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func clickRateBtn(sender: UIButton?) {
        if let sender = sender {
            
            if let selectRateClosure = selectRateClosure {
                let rate = rateValueList[sender.tag]
                selectRateClosure(rate)
            }
        }
    }
    
    func installUI() {
        
        var lastView: UIView?
        for (index, _) in rateList.enumerated() {
            let btn = UIButton(type: .system)
            let titile = rateList[index]["des"] as? String
            btn.setTitle(titile, for: UIControlState.normal)
            btn.tag = index
            
            //            font-family: PingFangSC-Regular;
            //            font-size: 28px;
            //            color: #34495E;
            
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
            
            if index == (rateList.count - 1) {
                btn.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview()
                }
            }
            btnList.append(btn)
            lastView = btn
        }
    }
    
}
