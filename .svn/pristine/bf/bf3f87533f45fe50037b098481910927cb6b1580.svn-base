//
//  BXGCourseOutlineSectionHeaderView.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/20.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGCourseOutlineSectionHeaderView: UIView {
    
    public func installData(title: String, isOpen: Bool) {
        
        headerTitleLb.text = title
        
        if isOpen {
            open()
        }else {
            close()
        }
    }
    
    lazy var headerTitleLb: UILabel = {
        let item = UILabel()
        item.font = UIFont.pingFangSCRegular(withSize: 16)
        item.textColor = UIColor.hexColor(hex: 0x34495E)
        item.text = ""
        
        return item
    }()
    
    func open() {
        UIView.animate(withDuration: 5) {
            self.headerOpenStateImgV.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / -2), 0, 0, 1)
        }
    }
    
    func close() {
        UIView.animate(withDuration: 5) {
            self.headerOpenStateImgV.layer.transform = CATransform3DIdentity
        }
        
    }
    
    var tapClosure: (()->())?
    
    lazy var headerOpenStateImgV: UIImageView = {
        let item = UIImageView(image: UIImage(named: "course_outline_arrow_left")!)
        return item
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.hexColor(hex: 0xF6F9FC)
        
        installUI()
    }
    
    func installUI() {
        
        addSubview(headerTitleLb)
        addSubview(headerOpenStateImgV)
        
        headerTitleLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-40)
        }
        
        headerOpenStateImgV.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapView() {
        if let tap = tapClosure {
            tap()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
