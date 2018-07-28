//
//  BXGDownloadedDetailBottomView.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

protocol BXGDownloadedDetailBottomViewDelegate : AnyObject {
    func onSelectAll() -> Void;
    func onDeselectAll() -> Void;
    func onDelete() -> Void;
}

class BXGDownloadedDetailBottomView: UIView {

    weak var delegate:BXGDownloadedDetailBottomViewDelegate?
    
    override init(frame:CGRect) {
        super.init(frame: frame);
        self.installUI();
    }
    
    func installUI()->Void {
        self.addSubview(self.allSelectBtn)
        self.addSubview(self.deleteBtn)
        self.addSubview(self.seperateLineView)
        
        self.allSelectBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(self.snp.width).dividedBy(2)
        }
        self.deleteBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.allSelectBtn.snp.right).offset(0);
            make.top.right.bottom.equalTo(0);
        }
        self.seperateLineView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.center.equalTo(self)
            make.width.equalTo(1)
        }
    }
    
    lazy var allSelectBtn:UIButton = {
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.addTarget(self, action: #selector(BXGDownloadedDetailBottomView.onSelect), for: UIControlEvents.touchUpInside)
        btn.setTitle("全选", for: .normal)
        btn.setTitle("取消全选", for: .selected)
        btn.setTitleColor(UIColor.hexColor(hex: 0x34495E), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 15)
        return btn
    }()
    
    @objc func onSelect() -> Void {
        allSelectBtn.isSelected = !allSelectBtn.isSelected
        if(allSelectBtn.isSelected) {
            delegate?.onSelectAll()
        } else {
            delegate?.onDeselectAll()
        }
    }
    
    lazy var deleteBtn:UIButton = {
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.addTarget(self, action: #selector(BXGDownloadedDetailBottomView.onDelete), for: UIControlEvents.touchUpInside)
        btn.setTitle("删除", for: .normal)
        btn.setTitleColor(UIColor.hexColor(hex: 0x466DE2), for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 15)
        return btn
    }()
    
    @objc func onDelete() -> Void {
        print("onDelete")
        delegate?.onDelete()
    }
    
    lazy var seperateLineView:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xE4E8EB)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
