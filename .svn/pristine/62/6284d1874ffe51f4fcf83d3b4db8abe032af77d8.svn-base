//
//  BXGDownloadSelectBottomView.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/18.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

protocol BXGDownloadSelectBottomViewDelegate : AnyObject {
    func onConfirmDownload() -> Void;
}

class BXGDownloadSelectBottomView: UIView {

    weak var delegate:BXGDownloadSelectBottomViewDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI() {
        self.addSubview(self.totalAndAvailableSpaceLabel);
        self.addSubview(self.seperateLineView);
        self.addSubview(self.confirmDownloadBtn);
        
        self.confirmDownloadBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(0)
            make.width.equalTo(190)
        }
        self.seperateLineView.snp.makeConstraints { (make) in
            make.right.equalTo(self.confirmDownloadBtn.snp.left).offset(0)
            make.top.bottom.equalTo(0)
            make.width.equalTo(1);
        }
        self.totalAndAvailableSpaceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.top.bottom.equalTo(0)
            make.centerY.equalToSuperview()
        }
    }
    
    lazy var totalAndAvailableSpaceLabel:UILabel = {
        let label:UILabel = UILabel()
        label.textColor = UIColor.hexColor(hex: 0x34495E)
        label.font = UIFont.pingFangSCRegular(withSize: 12)
        return label
    }()
    
    lazy var seperateLineView:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xE4E8EB)
        return view
    }()
    
    lazy var confirmDownloadBtn:UIButton = {
        let btn:UIButton = UIButton(type: .custom)
        btn.setTitle("确定下载", for: .normal)
        btn.titleLabel?.font = UIFont.pingFangSCRegular(withSize: 15)
//        btn.titleLabel?.textColor = UIColor.hexColor(hex: 0x466DE2)
        btn.setTitleColor(UIColor.hexColor(hex: 0x466DE2), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(BXGDownloadSelectBottomView.onConfirmDownload),
                      for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    @objc func onConfirmDownload() {
        delegate?.onConfirmDownload()
    }
    
}
